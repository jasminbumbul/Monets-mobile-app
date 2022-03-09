import 'package:flutter/material.dart';

class LoginTemplate extends StatelessWidget {
  final Widget body;

  const LoginTemplate({
    Key? key,
    required this.body,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body
    );
  }
}