import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final void Function() ontap;
  Color groundColor;
  String text;
  Color ?TextColor;
  NextButton(
      {super.key,
      required this.ontap,
      required this.groundColor,
      required this.text,
      this.TextColor,
      });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xff9CABC2).withOpacity(.6)),
          color: groundColor),
      child: InkWell(
        onTap: ontap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color:TextColor== null? Colors.black.withOpacity(.6) :TextColor,
                fontSize: 18,
                /*fontFamily: GoogleFonts.openSans().fontFamily,*/ fontWeight:
                    FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
