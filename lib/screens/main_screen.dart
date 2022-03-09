import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/screens/home_screen.dart';
import 'package:monets/screens/login_screen.dart';
import 'package:monets/screens/profile_screen.dart';
import 'package:monets/screens/signup_screen.dart';

import 'favourites_screen.dart';
import 'reservations_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    HomeScreen(),
    ReservationsScreen(),
    FavouritesScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1
          )
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: pageIndex,
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          selectedIconTheme: const IconThemeData(color: ColorPallete.purple),
          selectedItemColor: ColorPallete.purple,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Početna'),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt), label: 'Rezervacije'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined),
                label: 'Favoriti'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profil'),
          ],
        ),
      ),
    );
  }
}
