
import 'package:des/Screens/Temp.dart';
import 'package:des/cubit/cubit/insigths_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Models/TestResultModel.dart';

class ResultScreen extends StatelessWidget 
{
   TestResultModel testResult;
  ResultScreen({super.key, required this.testResult});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:Center(child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Padding(padding: const EdgeInsets.only(top:42),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: 
            [
              //const SizedBox(width: 190),
              IconButton(
                onPressed: () 
                {
                    BlocProvider.of<InsigthsCubit>(context).fetchDepressionTestHistory();
                    Navigator.push(context,MaterialPageRoute(builder: (context) => temp()));
                },
                
                icon: const Icon(Icons.close),
              ), 
              const SizedBox(width: 95,),
              Center(child:
              Text("Result",style: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily,fontSize: 32,fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          ),
          const SizedBox(height: 40),
          Center(
          child :
          Container(
            decoration: BoxDecoration(
                border: Border.all(width:17,color: Colors.transparent ),
                shape: BoxShape.circle,
                 gradient: const LinearGradient(
                  begin: Alignment.topLeft,      // Starting point
                 end: Alignment.bottomRight,
                colors:  [Color(0xFF6495ED), Color(0xFFB57EDC)], 
                // Your gradient colors
              ), // Set your desired background color
              ),
              child:
               Container(
              width: 230.0, // Adjust the width as needed
              height: 230.0, // Adjust the height as needed
              decoration: BoxDecoration(
                border: Border.all(width:0,color: Colors.transparent ),
                shape: BoxShape.circle,
                color: Colors.white, // Set your desired background color
              ),
              child: Center(
                child: Text(
                   "${testResult.total_score.toString()}/100",
                  style: TextStyle(
                    
                    fontSize: 55,
                    fontWeight: FontWeight.w100,  
                    color: const Color(0xFF6495ED),
                  ),
                ),
              ),
            ), 
          ),
          ),
          
          const SizedBox(height: 30,),
           Text(testResult.level_of_depression,style: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily,fontSize: 32,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
          const SizedBox(height: 30,),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 28),
            child:
            Center(child:
            Text(testResult.description!,
         style: TextStyle(fontSize: 24.0,
            ),textAlign: TextAlign.center,),
          ),
      ), 
        ],
      ),
      ),
    );
  }
}
