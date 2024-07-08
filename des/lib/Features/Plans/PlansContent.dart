import 'package:cached_network_image/cached_network_image.dart';
import 'package:des/Components/CachedNetworl.dart';
import 'package:des/Features/HomeScreen/HomeCubits/DepressionPlanCubit/depression_cubit.dart';
import 'package:des/Features/Plans/Models/TopicModel.dart';
import 'package:des/Features/Plans/Plan.dart';
import 'package:des/Features/Plans/PlanCubit/topics_plan_cubit.dart';
import 'package:des/Features/Plans/PlanDescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '/constants.dart' as constants;

class PlansContent extends StatelessWidget 
{
  List<TopicModel>PlansTopics=[];
  PlansContent({super.key});

 List<TopicModel>removeItemsNotInFirstList(List<TopicModel> PlansTopics, List<TopicModel> list2)
 {
    Set<String> namesPlansTopics = PlansTopics.map((obj) => obj.name).toSet();
    list2.removeWhere((obj) => !namesPlansTopics.contains(obj.name));
    return list2;
  }

void Enrolldepressiontest(BuildContext context) {

  
    bool flag = false;
    final depressionTopic = context.read<DepressionCubit>().topic;
    if (depressionTopic?.name != null) 
    {
        if(context.read<TopicsPlanCubit>().enrolledPlans.length==0)
        {
          flag=true;
        }
        else 
        {
      for (int i = 0;i < context.read<TopicsPlanCubit>().enrolledPlans.length; i++) 
      {
            if (depressionTopic!.name != context.read<TopicsPlanCubit>().enrolledPlans[i].name) 
        {
          flag = true;
        } 
        else
        {
          flag = false;
          break; 
        }
      }
        }
      if (flag == true) 
      {
        context.read<TopicsPlanCubit>().enrolledPlans.add(depressionTopic!);
      }
    }
    else 
    {
      context.read<TopicsPlanCubit>().enrolledPlans=
       removeItemsNotInFirstList(context.read<TopicsPlanCubit>().PlansTopics,context.read<TopicsPlanCubit>().enrolledPlans);
    }
  }

  @override
  Widget build(BuildContext context) 
  {
   
    return BlocConsumer<TopicsPlanCubit,TopicsPlanState>(
      builder: (context, state) 
      {
        if(state is TopicsPlanErrorState)
        {
           return Container(color: Colors.red);  
        }
        else if (state is TopicsPlanLoadingState)
        {
            return PlanContentLoading();
        }
        else 
        {

          
             Enrolldepressiontest(context);
         
          return 
          Scaffold(
          backgroundColor: constants.pageColor,
            body: Padding(
                   padding: EdgeInsets.only(top:40, left: 10, right: 10),
               child: SingleChildScrollView(
                child:
                Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("What brings you to \n SoulSync",style: GoogleFonts.inter(fontSize: 27,fontWeight: FontWeight.w500),),
                          
                         context.read<TopicsPlanCubit>().enrolledPlans.isNotEmpty?
                         EnrolledPlan(flag:true):SizedBox.shrink(),
                     
                         SizedBox(height: 5,),
                        context.read<TopicsPlanCubit>().UnenrolledPlans.isNotEmpty? EnrolledPlan(flag: false)
                      : SizedBox.shrink(),
                      
            ],
        ),
            
      )
          
    ),
          );
  }
    },
      listener:  
      (context, state) 
      {
       if(state is TopicsPlanLoadedState)
       {
        PlansTopics=state.topicsList;
        
       }
      }
      
    );
  }
  

}



































class PlanCard extends StatelessWidget 
  {
  final TopicModel? topic;
  PlanCard(this.topic);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: InkWell(
            onTap:()
             {
              topic!.enrolled! ?
                                Navigator.push(context,MaterialPageRoute(builder: (context) => PlanScreen(topic!.name),)): Navigator.push(context,MaterialPageRoute(builder: (context) => PlanDescrtion(topic!),));
          
            },
          child:
           Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              ),
              child:CachedImage(imageUrl: topic!.image),
               
            ),
        )
          ),
        
        Positioned(
          top: 150,
          left: 10,
          right: 10,
          child: Text(
            topic!.name,
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
class PlanContentLoading extends StatelessWidget 
{
  const PlanContentLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      body:
            Column(
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
          
            (context, index) => Shimmer.fromColors(
              baseColor:constants.mint.withOpacity(.5),
              highlightColor: constants.mint,
              child: Container(color: Colors.grey,),
  ), 
            childCount:6,
          ),
                ),
            ),
          ],
        ),
      );
    
  }
}
class PlanArrange extends StatelessWidget 
{
  List<TopicModel>PlansTopics;
   PlanArrange(this.PlansTopics);
  @override
  Widget build(BuildContext context) {
    return
      GridView.custom(
            physics: ScrollPhysics(),
            shrinkWrap: true,
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
          childrenDelegate: SliverChildBuilderDelegate
          (
            (context, index) => PlanCard( PlansTopics[index],),
            childCount: PlansTopics.length,
          ),
                );
  
      
  }
}
class EnrolledPlan extends StatelessWidget 
{
  bool flag=false;
   EnrolledPlan({required this.flag});
  @override
  Widget build(BuildContext context) {
    return  Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: 
                          [ 
                             Text(flag==false?"choose a topic to focus on:":"YourPlan",style: GoogleFonts.abhayaLibre(fontSize: 30,color: Color(0xffA1A4B2)),),
                              PlanArrange( flag == false?context.read<TopicsPlanCubit>().UnenrolledPlans: context.read<TopicsPlanCubit>().enrolledPlans)
                          ],
                          );
  }
}