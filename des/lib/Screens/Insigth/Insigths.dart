import 'package:des/Screens/Insigth/WeeklyGraph.dart';
import 'package:des/Screens/Insigth/bargraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../cubit/cubit/insigths_cubit.dart';
import 'MoodGraph.dart';
import 'graph.dart';

class InsightScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


   
    /*
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<InsigthsCubit>(context).loadInsights();
    });
    */
  return 
   BlocConsumer<InsigthsCubit, InsigthsState>(
      listener: (context, state) 
      {
      
      },
      builder: (context, state) 
      {
        if (state is InsightLoading) 
        {
          return InsigthViewLoading();
        } 
        else if (state is InsightLoaded) 
        {
          return  Scaffold(
               body: SingleChildScrollView(
    child: Padding(padding: EdgeInsets.only(left:10,right: 10 ,bottom: 5 ,top:30),
    child:
     Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Padding(padding: EdgeInsets.only(left:20),
       child: 
        Text("Insights",style: GoogleFonts.roboto(fontSize: 40),),
       ),
        MoodGraph(BlocProvider.of<InsigthsCubit>(context).MoodHistory),
        SizedBox(height: 7,),
        DepresionGraph(depressionhistory: BlocProvider.of<InsigthsCubit>(context).DepressionHistoy),
         SizedBox(height: 7,),
        Bargraph(monthlyData: BlocProvider.of<InsigthsCubit>(context).AcivityMonthHistory,annuallyData: BlocProvider.of<InsigthsCubit>(context).AcivityYearHistory),
        SizedBox(height: 7,),
        WeeklyGraph(weeklyHistory: BlocProvider.of<InsigthsCubit>(context).weeklyHistoy!)
      ],
    ),
  ),
),
        );
        } 
        else if (state is InsightError) 
        {
          return Center(child: Text('Error: ${state.message}'));
        }
        print(state.runtimeType);
        return Center(child: Text('Press a button to load data.'));
      },
    );
  }
}
/*
class InsigthViewLoading extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      ListView(
        children: [
           Padding(padding: EdgeInsets.only(left:20),
       child: 
        Text("Insigths",style: GoogleFonts.roboto(fontSize: 40),),
       ),
      Container(
      height: 340,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(.1),
      ),
      
           ),
       SizedBox(height: 10,),
      Container(
       height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(.1),
      ),
            ),
        ],
      ),
    );
  }
}
*/

class InsigthViewLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Insights",
              style: GoogleFonts.roboto(fontSize: 40),
            ),
          ),
          for (int i = 0; i < 2; i++)
            Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(.1),
              highlightColor: Colors.grey.withOpacity(.5) ,
              child: 
              Padding(
                padding: const EdgeInsets.only(top:10),
                child: Container(
                  height: 340,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ),
              ),
            ),
         
        ],
      ),
    );
  }
}


/*
class InsigthViewLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Insigths",
              style: GoogleFonts.roboto(fontSize: 40),
            ),
          ),
          Container(
            height: 340,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey.withOpacity(.1),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey.withOpacity(.1),
            ),
          ),
        ],
      ),
    );
  }
}
*/