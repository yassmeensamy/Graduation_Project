import 'package:flutter/material.dart';

class UpperBgCircle extends StatelessWidget {
  final Color? color;
  final String? txt;
  final double? size;
  const UpperBgCircle(this.color, this.txt, this.size,{super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -80,
      left: -50,
      child: Container(
        width: size!,
        height: size!,
        decoration: BoxDecoration(
          color: color!,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:const EdgeInsets.all(85.0),
              child: Text(
                txt!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 44,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
