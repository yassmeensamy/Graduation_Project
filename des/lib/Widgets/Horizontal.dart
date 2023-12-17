import 'package:flutter/material.dart';

class HorizontalLineDrawingWidget extends StatelessWidget {
  const HorizontalLineDrawingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    
    CustomPaint(
      painter: HorizontalLinePainter(),
       // Set the size of the paint area
    );
  }
}

class HorizontalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
       ..color = const Color(0XFF9CABC2).withOpacity(.5)
      ..strokeWidth = 2.0;

    final start =  Offset(-110, 0); // Starting point of the horizontal line
    final end =  Offset(110.0, 0); // Ending point of the horizontal line

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}