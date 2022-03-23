import 'dart:async';

import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/models/klijent_model.dart';
import 'package:monets/screens/login_screen.dart';
import 'package:monets/services/http_service.dart';

class EmailVerification extends StatefulWidget {
  final KlijentModel klijent;

  EmailVerification({Key? key, required this.klijent}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 150.0,
            ),
            const Text("placeholder za logo"),
            const Text(
              "Uspješno ste se registrovali.\nDa bi završili proces registracije potrebno je još da verifikujete email.\nMail sa uputama je poslan na Vašu mail adresu.",
              style: TextStyle(
                fontFamily: "Avenir-Medium",
                color: ColorPallete.purple,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30.0,
            ),
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
                      fixedSize:
                          Size(MediaQuery.of(context).size.width - 60, 50),
                      primary: ColorPallete.darkGrey,
                      onPrimary: Colors.white,
                      minimumSize: const Size(250, 50),
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
                      fixedSize:
                          Size(MediaQuery.of(context).size.width - 60, 50),
                      primary: ColorPallete.purple,
                      onPrimary: Colors.white,
                      minimumSize: const Size(250, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onPressed: () async {
                      startTimer();
                      HttpService.posaljiKonfirmacijskiMail(
                          widget.klijent.klijentId!);
                    },
                    child: const Text(
                      "Pošalji opet",
                      style: TextStyle(
                        fontFamily: 'Avenir-Medium',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width - 60, 50),
                primary: ColorPallete.yellow,
                onPrimary: ColorPallete.purple,
                minimumSize: const Size(250, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
              child: const Text(
                "Prijavi se",
                style: TextStyle(
                  fontFamily: 'Avenir-Medium',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
