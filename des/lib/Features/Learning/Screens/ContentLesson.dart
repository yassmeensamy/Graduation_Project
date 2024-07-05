
import 'package:des/Features/Learning/LearningCubit/learning_cubit.dart';
import 'package:des/Features/Learning/LearningCubit/lesson_content_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart' as constants;

class ContentLesson extends StatelessWidget {
   int lesson_id;
  int Topic_Id;
  //List<String> subParagraphs = [];
  ContentLesson( {required this.lesson_id, required this.Topic_Id,});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //BlocProvider.of<LearningCubit>(context).GetTopicsandLessons(Topic_id);
        return false;
      },
      child: BlocProvider(
        create: (context) => LessonContentCubit()..FetchContent(lesson_id),
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
                                  color: Colors
                                      .black, // Ensure text color is contrasting
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
                            onPressed: () async {
                              print("topic ${Topic_Id}");
                              
                              await BlocProvider.of<LearningCubit>(context)
                                  .GetTopicsandLessons(Topic_Id);
                                   Navigator.pop(context);
                                  
                                  
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<LessonContentCubit, LessonContentState>
                    (
                       builder: (context, state)  
                      {
                          if (state is LessonContentloading)
                          {
                            return CircularProgressIndicator();
                          }
                          else if (state is LessonContenterror)
                          {
                            return Center(child:Text("Sorry,Failed to loaded the Content of lesson please Check your Conntection"));
                          }
                          return 
                        Expanded(
                                child: ListView.builder(
                                 itemCount:  BlocProvider.of<LessonContentCubit>(context).subParagraphs.length,
                      // physics: ClampingScrollPhysics(), // Prevents bouncing/stretching
                                  itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                                    child: Text(
                                             BlocProvider.of<LessonContentCubit>(context).subParagraphs[index],
                                         style: TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
                  );
                      }
                    )
                ],
              
              ),
            ),
      ),
    );
        
  }
}



