import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/models/rezervacija_insert_model.dart';
import 'package:monets/models/stol_model.dart';
import 'package:monets/models/vrijeme_model.dart';
import 'package:monets/screens/reservation_details_screen.dart';
import 'package:monets/services/http_service.dart';
import 'package:monets/widgets/time_widget.dart';

class NewReservation extends StatefulWidget {
  const NewReservation({Key? key}) : super(key: key);

  @override
  _NewReservationState createState() => _NewReservationState();
}

class _NewReservationState extends State<NewReservation> {
  late bool _value = false;
  late StolModel odabraniStol = StolModel(
    0,
    0,
    'Odaberite stol',
  );
  late List<StolModel> stolovi = <StolModel>[
    StolModel(0, 0, 'Odaberite stol'),
  ];

  final _formKey = GlobalKey<FormState>();

  late DateTime selectedDate;
  late DateTime selectedStartDate;
  late DateTime selectedEndDate;
  late int selectedStartTimeIndex;
  late int selectedEndTimeIndex;
  late bool showEndTime = false;
  late bool showStartTime = false;

  // late KlijentInsertModel klijentInsertModel;

  // final TextEditingController lozinkaPotvrdaController =
  // TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1, DateTime.now().month));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> selectStartTime(int index, DateTime date) async {
    setState(() {
      selectedStartTimeIndex = index;
      selectedStartDate = date;
      showEndTime = true;
      selectedDate = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, date.hour, date.minute);
    });
  }

  Future<void> selectEndTime(int index, DateTime date) async {
    setState(() {
      selectedEndTimeIndex = index;
      selectedEndDate = date;
    });
  }

  @override
  void initState() {
    selectedDate = DateTime.now();
    selectedEndTimeIndex = -1;
    selectedStartTimeIndex = -1;

    odabraniStol = stolovi[0];
    getStolove();
  }

  void getStolove() async {
    var stoloviList = await HttpService.getStolove();
    setState(() {
      stolovi = stoloviList as List<StolModel>;
      odabraniStol = stolovi[0];
    });
  }

  Widget getEndTimeWidget() {
    return Column(
      children: [
        const Text(
          "Kraj rezervacije",
          style: TextStyle(
            fontSize: 18,
            color: ColorPallete.purple,
          ),
        ),
        FutureBuilder<List<VrijemeModel>?>(
          future: HttpService.getSlodobnaKrajnjaVremena(selectedDate),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 60.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    var elementAt = snapshot.data!.elementAt(index);
                    return GestureDetector(
                      onTap: () => selectEndTime(index, elementAt.vrijeme!),
                      child: TimeWidget(
                        vrijemeModel: elementAt,
                        index: index,
                        selected: selectedEndTimeIndex,
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return const Text('Something went wrong ...');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }

  Widget getStartTimeWidget() {
    return Column(
      children: [
        const Text(
          "Početak rezervacije",
          style: TextStyle(
            fontSize: 18,
            color: ColorPallete.purple,
          ),
        ),
        FutureBuilder<List<VrijemeModel>?>(
          future: HttpService.getSlodobnaVremena(
              selectedDate, odabraniStol.stolId!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 60.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    var elementAt = snapshot.data!.elementAt(index);
                    return GestureDetector(
                      onTap: () => elementAt.isSlobodno == true
                          ? selectStartTime(index, elementAt.vrijeme!)
                          : () => {},
                      child: (snapshot.data?.length)! > 0
                          ? TimeWidget(
                              vrijemeModel: elementAt,
                              index: index,
                              selected: selectedStartTimeIndex,
                            )
                          : const Text("Nema slobodnog vremena za rezervaciju"),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return const Text('Something went wrong ...');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
                  const IntrinsicHeight(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 15.0, right: 60.0),
                        child: Text(
                          "Nova rezervacija",
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
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Datum rezervacije",
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorPallete.purple,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width - 60, 40),
                              primary: Colors.grey[300],
                              onPrimary: Colors.white,
                            ),
                            onPressed: () => _selectDate(context),
                            child: Text(
                              "${selectedDate.day}. ${selectedDate.month}. ${selectedDate.year}.",
                              style: const TextStyle(
                                fontSize: 18,
                                color: ColorPallete.purple,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text("Odaberite stol",
                            style: TextStyle(
                              fontSize: 18,
                              color: ColorPallete.purple,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: DropdownButton<StolModel>(
                            value: odabraniStol,
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
                            onChanged: (StolModel? newValue) {
                              setState(() {
                                odabraniStol = newValue!;
                                selectedEndTimeIndex = -1;
                                selectedStartTimeIndex = -1;
                                showStartTime = true;
                              });
                            },
                            items: stolovi.map((StolModel stol) {
                              return DropdownMenuItem<StolModel>(
                                value: stol,
                                child: Text(stol.nazivStola!),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      showStartTime == true
                          ? getStartTimeWidget()
                          : Container(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      showEndTime == true ? getEndTimeWidget() : Container(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      selectedEndTimeIndex!=-1 ? Row(
                        children: <Widget>[
                          Text("Onsite plaćanje",
                              style: TextStyle(
                                fontSize: 18,
                                color: !_value ? ColorPallete.purple : ColorPallete.darkGrey,
                              )),
                          const Spacer(),
                          Switch.adaptive(
                            value: _value,
                            activeColor: ColorPallete.purple,
                            activeTrackColor: Colors.purpleAccent,
                            onChanged: (bool? value) {
                              setState(
                                    () {
                                  _value = value!;
                                },
                              );
                            },
                          ),
                          const Spacer(),
                          Text("Online plaćanje",
                              style: TextStyle(
                                fontSize: 18,
                                color: _value ? ColorPallete.purple : ColorPallete.darkGrey,
                              )),
                        ],
                      ):Container(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width - 60, 50),
                              primary: (selectedStartTimeIndex != -1 &&
                                      selectedEndTimeIndex != -1)
                                  ? ColorPallete.purple
                                  : ColorPallete.darkGrey,
                              onPrimary: Colors.white,
                              minimumSize: const Size(250, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  var rezervacija =
                                      await HttpService.kreirajRezervaciju(
                                              RezervacijaInsertModel(
                                                  selectedStartDate,
                                                  selectedEndDate,
                                                  false,
                                                  false,
                                                  false,
                                                  _value,
                                                  "",
                                                  odabraniStol.stolId))
                                          .then((value) => {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ReservationDetailsScreen(
                                                                rezervacija:
                                                                    value))),
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                      "Uspješno dodana rezervacija"),
                                                ))
                                              });
                                } catch (exception) {
                                  print(exception.toString().substring(
                                      22, exception.toString().length - 3));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(exception
                                        .toString()
                                        .substring(22,
                                            exception.toString().length - 3)),
                                  ));
                                }
                              }
                            },
                            child: const Text(
                              "Kreiraj rezervaciju",
                              style: TextStyle(
                                fontFamily: 'Avenir-Medium',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
