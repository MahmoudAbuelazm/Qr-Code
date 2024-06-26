import 'package:flutter/material.dart';

import '../section/circles_section.dart';
import '../section/login_section.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const CirclesSection(),
          SizedBox(height: height * 0.15),
          const LoginSection()
        ],
      ),
    );
  }
}
