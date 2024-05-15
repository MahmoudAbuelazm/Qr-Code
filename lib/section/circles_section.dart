import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/half_circle.dart';

class CirclesSection extends StatelessWidget {
  const CirclesSection({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        CustomPaint(
          painter: HalfCirclePainter(),
          child: SizedBox(
            width: double.infinity,
            height: height / 6,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.1),
            Center(
              child: Text(
                'Login',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
