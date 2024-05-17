import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../cubit/cubit/insigths_cubit.dart';
import 'MoodGraph.dart';
import 'graph.dart';

class InsightScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InsigthsCubit, InsigthsState>(
      listener: (context, state) {
        if (state is InsightError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) 
      {
        if (state is InsightLoading) 
        {
          return InsigthViewLoading();
        
        } 
        else if (state is InsightLoaded) 
        {
          return 
        Scaffold(
    body: SafeArea(
    child: Padding(padding: EdgeInsets.only(left:7,right: 7),
    child:
     ListView(
      children: [
       Padding(padding: EdgeInsets.only(left:20),
       child: 
        Text("Insigths",style: GoogleFonts.roboto(fontSize: 40),),
       ),
        MoodGraph(),
        SizedBox(height: 7,),
        DepresionGraph(salesData: state.data1),
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
        return Center(child: Text('Press a button to load data.'));
      },
    );
  }
}
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