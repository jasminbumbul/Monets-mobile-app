import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/models/grad_model.dart';
import 'package:monets/models/klijent_insert_model.dart';
import 'package:monets/screens/profile_screen.dart';
import 'package:monets/services/http_service.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  late GradModel odabraniGrad = GradModel(0, 'Odaberite grad');
  late List<GradModel> gradovi = <GradModel>[
    GradModel(0, 'Odaberite grad'),
  ];

  late DateTime selectedDate;
  final TextEditingController imeController = TextEditingController();
  final TextEditingController prezimeController = TextEditingController();
  final TextEditingController korisnickoImeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();
  final TextEditingController adresaController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime.now());

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    odabraniGrad = gradovi[0];
    selectedDate = DateTime.now();
    getGradove();
    prepareUserData();
  }

  void getGradove() async {
    var gradoviList = await HttpService.getGradove();
    setState(() {
      gradovi = gradoviList;
      odabraniGrad = gradovi[0];
    });
  }

  void prepareUserData() {
    var klijent = HttpService.klijent;
    imeController.text = klijent.ime!;
    prezimeController.text = klijent.prezime!;
    emailController.text = klijent.email!;
    korisnickoImeController.text = klijent.korisnickoIme!;
    selectedDate = klijent.datumRodjenja!;
    telefonController.text = klijent.telefon!;
    adresaController.text = klijent.adresa!;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
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
                              top: 15.0, bottom: 15.0, left: 20.0),
                          child: Text(
                            "Edit profila",
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
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await HttpService.updateKlijenta(
                                      KlijentInsertModel.withoutPassword(
                                          odabraniGrad.gradId,
                                          imeController.text,
                                          prezimeController.text,
                                          korisnickoImeController.text,
                                          emailController.text,
                                          telefonController.text,
                                          adresaController.text,
                                          null,
                                          selectedDate,
                                          true))
                                  .then((value) => setState(() {
                                        HttpService.klijent = value;
                                      }))
                                  .then((value) => ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                            "Uspješno ažurirane informacije"),
                                      )));
                            } catch (exception) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(exception.toString().substring(
                                    22, exception.toString().length - 3)),
                              ));
                            }
                          }
                        },
                        child: const Text(
                          "Spremi",
                          style: TextStyle(
                              color: ColorPallete.yellow,
                              fontFamily: "Avenir-Medium",
                              fontWeight: FontWeight.w500,
                              letterSpacing: -1.0,
                              fontSize: 17.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ime je obavezno';
                          }
                          return null;
                        },
                        controller: imeController,
                        decoration: const InputDecoration(
                          labelText: "Ime",
                          hintText: "Unesite Vaše ime",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 18,
                            color: ColorPallete.purple,
                          ),
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Prezime je obavezno';
                          }
                          return null;
                        },
                        controller: prezimeController,
                        decoration: const InputDecoration(
                          labelText: "Prezime",
                          hintText: "Unesite Vaše prezime",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 18,
                            color: ColorPallete.purple,
                          ),
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Korisničko ime je obavezno';
                          }
                          return null;
                        },
                        controller: korisnickoImeController,
                        decoration: const InputDecoration(
                          labelText: "Korisničko ime",
                          hintText: "Unesite Vaše korisničko ime",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 18,
                            color: ColorPallete.purple,
                          ),
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email je obavezan';
                          }
                          return null;
                        },
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          hintText: "Unesite Vaš email",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 18,
                            color: ColorPallete.purple,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          "Datum rođenja",
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorPallete.purple,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "${selectedDate.day}. ${selectedDate.month}. ${selectedDate.year}.",
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: ColorPallete.purple,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: ColorPallete.purple,
                              onPrimary: Colors.white,
                            ),
                            onPressed: () => _selectDate(context),
                            child: const Text('Odaberite datum rođenja'),
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Broj telefona je obavezan';
                          }
                          return null;
                        },
                        controller: telefonController,
                        decoration: const InputDecoration(
                          labelText: "Telefon",
                          hintText: "Unesite Vaš broj telefona",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 18,
                            color: ColorPallete.purple,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text("Odaberite grad",
                            style: TextStyle(
                              fontSize: 18,
                              color: ColorPallete.purple,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: DropdownButton<GradModel>(
                            value: odabraniGrad,
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
                            onChanged: (GradModel? newValue) {
                              setState(() {
                                odabraniGrad = newValue!;
                              });
                            },
                            items: gradovi.map((GradModel grad) {
                              return DropdownMenuItem<GradModel>(
                                value: grad,
                                child: Text(grad.naziv!),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Adresa je obavezna';
                          }
                          return null;
                        },
                        controller: adresaController,
                        decoration: const InputDecoration(
                          labelText: "Adresa",
                          hintText: "Unesite Vašu adresu",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 18,
                            color: ColorPallete.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50.0)
            ],
          ),
        ),
      ),
    );
  }
}
