import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/screens/password_reset_code_screen.dart';
import 'package:monets/screens/password_reset_screen.dart';
import 'package:monets/screens/signup_screen.dart';
import 'package:monets/services/http_service.dart';

class PasswordResetConfirmation extends StatefulWidget {
  const PasswordResetConfirmation({Key? key}) : super(key: key);

  @override
  _PasswordResetConfirmationState createState() =>
      _PasswordResetConfirmationState();
}

class _PasswordResetConfirmationState extends State<PasswordResetConfirmation> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                "Zaboravili ste lozinku",
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
                  const Text(
                    "Molimo unesite Vašu email adresu.\nDobit ćete kod za restart lozinke.",
                    style: TextStyle(
                        color: Colors.black38,
                        fontFamily: "Avenir-Medium",
                        fontWeight: FontWeight.w500,
                        letterSpacing: -1.0,
                        fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40.0,
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
                          fixedSize:
                              Size(MediaQuery.of(context).size.width - 60, 50),
                          primary: ColorPallete.yellow,
                          onPrimary: ColorPallete.purple,
                          minimumSize: const Size(250, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        onPressed: () async {
                          await HttpService.posaljiKodZaRestartPassworda(
                              emailController.text).then((value) => ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: ColorPallete.yellow,
                            duration: Duration(milliseconds: 2000) ,
                            content:
                            Text("Verifikacijski kod poslan", style:TextStyle(color: ColorPallete.purple)),
                          )));
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PasswordResetCode(email:emailController.text)));
                        },
                        child: const Text(
                          "Dalje",
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
    );
  }
}
