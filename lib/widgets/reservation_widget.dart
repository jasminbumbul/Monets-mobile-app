import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/models/jelo_model.dart';
import 'package:monets/models/rezervacija_model.dart';
import 'package:monets/screens/reservation_details_screen.dart';

class OrderWidget extends StatefulWidget {
  final RezervacijaModel rezervacija;

  const OrderWidget({Key? key, required this.rezervacija}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0, left: 5.0, right: 5.0, top:10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: ColorPallete.lightGrey.withOpacity(0.4),
                    blurRadius: 5.0,
                    spreadRadius: 10.0,
                    offset: const Offset(3.0, 3.0)),
              ],
            ),
            width: MediaQuery.of(context).size.width - 70.0,
            height: 100.0,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/purple_basket.png"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Text(
                          "Rezervacija " + widget.rezervacija.sifra!,
                          style: TextStyle(
                            fontFamily: 'Avenir-Medium',
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          DateFormat('dd.MM.yyyy. u kk:mm')
                              .format(widget.rezervacija.pocetakRezervacije!),
                          style: TextStyle(
                              fontFamily: 'Avenir-Medium',
                              fontSize: 13.0,
                              color: Colors.black45),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: ColorPallete.yellow,
                                onPrimary: ColorPallete.purple),
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ReservationDetailsScreen(
                                            rezervacija: widget.rezervacija))),
                            child: Text("Pregled rezervacije")),
                      ],
                    ),
                  ),
                )
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
    return Image.network(jelo.slika!);
  }
}
