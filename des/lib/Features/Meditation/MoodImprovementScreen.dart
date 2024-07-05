
import 'package:des/Features/HomeScreen/HomeCubits/HandleNavigtionCubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart' as constants;

class MoodImprovementScreen extends StatelessWidget {
  final double moodImprovementPercentage;
  final String tip;

  const MoodImprovementScreen(
      {super.key, required this.moodImprovementPercentage, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.pageColor,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 42),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Text("Your Mood Improvement",
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                            fontFamily: GoogleFonts.comfortaa().fontFamily,
                            fontSize: 32,
                            fontWeight: FontWeight.bold)),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<HomeCubit>(context).changeIndex(2);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    },
                    child: Icon(
                      Icons.close,
                      size: 24.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 17, color: Colors.transparent),
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6495ED), Color(0xFFB57EDC)],
                  ),
                ),
                child: Container(
                  width: 230.0,
                  height: 230.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0, color: Colors.transparent),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      "${moodImprovementPercentage.toStringAsFixed(2)}%",
                      style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.w100,
                        color: const Color(0xFF6495ED),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Center(
                child: Text(
                  '$tip',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
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
