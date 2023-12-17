import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';

void errorToast(String txt) {
  showToastWidget(
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: Colors.red),
        child: Text(
          txt,
          style: TextStyle(
              fontFamily: GoogleFonts.comfortaa().fontFamily,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontSize: 16),
        ),
      ),
      position: const ToastPosition(
        align: Alignment.bottomCenter,
      ));
}
void successToast(String txt) {
  showToastWidget(
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: Colors.green),
        child: Text(
          txt,
          style: TextStyle(
              fontFamily: GoogleFonts.comfortaa().fontFamily,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontSize: 16),
        ),
      ),
      position: const ToastPosition(
        align: Alignment.bottomCenter,
      ));
}
