import 'package:flutter/material.dart';

class NextButton extends StatelessWidget
{
  final void  Function() ontap;
  Color groundColor;
  String text;
  NextButton({super.key, required this.ontap ,required this.groundColor ,required this.text});
  @override
  Widget build (BuildContext context)
  {
  return  Container(
                width: 270, // Set the desired width
                height: 45, // Set the desired height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xff9CABC2).withOpacity(.6)),
                  color: groundColor
                ),
                child: InkWell(
                  onTap: ontap,
                
                  child: Center(
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.black.withOpacity(.6) ,fontSize: 18,/*fontFamily: GoogleFonts.openSans().fontFamily,*/fontWeight:FontWeight.w400),
                    ),
                  ),
                ),
              );
  }
}