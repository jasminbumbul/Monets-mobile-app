import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/models/grad_model.dart';
import 'package:monets/models/klijent_insert_model.dart';
import 'package:monets/models/klijent_model.dart';
import 'package:monets/screens/email_verification_screen.dart';
import 'package:monets/screens/start_screen.dart';
import 'package:monets/services/http_service.dart';
import 'package:monets/templates/login_template.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late GradModel odabraniGrad = GradModel(0, 'Odaberite grad');
  late List<GradModel> gradovi = <GradModel>[
    GradModel(0, 'Odaberite grad'),
  ];

  late DateTime selectedDate;

  late KlijentInsertModel klijentInsertModel;

  final TextEditingController imeController = TextEditingController();
  final TextEditingController prezimeController = TextEditingController();
  final TextEditingController korisnickoImeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();
  final TextEditingController adresaController = TextEditingController();
  final TextEditingController lozinkaController = TextEditingController();
  final TextEditingController lozinkaPotvrdaController =
      TextEditingController();

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
  }

  void getGradove() async {
    var gradoviList = await HttpService.getGradove();
    setState(() {
      gradovi = gradoviList;
      odabraniGrad = gradovi[0];
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: LoginTemplate(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100.0),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Registracija",
                    style: TextStyle(
                      color: ColorPallete.purple,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Avenir-Book',
                      letterSpacing: -1.0,
                    ),
                  ),
                ),
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
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lozinka je obavezna';
                    }
                    if (lozinkaPotvrdaController.text.isNotEmpty) {
                      if (lozinkaPotvrdaController.text != value) {
                        return 'Lozinke se ne podudaraju';
                      }
                    }
                    return null;
                  },
                  controller: lozinkaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Lozinka",
                    hintText: "Unesite vašu lozinku",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Potvrda lozinke je obavezna';
                    }
                    if (lozinkaController.text.isNotEmpty) {
                      if (lozinkaController.text != value) {
                        return 'Lozinke se ne podudaraju';
                      }
                    }
                    return null;
                  },
                  controller: lozinkaPotvrdaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Potvrda lozinke",
                    hintText: "Unesite vašu lozinku",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                              MediaQuery.of(context).size.width - 60,
                              50,
                            ),
                            primary: ColorPallete.purple,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                var klijent = await HttpService.registracijaKlijenta(
                                    KlijentInsertModel(
                                        odabraniGrad.gradId,
                                        imeController.text,
                                        prezimeController.text,
                                        korisnickoImeController.text,
                                        emailController.text,
                                        telefonController.text,
                                        adresaController.text,
                                        null,
                                        lozinkaController.text,
                                        lozinkaPotvrdaController.text,
                                        selectedDate,
                                        true)).then((value) => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    EmailVerification(
                                                        klijent: value))));
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
                            "Registracija",
                            style: TextStyle(
                              fontFamily: 'Avenir-Medium',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
