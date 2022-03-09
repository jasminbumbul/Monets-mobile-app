import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/constants/constants.dart';
import 'package:monets/screens/login_screen.dart';
import 'package:monets/templates/start_template.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return StartTemplate(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Welcome \nto \n" + Constants.appName,
              style: TextStyle(
                color: ColorPallete.purple,
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Avenir-Medium',
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorPallete.purple,
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen())),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
