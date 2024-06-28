import 'package:des/cubit/cubit/learning_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart' as constants;


class ContentLesson extends StatelessWidget 
 {
  int Topic_id;
  List<String> subParagraphs=[];
  ContentLesson(this.subParagraphs,this.Topic_id ,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) 
  {
    return 
    
    WillPopScope(
      onWillPop: () async
      {
          //BlocProvider.of<LearningCubit>(context).GetTopicsandLessons(Topic_id);
          return false;
      },
      
    
      child:
      
       Scaffold(
      backgroundColor: constants.mint,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Container(
              padding: EdgeInsets.only(top: 40, left: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Overview",
                        style: GoogleFonts.abhayaLibre(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Ensure text color is contrasting
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Hello There,",
                        style: GoogleFonts.abhayaLibre(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.black.withOpacity(.8),
                      size: 34,
                    ),
                    onPressed: () 
                    {
                       
                      BlocProvider.of<LearningCubit>(context).GetTopicsandLessons(Topic_id);
                    },
                  ),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              itemCount:
                subParagraphs.length,
             // physics: ClampingScrollPhysics(), // Prevents bouncing/stretching
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    subParagraphs[index],
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ),
          
        ],
      ),
    ),
    );
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}



/*
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column
        (
          children: 
          [
            Text("Overview",style: GoogleFonts.abhayaLibre(fontSize: 20 ,fontWeight: FontWeight.bold),),
            Text("Hello There,",style: GoogleFonts.abhayaLibre(fontSize: 20 ,fontWeight: FontWeight.bold),),
            SizedBox(height: 30,),
            ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) 
            {
              return  Padding(padding: EdgeInsets.only(bottom: 10, top: 10),
                                   child:Text("hello hello"),
                           );
            }
            ),
          ],
        ),
      ),
      */


