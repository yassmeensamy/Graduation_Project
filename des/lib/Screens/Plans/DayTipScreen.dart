import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DayTipScreen extends StatelessWidget {
  const DayTipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50,left: 30,right: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Day3" ,style: GoogleFonts.abhayaLibre(fontSize: 24,fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Container(
            height: 360,
            width: 390,
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.black.withOpacity(.3)),
                borderRadius: BorderRadius.circular(30)
              ),
              child: Center(
                child: Text(
                  "Break down larger objectives into smaller, manageable tasks with deadlines. This structured approach helps to stay focused and organized.",
                  style: GoogleFonts.abhayaLibre(fontSize: 24,fontWeight: FontWeight.bold), // Add your text style here
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
