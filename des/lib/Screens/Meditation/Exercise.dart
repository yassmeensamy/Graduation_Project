

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart' as constants;
import '../../Models/ExerciseModel.dart';
import 'MeditationScreen.dart';

class ExerciseScreen extends StatelessWidget 
{
 List <ExerciseModel>Exercise=[
      ExerciseModel(Image: 'Assets/left.png',
    title: 'Meditation',
    Content: 'Meditation is a practice for cultivating mental clarity, relaxation, and inner peace through focused attention or contemplation',),
    ExerciseModel(Image: 'Assets/rigth.png',
    title: 'Challenge Thougths',
    Content: 'CBT is a brief, goal-oriented therapy that targets and modifies negative thoughths.',)];
 
  ExerciseScreen();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: constants.pageColor,
      appBar: AppBar(
        title: 
        Text(
          "Exercise",
          style: TextStyle(color: Colors.black,fontFamily: GoogleFonts.inter().fontFamily,fontSize: 28),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
             ExerciseCard(exerciseModel: Exercise[0],background: constants.mint,startColor: constants.green,direction:"left" ,onTap: () 
             { 
                
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MeditationScreen(),
                    ),
                  );
                 
                },),
             SizedBox(height: 5,),
             ExerciseCard(exerciseModel: Exercise[1],background: constants.babyBlue30 ,startColor: constants.babyBlue,direction: "Rigth", onTap: () {  },),
             // SizedBox(height: 128,),
             
          ],
        )
        
        ),
      );
  }
}

class TitleExercise extends StatelessWidget 
{
  final String title;

  const TitleExercise({super.key, required this.title});
  
  @override
  Widget build(BuildContext context) 
  { 
    return  Text(
                title,style: TextStyle(
                        fontFamily: GoogleFonts.nunitoSans().fontFamily,
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        color: Colors.black
                                    ),
                    );
  }

}

class ContentExercise extends StatelessWidget {
  final String content;

  const ContentExercise({ required this.content}) ;

  @override
  Widget build(BuildContext context) {
    return 
    Expanded(child: 
    Text(
      content,
      textAlign: TextAlign.left,
      softWrap: true,
      style: TextStyle(
        fontFamily: GoogleFonts.nunitoSans().fontFamily,
        fontSize: 17,
        color: Colors.black.withOpacity(0.33),
      ),
    ),
    );
  }
}

class ImageExercise extends StatelessWidget 
{
  final String image;

  const ImageExercise({super.key, required this.image});
  
  @override
  Widget build(BuildContext context) 
  { 
    return  Center(
                child: Image.asset(image,   width: 170,
        height: 170,),
              
              );
  }

}


class StartExercise extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;

  const StartExercise({Key? key, required this.onTap, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Start Now',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
          Icon(
            Icons.play_arrow,
            color: color,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final ExerciseModel exerciseModel;
  final Color background;
  final Color startColor;
  final String direction;
  final VoidCallback onTap;

  ExerciseCard({
    required this.exerciseModel,
    required this.background,
    required this.startColor,
    required this.direction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 17, right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: background,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 23, top: 23, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleExercise(title: exerciseModel.title),
              if (direction == "left")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ContentExercise(content: exerciseModel.Content),
                    ImageExercise(image: exerciseModel.Image),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageExercise(image: exerciseModel.Image),
                    ContentExercise(content: exerciseModel.Content),
                  ],
                ),
              StartExercise(
                onTap: onTap,
                color: startColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
