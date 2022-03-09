import 'package:flutter/material.dart';

class HomeTemplate extends StatelessWidget {
  final AppBar? appBar;
  final Widget? body;
  final BottomNavigationBar? bottomNavigationBar;

  const HomeTemplate({
    Key? key,
    this.appBar,
    this.body,
    this.bottomNavigationBar
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
