import 'dart:async';

import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/screens/password_reset_screen.dart';
import 'package:monets/services/http_service.dart';
import 'package:pinput/pin_put/pin_put.dart';

class PasswordResetCode extends StatefulWidget {
  final String email;
  const PasswordResetCode({Key? key, required this.email}) : super(key: key);

  @override
  _PasswordResetCodeState createState() => _PasswordResetCodeState();
}

class _PasswordResetCodeState extends State<PasswordResetCode> {
  final TextEditingController codeController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  static const countdownDuration = Duration(seconds: 10);
  Duration duration = const Duration();

  Timer? timer;

  bool countDown = true;

  @override
  void initState() {
    super.initState();
    reset();
  }

  void reset() {
    if (countDown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
        reset();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

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
                                "Verifikacijski kod",
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
                    "Na Vaš mail je poslan verfikacijski kod.\nMolimo da ga unesete u polju ispod.",
                    style: TextStyle(
                        color: Colors.black38,
                        fontFamily: "Avenir-Medium",
                        fontWeight: FontWeight.w500,
                        letterSpacing: -1.0,
                        fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  PinPut(
                    textStyle: const TextStyle(fontSize: 20.0, fontFamily: "Avenir"),
                    keyboardType: TextInputType.text,
                    fieldsCount: 6,
                    focusNode: _pinPutFocusNode,
                    controller: codeController,
                    submittedFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    selectedFieldDecoration: _pinPutDecoration,
                    followingFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: ColorPallete.purple.withOpacity(.8),
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
                          HttpService.posaljiKodNaVerifikaciju(widget.email, codeController.text).then((value) =>
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                backgroundColor: Colors.green,
                                duration: Duration(milliseconds: 2000),
                                content:
                                Text("Kod prihvaćen",style: TextStyle(color:ColorPallete.purple),),
                              ))).then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PasswordReset( email: widget.email,))));
                        },
                        child: const Text(
                          "Verifikuj kod",
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
              const SizedBox(height: 20.0),
              const Text(
                "Niste dobili kod?",
                style: TextStyle(
                    color: Colors.black38,
                    fontFamily: "Avenir-Medium",
                    fontWeight: FontWeight.w500,
                    letterSpacing: -1.0,
                    fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              duration.inSeconds != 10
                  ? Text(
                "Sačekajte ${duration.inSeconds} sekundi prije slanja novog mail-a",
                style: const TextStyle(
                  fontFamily: 'Avenir-Medium',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              )
                  : Container(),
              duration.inSeconds != 10
                  ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorPallete.darkGrey,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () async {
                },
                child: const Text(
                  "Pošalji opet",
                  style: TextStyle(
                    fontFamily: 'Avenir-Medium',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorPallete.purple,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () async {
                  startTimer();
                  await HttpService.posaljiKodZaRestartPassworda(
                      widget.email).then((value) => ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(
                    backgroundColor: ColorPallete.yellow,
                    duration: Duration(milliseconds: 2000) ,
                    content:
                    Text("Verifikacijski kod poslan", style:TextStyle(color: ColorPallete.purple)),
                  )));
                },
                child: const Text(
                  "Ponovo pošalji kod",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: ColorPallete.purple,
                      color: Colors.white,
                      fontFamily: "Avenir-Medium",
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1.0,
                      fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
