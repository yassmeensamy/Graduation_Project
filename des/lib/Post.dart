import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart' as constants;

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:constants.pageColor, // Assuming constants.pageColor is defined
        appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Create Post",
          style: GoogleFonts.nunitoSans( fontWeight: FontWeight.w700, fontSize: 24, color: Colors.black),
        ),
        actions: [
          //TextButton(onPressed: (){}, child: )
        ],
      ),
      body: Center(
        child: Text("Your post content goes here"),
      ),
    );
  }
}
