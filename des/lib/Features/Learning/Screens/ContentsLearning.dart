import 'package:cached_network_image/cached_network_image.dart';
import 'package:des/Features/Learning/LearningCubit/learning_cubit.dart';
import 'package:des/Features/Learning/Models/LearningModel.dart';
import 'package:des/Features/Learning/Screens/TotalLessons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constants.dart' as constants;

class ContentsLearning extends StatelessWidget {
  const ContentsLearning({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LearningCubit, LearningState>(
      listener: (context, state) {
        if (state is LearningSubTopicsState ) 
        {
         
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TotalLessons(state.Total, state.subtopics)),
          );    
        }
      },
      builder: (context, state) 
      {
        if (state is LearningLoaded) 
        {
          return _ContentsLearning(state.MainTopics);
        } 
         else if (state is LearningError)
         {
            
            return Container(color: Colors.red,);
         }
        
        else 
            {
                return LearningLoading();
            }
        
      },
    );
  }
}

class _ContentsLearning extends StatelessWidget {
  List<LearningModel>mainTopics;
  _ContentsLearning(this.mainTopics);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: 
       Scaffold(
        
        backgroundColor:constants.pageColor ,
        body: Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Padding(
          padding: const EdgeInsets.only(left:15,bottom: 15),
          child: Text("Learning Path" ,style:GoogleFonts.inter(fontSize: 34,)),
        ),
        Expanded(child: 
         GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 6.0, // Spacing between columns
            mainAxisSpacing: 10.0,
            childAspectRatio: .87, // Spacing between rows
          ),
          itemCount: mainTopics.length, // Number of items in the grid
          itemBuilder: (BuildContext context, int index) 
          {
            return LearnCard(Topic: mainTopics[index]);
          }
        
        ),
        ),
          ]
        )
        )
    
      ),
    );
  }
}

class LearnCard extends StatelessWidget 
{
   final LearningModel? Topic;
   LearnCard({this.Topic}) ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () 
       {

         BlocProvider.of<LearningCubit>(context).GetTopicsandLessons(Topic!.id);
      },
      child:
     Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black.withOpacity(.23), 
          width: 1, 
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageContainer(imageUrl: Topic!.imagePath),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Topic!.topicName,
                  style: GoogleFonts.inter(fontSize: 16),
                  softWrap: true,
                ),
                SizedBox(height: 10),
                Container(
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: constants.mint
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Center(
                      child: Text(
                        "3 lessons",
                        style: GoogleFonts.inter(fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}
class ImageContainer extends StatelessWidget {
  final String? imageUrl;

  ImageContainer({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        width: double.infinity,
        height: 120,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: constants.mint.withOpacity(.5),
          //Colors.grey[300],
        ),
        errorWidget: (context, url, error) => Center(
          child: Icon(
            Icons.error,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class LearningLoading extends StatelessWidget 
{
  const LearningLoading({super.key});
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: 
       Scaffold(
        backgroundColor:constants.pageColor ,
        body: Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Padding(
          padding: const EdgeInsets.only(left:15,bottom: 15),
          child: Text("Learning Path" ,style:GoogleFonts.inter(fontSize: 34,)),
        ),
        Expanded(child: 
         GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 6.0, // Spacing between columns
            mainAxisSpacing: 10.0,
            childAspectRatio: .87, // Spacing between rows
          ),
          itemCount: 6, // Number of items in the grid
          itemBuilder: (BuildContext context, int index) 
          {
            return  Container
            (
                decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black.withOpacity(.23), 
          width: 1, 
        ),
      ),
               child:Shimmer.fromColors(
              baseColor:constants.mint.withOpacity(.5),
             
     highlightColor: constants.mint,
    child:  Container
    (
      color:Colors.black ,

    )
  ),

            );
          }
        
        ),
        ),
          ]
        )
        )
    
      ),
    );
  }
}
  





