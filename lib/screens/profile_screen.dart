import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/screens/change_password_screen.dart';
import 'package:monets/screens/login_screen.dart';
import 'package:monets/screens/profile_edit_screen.dart';
import 'package:monets/services/http_service.dart';
import 'package:monets/widgets/profile_item_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: GestureDetector(
              onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileEdit())),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 5.0,
                        spreadRadius: 10.0,
                        offset: const Offset(3.0, 3.0)),
                  ],
                ),
                width: MediaQuery.of(context).size.width - 70.0,
                height: 100.0,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Image.asset(
                          "assets/images/profile_pic_placeholder.png",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              HttpService.klijent.korisnickoIme!,
                              style: const TextStyle(
                                color: ColorPallete.purple,
                                fontFamily: "Avenir-Medium",
                                fontWeight: FontWeight.w900,
                                fontSize: 20.0,
                                letterSpacing: -1.0,
                              ),
                            ),
                            Text(
                              HttpService.klijent.email!,
                              style: const TextStyle(
                                  color: Colors.black38,
                                  fontFamily: "Avenir-Medium",
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black38,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          const ProfileItem(
              icon: Icon(Icons.lock, color: Colors.white),
              itemName: "Privacy settings",
              itemPaddingColor: Colors.black,
              redirectScreen: ChangePassword()),
          const ProfileItem(
              icon: Icon(Icons.logout, color: Colors.black),
              itemName: "Logout",
              itemPaddingColor: ColorPallete.yellow,
              redirectScreen: LoginScreen()),
        ],
      ),
    );
  }
}
