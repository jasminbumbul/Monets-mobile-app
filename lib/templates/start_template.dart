import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';

class StartTemplate extends StatelessWidget {
  final Widget body;

  const StartTemplate({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.yellow,
      body: body,
    );
  }
}