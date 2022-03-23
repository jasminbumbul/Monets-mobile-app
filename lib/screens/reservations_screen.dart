import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/models/rezervacija_model.dart';
import 'package:monets/models/rezervacija_search_model.dart';
import 'package:monets/screens/new_reservation_screen.dart';
import 'package:monets/services/http_service.dart';
import 'package:monets/widgets/reservation_widget.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({Key? key}) : super(key: key);

  @override
  _ReservationsScreenState createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                const Spacer(),
                const IntrinsicHeight(
                  child: Center(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 15.0, bottom: 15.0, left: 60.0),
                      child: Text(
                        "Moje rezervacije",
                        style: TextStyle(
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
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NewReservation())),
                      child: const Icon(
                        Icons.add_box_outlined,
                        size: 30.0,
                      )),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    selectedIndex = 0;
                  }),
                  style: ElevatedButton.styleFrom(
                    primary: selectedIndex == 0
                        ? ColorPallete.purple
                        : Colors.grey[200],
                    onPrimary: selectedIndex == 0 ? Colors.white : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    "Sve",
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    selectedIndex = 1;
                  }),
                  style: ElevatedButton.styleFrom(
                    primary: selectedIndex == 1
                        ? ColorPallete.purple
                        : Colors.grey[200],
                    onPrimary: selectedIndex == 1 ? Colors.white : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    "Aktivne",
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    selectedIndex = 2;
                  }),
                  style: ElevatedButton.styleFrom(
                    primary: selectedIndex == 2
                        ? ColorPallete.purple
                        : Colors.grey[200],
                    onPrimary: selectedIndex == 2 ? Colors.white : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    "Prošle",
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.6,
                child: FutureBuilder<List<RezervacijaModel>>(
                  future: HttpService.getRezervacije(RezervacijaSearchModel(
                      null,
                      selectedIndex == 0
                          ? null
                          : selectedIndex == 1
                              ? true
                              : false,
                      HttpService.klijent.klijentId!,
                      false)),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          var elementAt = snapshot.data!.elementAt(index);
                          return OrderWidget(
                            rezervacija: elementAt,
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Text('Something went wrong ...');
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
