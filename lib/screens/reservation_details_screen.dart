import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/models/jelo_model.dart';
import 'package:monets/models/jelo_rezervacija_model.dart';
import 'package:monets/models/rezervacija_model.dart';
import 'package:monets/screens/payment_screen.dart';
import 'package:monets/services/http_service.dart';
import 'package:monets/widgets/food_widget.dart';

import '../models/rezervacija_update_model.dart';
import '../models/transakcija_model.dart';
import 'food_details_screen.dart';
import 'home_screen.dart';
import 'main_screen.dart';

class ReservationDetailsScreen extends StatefulWidget {
  final RezervacijaModel rezervacija;


  const ReservationDetailsScreen({Key? key, required this.rezervacija})
      : super(key: key);

  @override
  _ReservationDetailsScreenState createState() =>
      _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen> {
  final List<JeloRezervacijaModel> narudzbe = [];

  refresh(int jeloId) async {
    await HttpService.ukloniJeloIzRezervacije(
        JeloRezervacijaModel(jeloId, widget.rezervacija.rezervacijaId, 0));
    setState(() {});
  }

  getJelaIzRezervacije() async {
    var jela = await HttpService.getJelaIzRezervacije(widget.rezervacija.rezervacijaId!);
    for (var jelo in jela!) {
      var jeloRezervacija = await HttpService.getKolicinuZaJeloRezervaciju(jelo.jeloId!, widget.rezervacija.rezervacijaId!);
      narudzbe.add(JeloRezervacijaModel.setJeloKolicinu(jeloRezervacija.jeloId, jeloRezervacija.kolicina));
    }
  }

  List<JeloRezervacijaModel> getNarudzbe(){
    List<JeloRezervacijaModel> test =   getJelaIzRezervacije();
    print(test.length);
    return test;
  }

  updateRezervaciju(RezervacijaModel novaRezervacija) {
    setState(() {
      widget.rezervacija != novaRezervacija;
    });
  }

  @override
  void initState() {
    getJelaIzRezervacije();
  }

  @override
  Widget build(BuildContext context) {

    List<JeloRezervacijaModel> test = [];
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30.0,
                    )),
              ),
              const Spacer(),
              IntrinsicHeight(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, bottom: 15.0, right: 60.0),
                    child: Text(
                      "Rezervacija " + widget.rezervacija.sifra!,
                      style: const TextStyle(
                          color: ColorPallete.purple,
                          fontFamily: "Avenir-Medium",
                          fontWeight: FontWeight.w500,
                          letterSpacing: -1.0,
                          fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        const Text("Datum rezervacije "),
        Text(
          "${widget.rezervacija.pocetakRezervacije?.day}. ${widget.rezervacija.pocetakRezervacije?.month}. ${widget.rezervacija.pocetakRezervacije?.year}.",
        ),
        const Text("Pocetak rezervacije "),
        Text(
          "${widget.rezervacija.pocetakRezervacije?.hour} : " +
              (widget.rezervacija.pocetakRezervacije?.minute == 0
                  ? "00"
                  : "${widget.rezervacija.pocetakRezervacije?.minute}"),
        ),
        const Text("Kraj rezervacije "),
        Text(
          "${widget.rezervacija.krajRezervacije?.hour} : " +
              (widget.rezervacija.krajRezervacije?.minute == 0
                  ? "00"
                  : "${widget.rezervacija.krajRezervacije?.minute}"),
        ),
        const Text("Broj stola "),
        Text(
          widget.rezervacija.stolId!.toString(),
        ),
        const Text("Način plaćanja"),
        Text(
          widget.rezervacija.onlinePlacanje == true ? "Online plaćanje" : "Onsite plaćanje",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: Text(
                      "Jela u rezervaciji",
                      style: TextStyle(
                          color: ColorPallete.purple,
                          fontFamily: "Avenir-Medium",
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: FutureBuilder<List<JeloModel>?>(
                  future: HttpService.getJelaIzRezervacije(
                      widget.rezervacija.rezervacijaId!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Center(child: Text(
                          "Nema jela u rezervaciji",
                          style: TextStyle(
                              color: ColorPallete.purple,
                              fontFamily: "Avenir-Medium",
                              fontSize: 17.0),
                        ),);
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            var elementAt = snapshot.data!.elementAt(index);
                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FoodDetails(jelo: elementAt))),
                              child: FoodWidget(
                                  jelo: elementAt,
                                  isFavouriteScreen: false,
                                  notifyParent: refresh,
                                  rezervacija:
                                      widget.rezervacija.rezervacijaId!),
                            );
                          },
                        );
                      }
                    } else if (snapshot.hasError) {
                      return const Text('Something went wrong ...');
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              widget.rezervacija.potvrdjenaKlijent! == false
                  ? (widget.rezervacija.onlinePlacanje == true ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize:
                  Size(MediaQuery.of(context).size.width - 60, 40),
                  primary: ColorPallete.yellow,
                  onPrimary: ColorPallete.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () async {
                  try {
                    Navigator.of(context).push(
                      MaterialPageRoute (
                        builder: (BuildContext context)=> Payment(
                          narudzbe : narudzbe,
                          onFinish: (number) async {
                            // payment done
                            await HttpService.updateRezervaciju(
                                widget.rezervacija.rezervacijaId!,
                                RezervacijaUpdateModel(
                                    widget.rezervacija.pocetakRezervacije,
                                    widget.rezervacija.krajRezervacije,
                                    true,
                                    widget.rezervacija.potvrdjena,
                                    true,
                                    false,
                                    widget.rezervacija.poruka,
                                    widget.rezervacija.stolId))
                                .then((value) => {
                              updateRezervaciju(value),
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                backgroundColor: ColorPallete.yellow,
                                content: Text("Rezervacija završena"),
                              ))
                            }).then((value) =>HttpService.kreirajTransakciju(TransakcijaModel(0,widget.rezervacija.rezervacijaId!, HttpService.klijent.klijentId!, "")))
                                .then((value)=>{
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: Colors.green,
                              duration: Duration(milliseconds: 1000),
                              content:
                              Text("Plaćanje uspješno"),
                            ))
                            }).then((value) =>   Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MainScreen())));
                            setState(() {
                            });
                          },
                        ),
                      ),
                    );
                  } catch (exception) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Greška"),
                    ));
                  }
                },
                child: Text(
                  widget.rezervacija.onlinePlacanje == true ? "Nastavi na plaćanje": "Završi rezervaciju",
                  style: const TextStyle(
                    fontFamily: 'Avenir-Medium',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ) : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize:
                  Size(MediaQuery.of(context).size.width - 60, 40),
                  primary: ColorPallete.yellow,
                  onPrimary: ColorPallete.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () async {
                  //TODO: mora imati barem jedno jelo u rezervaciji
                  // if () {
                  try {
                    await HttpService.updateRezervaciju(
                        widget.rezervacija.rezervacijaId!,
                        RezervacijaUpdateModel(
                            widget.rezervacija.pocetakRezervacije,
                            widget.rezervacija.krajRezervacije,
                            false,
                            true,
                            true,
                            false,
                            widget.rezervacija.poruka,
                            widget.rezervacija.stolId))
                        .then((value) => {
                      updateRezervaciju(value),
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        backgroundColor: ColorPallete.yellow,
                        content: Text("Rezervacija završena"),
                      ))
                    });
                  } catch (exception) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(exception.toString().substring(
                          22, exception.toString().length - 3)),
                    ));
                  }
                },
                child: Text(
                  widget.rezervacija.onlinePlacanje == true ? "Nastavi na plaćanje": "Završi rezervaciju",
                  style: const TextStyle(
                    fontFamily: 'Avenir-Medium',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size(MediaQuery.of(context).size.width - 60, 40),
                        primary: ColorPallete.darkGrey,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      onPressed: () async {},
                      child: const Text(
                        "Rezervacija je završena",
                        style: TextStyle(
                          fontFamily: 'Avenir-Medium',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ]),
    ));
  }
}
