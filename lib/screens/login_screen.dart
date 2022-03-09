import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/screens/email_verification_screen.dart';
import 'package:monets/screens/main_screen.dart';
import 'package:monets/screens/password_reset_confrimation_screen.dart';
import 'package:monets/screens/signup_screen.dart';
import 'package:monets/services/http_service.dart';
import 'package:monets/templates/login_template.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: LoginTemplate(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100.0),
                  const Text(
                    "Prijava",
                    style: TextStyle(
                      color: ColorPallete.purple,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Avenir-Book',
                      letterSpacing: -1.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Korisničko ime je obavezno';
                        }
                        return null;
                      },
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: "Korisničko ime",
                        hintText: "Unesite Vaše korisničko ime",
                        prefixIcon: Icon(
                          Icons.people,
                          color: ColorPallete.purple,
                        ),
                        hintStyle:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        labelStyle: TextStyle(
                          fontSize: 13,
                          color: ColorPallete.purple,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lozinka je obavezna';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Lozinka",
                      hintText: "Unesite vašu lozinku",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: ColorPallete.purple,
                      ),
                      hintStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      labelStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IntrinsicHeight(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const PasswordResetConfirmation())),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              "Zaboravili ste lozinku?",
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Avenir-Book',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width - 60, 50),
                                primary: ColorPallete.yellow,
                                onPrimary: ColorPallete.purple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await HttpService.loginKlijenta(
                                      usernameController.text,
                                      passwordController.text,
                                    ).then((value) => {
                                          if (value
                                                  .korisnickiRacun?.emailVerified ==
                                              false)
                                            {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EmailVerification(
                                                              klijent: value)))
                                            }
                                          else
                                            {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                      const MainScreen()),
                                                  (route) => false)
                                            }
                                        });
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
                                "Prijava",
                                style: TextStyle(
                                  fontFamily: 'Avenir-Medium',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "ili",
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Avenir-Book',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width - 60, 50),
                                primary: ColorPallete.purple,
                                onPrimary: Colors.white,
                                minimumSize: const Size(250, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              onPressed: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const SignupScreen()));
                              },
                              child: const Text(
                                "Registracija",
                                style: TextStyle(
                                  fontFamily: 'Avenir-Medium',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.0)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
