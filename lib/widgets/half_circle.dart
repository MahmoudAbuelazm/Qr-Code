import 'package:flutter/material.dart';

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xffFE7D55).withOpacity(.2)
      ..style = PaintingStyle.fill;

   
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width - size.width * .088, 0),
          radius: size.width * 0.3),
      0,
      3.14, 
      true,
      paint,
    );

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2.3, -size.width / 4),
          radius: size.width * 0.6),
      0,
      3.14, 
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
