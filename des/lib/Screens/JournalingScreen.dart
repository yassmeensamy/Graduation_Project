import 'package:des/Cubits/JournalingCubit/CubitState.dart';
import 'package:des/Cubits/JournalingCubit/JournalingCubit.dart';
import 'package:des/Screens/Activities.dart';
import 'package:des/Widgets/NextButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class Journalingcreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JournalingCubit(),
      child: JournalingScreen(),
    );
  }
}

class JournalingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            JournalingTitle(),
            SizedBox(height: 8),
            JournalingImage(),
            SizedBox(height: 4),
            JournalingContainer(),
            // Remove the unnecessary comment
            SizedBox(height: 25),
            NextButton(
              ontap: ()
              {
                 Navigator.push(context,MaterialPageRoute(builder: (context) => Activities()));
              },
            ),
          ],
        ),
      ),
    );
  }
}


class JournalingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use BlocBuilder to get the state from the JournalingCubit
    return BlocBuilder<JournalingCubit, JournalingState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Stack(
            children: [
              Container(
                width: 330,
                child: TextField(
                  maxLines: 17,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color.fromARGB(255, 18, 26, 170)),
                    ),
                    hintText: '  What\'s on your mind? ',
                    hintStyle: TextStyle(
                      fontFamily: GoogleFonts.comfortaa().fontFamily,
                      fontSize: 18,
                    ),
                  ),
                  onChanged: (text) {
                    context.read<JournalingCubit>().CountLetters(text);
                  },
                  inputFormatters: [LengthLimitingTextInputFormatter(30)], // Limit to 30 characters
                ),
              ),
              Positioned(
                bottom: 17,
                right: 17,
                child: Text(
                  state is WritingJouenalingState
                      ? '${state.wordsNumbers}/3000'
                      : '', // Display count only when writing is true
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}



class JournalingImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(
        image: AssetImage('assets/images/Journaling.png'),
        width: 350,
        height: 205,
      ),
    );
  }
}

class JournalingTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:30),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Center(
              child: Column(
                children: [
                 
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios, size: 13),
                      ),
                      SizedBox(width: 35),
                      Text(
                        "Add any thoughts that",
                        style: TextStyle(
                      fontSize: 20,
                      fontFamily: GoogleFonts.openSans().fontFamily,
                      color: Color(0xFF000000),
                    ),
                      ),
                    ],
                  ),
                 
                  SizedBox(height:1), // Adding some space between the icon and text
                  Text(
                    'are reflecting your Mood',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: GoogleFonts.openSans().fontFamily,
                      color: Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

