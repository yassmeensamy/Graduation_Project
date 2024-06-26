import 'package:cached_network_image/cached_network_image.dart';
import 'package:des/Models/Plans/TopicModel.dart';
import 'package:des/Screens/Plans/DayTipScreen.dart';
import 'package:des/cubit/PlanCubits/cubit/plan_tips_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart' as constants;

class PlanScreen extends StatelessWidget 
{ 
  String topic_name;
   PlanScreen(this.topic_name);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlanTipsCubit()..FetchPlanActivities(topic_name),
      
      child:
     BlocBuilder<PlanTipsCubit, PlanTipsState>(
        builder: (context, state)
         {
          if (state is PlanTipsLoaded) 
          {
            return _PlanScreen(state.PlansTopicTips);
          } 
          else if (state is PlanTipsLoading) 
          {
            return Container(color: Colors.red);
          }
           else 
          {
            print(state.runtimeType);
            return Container(color: Colors.brown);
          }
        },
      ),
    );
  }
}

class _PlanScreen extends StatelessWidget {
  final TopicModel PlansTopicTips;
  
  _PlanScreen(this.PlansTopicTips);

  @override
  Widget build(BuildContext context) {
    //print(PlansTopicTips.colorTheme.replaceFirst(from, to));
    final screenHeight = MediaQuery.of(context).size.height;
    String m=constants.BaseURL+PlansTopicTips.image;
    print(m);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            top: 0,
            left: 0,
            right: 0,
           bottom:screenHeight * 0.48 ,
            child:
            Container(
             
              child: 
              CachedNetworkImage(
                
                height: screenHeight * 0.35,
                imageUrl: constants.BaseURL+PlansTopicTips.image,
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
                    child: PlansTopicTips.Activities[index].flag
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DayTipScreen(index)),
                              );
                            },
                            child: DayCard(index+1, PlansTopicTips),
                          )
                        : DayCard(index, PlansTopicTips),
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
                /*
                BlocProvider.of<PlanTipsCubit>(context)
                    .restartPlan(PlansTopicTips.name);
                    */
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
        ],
      ),
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
    return 
  
     Container(
                width: 10,
                height: 10,
                color: PlansTopicTips.Activities[index].flag?constants.mint : Colors.white,
                child:Center(child:
                Text((index+1).toString(),style: GoogleFonts.abhayaLibre(textStyle: TextStyle(fontWeight: FontWeight.bold),fontSize: 20),)
                 )
                );
    
  }
}


/*

class PlanScreen extends StatelessWidget 
{
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.35, // Set to 1/4 of screen height
            child: Container(
              decoration: BoxDecoration(
                color: constants.mint,
              ),
              child:
              Padding(padding: EdgeInsets.only(top:50),child:
              Column(
                children: [
                Text(
                  "Improve Performance",
                  style: GoogleFonts.abhayaLibre(
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                      //letterSpacing: 0.5, // Adjusted the value for readability
                    ),
                  ),),
                  Image.asset("Assets/Journaling.png",height: 140,width: 200,)
                ],
              ),
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
            top: screenHeight * 0.3, // Start below the first container
            left: 0,
            right: 0,
           bottom: 0, // Take up the remaining visible area
            child:
            Padding(
              padding: const EdgeInsets.only(top:20,right:50,left: 50),
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
                         child:DayCard(),
                        );
              },
            ),
            )

          ),
            Positioned(
            top: screenHeight * 0.9, 
            left: 220,
            right: 0,
            //height: screenHeight , // Take up the remaining visible area
            child:TextButton(onPressed:(){} ,child:Text("Restart" ,style: GoogleFonts.openSans(color: constants.darkmint,fontSize: 20,fontWeight: FontWeight.bold),) ,),
            ),
          
        ],
      ),
    );
  }
}

class DayCard extends StatelessWidget 
{
  const DayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
                width: 10,
                height: 10,
                color: Colors.white, 
                child:Center(child:
                Text("1",style: GoogleFonts.abhayaLibre(textStyle: TextStyle(fontWeight: FontWeight.bold),fontSize: 20),)
                 ),// Example color
                );
  }
}


*/