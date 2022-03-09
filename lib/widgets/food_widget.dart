import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/models/jelo_model.dart';
import 'package:monets/models/jelo_rezervacija_model.dart';
import 'package:monets/screens/favourites_screen.dart';
import 'package:monets/services/http_service.dart';

class FoodWidget extends StatefulWidget {
  final Function(int jeloId)? notifyParent;
  late bool isFavouriteScreen = false;
  final JeloModel jelo;
  late int? kolicina;
  final int? rezervacija;

  FoodWidget({Key? key, required this.jelo, required this.isFavouriteScreen, this.notifyParent, this.kolicina, this.rezervacija}) : super(key: key);

  @override
  State<FoodWidget> createState() => _FoodWidgetState();
}

class _FoodWidgetState extends State<FoodWidget> {

  @override
  void initState() {
    print(widget.rezervacija);
    if(widget.rezervacija!=0 && widget.jelo.jeloId!=0){
      getKolicinu();
    }
  }

  getKolicinu()async{
    JeloRezervacijaModel jeloRezervacijaModel = await HttpService.getKolicinuZaJeloRezervaciju(widget.jelo.jeloId!, widget.rezervacija!);
    setState(() {
      widget.kolicina=jeloRezervacijaModel.kolicina!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0, left: 5.0, right: 5.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 5.0,
                    spreadRadius: 10.0,
                    offset: const Offset(3.0, 3.0)),
              ],
            ),
            width: MediaQuery.of(context).size.width - 70.0,
            height: 100.0,
            child: Row(
              children: [
                getFoodImage(widget.jelo),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            widget.jelo.nazivJela!,
                            style: const TextStyle(
                                color: ColorPallete.purple,
                                fontFamily: "Avenir-Medium",
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0),
                          ),
                        ),
                        widget.isFavouriteScreen ==true ? (GestureDetector(
                          onTap: () async {
                            widget.notifyParent!(widget.jelo.jeloId!);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: ColorPallete.purple,
                              duration: Duration(milliseconds: 1000) ,
                              content:
                              Text("Jelo uklonjeno iz favorita"),
                            ));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width-250.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(Icons.favorite, color: ColorPallete.purple),
                              ],
                            ),
                          ),
                        )):Container(),
                       widget.kolicina != null
                            ? GestureDetector(
                            onTap: () async {
                              try {
                                await widget.notifyParent!(widget.jelo.jeloId!);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  backgroundColor: ColorPallete.yellow,
                                  duration: Duration(milliseconds: 1000),
                                  content:
                                  Text("Jelo uklonjeno iz rezervacije", style: TextStyle(color:Colors.black),),
                                ));
                              } catch (exception) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(exception.toString().substring(
                                      22, exception.toString().length - 3)),
                                ));
                              }
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width-250.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Icon(Icons.restore_from_trash_rounded, color: Colors.red),
                                ],
                              ),
                            ))
                            : Container(),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          widget.jelo.opisJela!,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: "Avenir-Medium",
                              fontSize: 13.0),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/1.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.kolicina!=null ?Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left:10.0),
                              child: Text(
                                (widget.kolicina.toString()+"X"),
                                style: const TextStyle(
                                    color: ColorPallete.purple,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Avenir-Medium",
                                    fontSize: 15.0),
                              ),
                            ),
                          ):Container(),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                                (widget.jelo.cijena!.toStringAsFixed(0) + " KM"),
                                style: const TextStyle(
                                    color: ColorPallete.purple,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Avenir-Medium",
                                    fontSize: 15.0),
                              ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget getFoodImage(JeloModel jelo) {
  if (jelo.slika == null) {
    return Image.asset("assets/images/placeholder_food.png");
  } else {
    return Image.memory(base64Decode(jelo.slika!),width: 100.0,);
  }
}
