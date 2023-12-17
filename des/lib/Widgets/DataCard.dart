import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  String Date;
  DateCard({required this.Date});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 130,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 0.1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Date),
            const SizedBox(
              width: 10,
            ),
            Transform.rotate(
              angle:
                  270 * 3.1415926535 / 180, // Rotate 180 degrees (in radians)
              child: const Icon(
                Icons.arrow_back_ios,
                size: 13,
              ),
            )
          ],
        ));
  }
}
