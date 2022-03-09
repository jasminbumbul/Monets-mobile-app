import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/models/password_reset_model.dart';
import 'package:monets/screens/login_screen.dart';
import 'package:monets/services/http_service.dart';

class PasswordReset extends StatefulWidget {
  final String email;

  const PasswordReset({Key? key, required this.email}) : super(key: key);

  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final TextEditingController lozinkaController = TextEditingController();
  final TextEditingController lozinkaPotvrdaController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  reverse: true,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.arrow_back,
                                size: 30.0,
                              )),
                          const Spacer(),
                          const IntrinsicHeight(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 15.0, bottom: 15.0, right: 30.0),
                                child: Text(
                                  "Promjena passworda",
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
                    const SizedBox(height: 20.0),
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
                      obscureText: true,
                      controller: lozinkaController,
                      decoration: const InputDecoration(
                        labelText: "Lozinka",
                        hintText: "Unesite novu lozinku",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: ColorPallete.purple,
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
                        hintText: "Unesite potvrdu lozinke",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: ColorPallete.purple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 60, 50),
                            primary: ColorPallete.yellow,
                            onPrimary: ColorPallete.purple,
                            minimumSize: const Size(250, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              HttpService.updatePassword(PasswordResetModel(
                                      widget.email,
                                      lozinkaController.text,
                                      lozinkaPotvrdaController.text,
                                      ""))
                                  .then((value) => ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        backgroundColor: ColorPallete.yellow,
                                        duration: Duration(milliseconds: 2000),
                                        content: Text(
                                          "Lozinka uspješno promijenjena",
                                          style: TextStyle(
                                              color: ColorPallete.purple),
                                        ),
                                      )))
                                  .then((value) => Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()),
                                      (route) => false));
                            }
                          },
                          child: const Text(
                            "Promijeni password",
                            style: TextStyle(
                              fontFamily: 'Avenir-Medium',
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ].reversed.toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
