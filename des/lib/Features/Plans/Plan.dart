
import 'package:des/Features/HomeScreen/HomeCubits/HandleNavigtionCubit/home_cubit.dart';
import 'package:des/Features/Plans/DayTipScreen.dart';
import 'package:des/Features/Plans/Models/TopicModel.dart';
import 'package:des/Features/Plans/PlanCubit/plan_tips_cubit.dart';
import 'package:des/Features/Plans/PlanCubit/topics_plan_cubit.dart';
import 'package:des/Features/Plans/Widgets/TopicPhoto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constants.dart' as constants;

class PlanScreen extends StatelessWidget 
{ 
  String topic_name;
  late TopicModel PlansTopicTips;
  PlanScreen(this.topic_name);
  @override
  Widget build(BuildContext context) 
  {
    return WillPopScope(
       onWillPop: () async 
       {
        try
         {
          context.read<TopicsPlanCubit>().FetchMainTopics();
          

             BlocProvider.of<HomeCubit>(context).changeIndex(4);
             Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
        
          return false;
        } 
        catch (e) 
        {
          print("حصل خطأ في FinishEntry أو التنقل: $e");
          return false;
        }
      },
    
    child:
    BlocProvider(
      create: (context) => PlanTipsCubit().. FetchPlanActivities(topic_name,context),
      child: BlocConsumer<PlanTipsCubit, PlanTipsState>(

           
        builder: (context, state)
         {
          if (state is PlanTipsLoaded) 
          { 
            
            final screenHeight = MediaQuery.of(context).size.height;
              return Scaffold(
                  body: Stack(
              children: [
         TopicPhoto(PlansTopicTips.image),
    
        Positioned(
            top: screenHeight * 0.3, // Start below the first container
            left: 0,
            right: 0,
            bottom: 0, // Take up the remaining visible area
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 50, left: 50),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Number of columns
                  mainAxisSpacing: 30, // Spacing between rows
                  crossAxisSpacing: 30, // Spacing between columns
                  childAspectRatio: 1, // Aspect ratio of each grid item
                ),
                itemCount: PlansTopicTips.Activities.length,
                itemBuilder: (context, index) {
                  return GridTile(
                   
                    child: PlansTopicTips.Activities[index].flag!
                        ?
                         GestureDetector(
                            onTap: () 
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DayTipScreen(index,PlansTopicTips.Activities[index].content!)),
                              );
                            },
                            child: DayCard(index, PlansTopicTips),
                          ): DayCard(index, PlansTopicTips)  
                  );
                },
              ),
            ),
          ),
        Positioned(
            top: screenHeight * 0.9,
            left: 220,
            right: 0,
            child: TextButton(
              onPressed: () {
                
                BlocProvider.of<PlanTipsCubit>(context)
                    .RestartPlan(PlansTopicTips.name);
                 
              },
              child: Text(
                "Restart",
                style: GoogleFonts.openSans(
                 //color:   Color(int.parse('0xFF${PlansTopicTips.colorTheme.replaceFirst('#', '')}')),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
         ]
         ),
          
              );
           
       
          }  
          else if (state is PlanTipsError) 
          {
            return Container(color: Colors.red);
          }
           else 
          {
              return PlanTipsLoading();
           } 
         },
         listener: (context, state)
         {
          if (state is PlanTipsLoaded)
          {
                PlansTopicTips=state.PlansTopicTips;
          }
          if(state is PlanRestart)
          {
            
          }
         } ,
      ),
    )
  
    );
  }
}
class DayCard extends StatelessWidget 
{
  int index ;
  TopicModel PlansTopicTips;
  DayCard(this.index,this.PlansTopicTips);
  @override
  Widget build(BuildContext context) {
    return  Container(
                width: 10,
                height: 10,
                color: PlansTopicTips.Activities[index].flag! ?constants.mint : Colors.white,
                child:Center(child:
                Text((index+1).toString(),style: GoogleFonts.abhayaLibre(textStyle: TextStyle(fontWeight: FontWeight.bold),fontSize: 20),)
                 )
     );
  }
}
class PlanTipsLoading extends StatelessWidget {
  const PlanTipsLoading({super.key});

  @override
  Widget build(BuildContext context) 
  {
      final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            top: 0,
            left: 0,
            right: 0,
           bottom:screenHeight * 0.48 ,
            child:
            Shimmer.fromColors(
                     baseColor:constants.mint.withOpacity(.5),   
                     highlightColor: constants.mint,
                     child:
                      Container(
                           color:  constants.mint 
                       ),
          ),
          ),
          Positioned(
            top: screenHeight * 0.32, // Start below the first container
            left: 0,
            right: 0,
            height: screenHeight * 0.7, // Take up the remaining visible area
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: constants.pageColor,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.3, 
            left: 0,
            right: 0,
            bottom: 0, 
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 50, left: 50),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Number of columns
                  mainAxisSpacing: 30, // Spacing between rows
                  crossAxisSpacing: 30, // Spacing between columns
                  childAspectRatio: 1, // Aspect ratio of each grid item
                ),
                itemCount:21,
                itemBuilder: (context, index) {
                  return GridTile(
                    child:Shimmer.fromColors(
                     baseColor:constants.mint.withOpacity(.5),   
                     highlightColor: constants.mint,
                   child:  Container(
                          width: 10,
                            height: 10,)
  ), 
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  
  }
}


