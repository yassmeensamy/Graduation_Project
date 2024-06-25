import 'package:cached_network_image/cached_network_image.dart';
import 'package:des/Models/Plans/TopicModel.dart';
import 'package:des/Screens/Plans/DayTipScreen.dart';
import 'package:des/Screens/Plans/Plan.dart';
import 'package:des/cubit/PlanCubits/cubit/topics_plan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '/constants.dart' as constants;

class PlansContent extends StatelessWidget 

{
  const PlansContent({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    BlocConsumer<TopicsPlanCubit,TopicsPlanState>(
      builder: (context, state) 
      {
        if(state is TopicsPlanLoadingState)
        {
           return Container(color: Colors.deepPurple,);
        }
        else if (state is TopicsPlanLoadedState)
        {
            return _PlansContent(state.topicsList);
        }
        else 
        {
          return Container(color:Colors.teal);
        }
      },


      listener:  (context, state) {},
    );
  }
}

class _PlansContent extends StatelessWidget 
{
  List<TopicModel>topicPlan;
   _PlansContent(this.topicPlan) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.pageColor,
      body: Padding(
        padding: EdgeInsets.only(top: 35, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("What brings you to \n SoulSync",style: GoogleFonts.inter(fontSize: 27,fontWeight: FontWeight.w500),),
            Text("choose a topic to focus on:",style: GoogleFonts.abhayaLibre(fontSize: 20,color: Color(0xffA1A4B2)),),
            Expanded(child:
                GridView.custom(
                  physics: ScrollPhysics(),
            gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 4,
            pattern: [
              WovenGridTile(.9, ),
              WovenGridTile(.9,
              crossAxisRatio:.9,
                ),
         
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
          
            (context, index) => PlanCard(topicPlan[index]),
            childCount: topicPlan.length,
            // Define the count of children here
          ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final TopicModel topic;

  PlanCard(this.topic);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: InkWell(
            onTap:()
            {
               Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlanScreen(),
            )
          ); 
            },
          child:
           Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              ),
              child:
                CachedNetworkImage(
                  imageUrl: topic.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
                ),
            ),
        )
          ),
        
        Positioned(
          top: 120, // Adjusted to place the text below the image
          left: 10,
          child: Text(
            topic.name,
            softWrap: true,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
