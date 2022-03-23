import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/models/jelo_model.dart';
import 'package:monets/models/jelo_rezervacija_model.dart';
import 'package:monets/models/rezervacija_model.dart';
import 'package:monets/models/rezervacija_search_model.dart';
import 'package:monets/services/http_service.dart';

class FoodDetails extends StatefulWidget {
  final JeloModel jelo;
  late bool dropdownShown = false;

  FoodDetails({Key? key, required this.jelo}) : super(key: key);

  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  double? _ratingValue = 0;
  double? ukupanRejting = 0;
  double? klijentovRejting = 0;
  late bool isFavourite = false;
  int kolicina = 1;

  late RezervacijaModel odabranaRezervacija = RezervacijaModel.dropdown(
      0, "Odaberite rezervaciju u koju zelite dodati jelo");
  late List<RezervacijaModel> rezervacije = <RezervacijaModel>[
    RezervacijaModel.dropdown(
        0, "Odaberite rezervaciju u koju zelite dodati jelo")
  ];

  @override
  void initState() {
    checkIfFavourite();
    odabranaRezervacija = rezervacije[0];
    getRezervacije();
    getUkupanRejtingZaJelo();
    getKlijentovRejtingZaJelo();
  }

  void getRezervacije() async {
    var rezervacijeList = await HttpService.getRezervacije(
        RezervacijaSearchModel("", true, 0, true));
    setState(() {
      rezervacije += rezervacijeList as List<RezervacijaModel>;
      odabranaRezervacija = rezervacije[0];
    });
  }

  getUkupanRejtingZaJelo() async {
    var ukupanRejtingTemp =
        await HttpService.getUkupanRejtingZaJelo(widget.jelo.jeloId!);
    setState(() {
      ukupanRejting = ukupanRejtingTemp;
    });
  }

  getKlijentovRejtingZaJelo() async {
    var klijentovRejtingTemp =
        await HttpService.getKlijentovRejtingZaJelo(widget.jelo.jeloId!);
    setState(() {
      klijentovRejting = klijentovRejtingTemp.first.ocjena;
    });
  }

  void checkIfFavourite() async {
    var jelo = await HttpService.provjeriJeLiJeloFavorit(widget.jelo.jeloId!);
    setState(() {
      if (jelo != null) {
        isFavourite = true;
      } else {
        isFavourite = false;
      }
    });
  }

  void dodajJeloUFavorite(int jeloId) async {
    await HttpService.dodajJeloUFavorite(jeloId);
    checkIfFavourite();
  }

  void ukloniJeloIzFavorita(int jeloId) async {
    await HttpService.ukloniJeloIzFavorita(jeloId);
    checkIfFavourite();
  }

  void smanjiKolicinu() {
    setState(() {
      if (kolicina - 1 > 0) {
        kolicina -= 1;
      }
    });
  }

  void povecajKolicinu() {
    setState(() {
      if (kolicina + 1 < 20) {
        kolicina += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: ColorPallete.yellow,
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 10.0),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 35.0,
                              )),
                          const Spacer(),
                          this.isFavourite
                              ? GestureDetector(
                                  onTap: () async {
                                    ukloniJeloIzFavorita(widget.jelo.jeloId!);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      backgroundColor: ColorPallete.purple,
                                      duration: Duration(milliseconds: 1000),
                                      content:
                                          Text("Jelo uklonjeno iz favorita"),
                                    ));
                                  },
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.black,
                                    size: 35.0,
                                  ))
                              : GestureDetector(
                                  onTap: () async {
                                    dodajJeloUFavorite(widget.jelo.jeloId!);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      backgroundColor: ColorPallete.purple,
                                      duration: Duration(milliseconds: 1000),
                                      content: Text("Jelo dodano u favorite"),
                                    ));
                                  },
                                  child: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.black,
                                    size: 35.0,
                                  )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         getFoodImage(widget.jelo),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text(
                        widget.jelo.nazivJela!,
                        style: const TextStyle(
                            color: ColorPallete.purple,
                            fontFamily: "Avenir-Medium",
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    widget.jelo.opisJela!,
                    style: const TextStyle(
                        color: Colors.black38,
                        fontFamily: "Avenir-Medium",
                        fontWeight: FontWeight.w500,
                        letterSpacing: -1.0,
                        fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xffF2F2F3),
                height: 40.0,
                child: const Text(
                  "Odaberite količinu",
                  style: TextStyle(
                      fontFamily: "Avenir-Medium",
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                      color: ColorPallete.purple),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => {smanjiKolicinu()},
                  child: const Icon(
                    Icons.remove_circle_outline,
                    size: 28.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    kolicina.toString(),
                    style: const TextStyle(fontSize: 28.0),
                  ),
                ),
                GestureDetector(
                  onTap: () => {povecajKolicinu()},
                  child: const Icon(Icons.add_circle_outline, size: 28.0),
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    (widget.jelo.cijena! * kolicina).toStringAsFixed(2) + " KM",
                    style: const TextStyle(
                        color: ColorPallete.purple,
                        fontFamily: "Avenir-Medium",
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ColorPallete.yellow,
                      onPrimary: ColorPallete.purple,
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                    ),
                    onPressed: () async => {
                      widget.dropdownShown == false
                          ? setState(() {
                              widget.dropdownShown = true;
                            })
                          : odabranaRezervacija.rezervacijaId != 0
                              ? await HttpService.dodajJeloURezervaciju(
                                      JeloRezervacijaModel(
                                          widget.jelo.jeloId!,
                                          odabranaRezervacija.rezervacijaId,
                                          kolicina))
                                  .then((value) => {
                                        setDropdown(false),
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          backgroundColor: Colors.green,
                                          duration:
                                              Duration(milliseconds: 1000),
                                          content:
                                              Text("Jelo dodano u rezervaciju"),
                                        ))
                                      })
                              : ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  duration: Duration(milliseconds: 1000),
                                  content: Text("Morate odabrati rezervaciju"),
                                ))
                    },
                    child: const Text(
                      "DODAJ U REZERVACIJU",
                      style: TextStyle(
                        fontFamily: 'Avenir-Medium',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            widget.dropdownShown == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 60,
                      child: DropdownButton<RezervacijaModel>(
                        value: odabranaRezervacija,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(
                          fontSize: 15,
                          color: ColorPallete.purple,
                        ),
                        underline: Container(
                          height: 2,
                          color: ColorPallete.purple,
                        ),
                        onChanged: (RezervacijaModel? newValue) {
                          setState(() {
                            odabranaRezervacija = newValue!;
                          });
                        },
                        items: rezervacije.map((RezervacijaModel rezervacija) {
                          return DropdownMenuItem<RezervacijaModel>(
                            value: rezervacija,
                            child: Text(rezervacija.sifra!),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              "Ukupan rejting",
              style: TextStyle(
                  color: ColorPallete.purple,
                  fontFamily: "Avenir-Medium",
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            RatingBar(
                initialRating: ukupanRejting!,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                    full: const Icon(Icons.star, color: Colors.orange),
                    half: const Icon(
                      Icons.star_half,
                      color: Colors.orange,
                    ),
                    empty: const Icon(
                      Icons.star_outline,
                      color: Colors.orange,
                    )),
                ignoreGestures: true,
                onRatingUpdate: (value) {}),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "Vaš rejting",
              style: TextStyle(
                  color: ColorPallete.purple,
                  fontFamily: "Avenir-Medium",
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            RatingBar(
                initialRating: klijentovRejting!,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                    full: const Icon(Icons.star, color: Colors.orange),
                    half: const Icon(
                      Icons.star_half,
                      color: Colors.orange,
                    ),
                    empty: const Icon(
                      Icons.star_outline,
                      color: Colors.orange,
                    )),
                onRatingUpdate: (value) {
                  setState(() {
                    _ratingValue = value;
                  });
                }),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width - 60, 50),
                primary: ColorPallete.purple,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              onPressed: () async {
                try {
                  HttpService.dodajOcjenuZaJelo(
                      _ratingValue, widget.jelo.jeloId);
                  await getUkupanRejtingZaJelo();
                  await getKlijentovRejtingZaJelo();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.green,
                    duration: Duration(milliseconds: 1000),
                    content: Text("Uspješno ažuriran rejting"),
                  ));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    duration: Duration(milliseconds: 1000),
                    content: Text("Greška prilikom ažuriranja rejtinga"),
                  ));
                }
              },
              child: const Text(
                "Ažuriraj ocjenu",
                style: TextStyle(
                  fontFamily: 'Avenir-Medium',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }

  setDropdown(bool value) {
    setState(() {
      widget.dropdownShown = value;
    });
  }
}


Widget getFoodImage(JeloModel jelo) {
  if (jelo.slika == null) {
    return Image.asset("assets/images/placeholder_food.png", width: 300.0,);
  } else {
    return Image.memory(
      base64Decode(jelo.slika!),
      width: 300.0,
    );
  }
}
