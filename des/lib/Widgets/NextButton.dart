import 'package:des/Screens/JournalingScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NextButton extends StatelessWidget
{
  final void  Function() ontap;
  NextButton({required this.ontap});
  Widget build (BuildContext context)
  {
  return  Container(
                width: 280, // Set the desired width
                height: 45, // Set the desired height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Color(0xff9CABC2).withOpacity(.6)),
                  color: Color(0xFFD5E8E4),
                ),
                child: InkWell(
                  onTap: ontap,
                
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.black.withOpacity(.6) ,fontSize: 18,fontFamily: GoogleFonts.openSans().fontFamily,fontWeight:FontWeight.w400),
                    ),
                  ),
                ),
              );
  }
}