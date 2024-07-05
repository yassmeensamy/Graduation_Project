import 'package:cached_network_image/cached_network_image.dart';
import 'package:des/Features/Learning/LearningCubit/learning_cubit.dart';
import 'package:des/Features/Learning/Models/LearningModel.dart';
import 'package:des/Features/Learning/Models/Lesson.dart';
import 'package:des/Features/Learning/Screens/ContentLesson.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart' as constants;
class SelectedIndexCubit extends Cubit<int> 
{
  SelectedIndexCubit() : super(-1);
  void selectIndex(int index) {
    if (state == index) {
      emit(-1);
    } else {
      emit(index);
    }
  }
}
class TotalLessons extends StatelessWidget 
{
  Map<int,List<Lessons>>Total={};
  LearningModel? subtopics;
 TotalLessons(this.Total,this.subtopics);

  @override
  Widget build(BuildContext context) {;

    final screenHeight = MediaQuery.of(context).size.height;
    return 
    BlocProvider(
      create: (context) => SelectedIndexCubit(),
      child: WillPopScope(
      onWillPop: () async
      {
           BlocProvider.of<LearningCubit>(context).resetContent();
          return true;
      },
      child:
      Scaffold(
        body: BlocBuilder<SelectedIndexCubit, int>(
          builder: (context, selectedIndex) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: screenHeight * 0.4,
                  child: Container( 
                    child: 
                     CachedNetworkImage(
        imageUrl: constants.BaseURL+subtopics!.imagePath,
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: constants.mint.withOpacity(.5),
                   ),
        errorWidget: (context, url, error) => Center(
          child: Icon(
            Icons.error,
            color: Colors.red,
          ),
        ),
      ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.416,
                  left: 7,
                  right: 7,
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Color(0xff7F7F7F).withOpacity(.1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 5),
                        Text(
                          "You may revisit sessions after you’ve done them once",
                          style: GoogleFonts.nunitoSans(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.48,
                  left: 7,
                  right: 7,
                  //bottom: 50,
                  height: 40,
                  child: Text(
                    "Content",
                    style: GoogleFonts.nunitoSans(fontSize: 30),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.53,
                  left:10,
                  right: 20,
                  bottom: 0, 
                  child: ListView.builder(
                    physics:  ClampingScrollPhysics() ,//BouncingScrollPhysics(),
                    itemCount: subtopics!.subtopics!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<SelectedIndexCubit>().selectIndex(index);
                            },
                            child: 
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.black.withOpacity(.2), width: 2),
                                ),
                              ),
                              child:
                              
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                 Expanded(child: 
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.search),
                                      SizedBox(width: 4,),
                                      Expanded(child: 
                                      Text(
                                        subtopics!.subtopics![index].name,
                                        textAlign: TextAlign.left,
                                        softWrap: true,

                                        style: GoogleFonts.nunitoSans(fontSize: 16, fontWeight: FontWeight.w700),
                                      ),
                                      ),
                                    ],
                                  ),
                                 ),
                               
                                  
                                  Transform.rotate(
                                    angle: -180 * 3.1415926535 / 180,
                                    child: Icon(Icons.arrow_back_ios),
                                  ),
                                ],
                              ),
                              ),
                            
                          ),
                          if (selectedIndex == index)
                           ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                              itemCount: Total[subtopics!.subtopics![index].id]!.length,
                              itemBuilder: (context, ind) 
                              {
                                        return Container( 
                                        height: 60,      
                                    color: Total[subtopics!.subtopics![index].id]![ind].userProgress["read"]?Color(0xffE8FFED) :Color(0xff6495ED).withOpacity(.3),
                                    padding: EdgeInsets.all(0),
                                    child:Total[subtopics!.subtopics![index].id]![ind].userProgress["read"]?
                                     GestureDetector(
                                      onTap: ()
                                      async {
                                        print("you can read now");
                                        
                                         Navigator.pushReplacement
                                         (
                                              context, MaterialPageRoute(builder: (context) => ContentLesson ( lesson_id:  Total[subtopics!.subtopics![  index] .id]![ind]  .id!,Topic_Id: subtopics!.id),
                                              
                                                          ));
                                      },
                                         child:SubLessonContainer(Total: Total,subtopics: subtopics,ind:ind,index: index,),
                                        ):
                                        SubLessonContainer(Total: Total,subtopics: subtopics,ind:ind,index: index,),
                                        );        
                                },
                              ),
                           
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
   
    ),
    );
  }
}

class SubLessonContainer extends StatelessWidget 
{
   Map<int,List<Lessons>>Total={};
   LearningModel? subtopics;
    int index;
   int ind;
  SubLessonContainer({required this.Total, required this.ind,required this.index ,this.subtopics});
  @override
  Widget build(BuildContext context) {
    return  Padding(padding: EdgeInsets.only(left:10),
                                    child:
                                    
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children:
                                       [
                                              Container(
                                                width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                     shape: BoxShape.circle,
                                                      color:Color(0xff6495ED).withOpacity(.3)
                                                                        ),
                                                   child: Center(
                                                        child:Total[subtopics!.subtopics![index].id]![ind].userProgress["read"]? Icon(Icons.play_arrow) : Icon(Icons.lock),
                                                            ),
                                                          ),
                                                          SizedBox(width: 5,),
                                                          Expanded(child:
                                                          Text(
                                                           
                                                            Total[subtopics!.subtopics![index].id]![ind].name,
                                                            softWrap: true,
                                                            maxLines: 2,
                                                            style: TextStyle(color: Colors.black),),
                                                          )
                                      ],
                                    ),
                                    );
                                    
  
  }
}
