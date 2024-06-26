import 'package:des/cubit/PlanCubits/cubit/plan_tips_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DayTipScreen extends StatelessWidget {
  int Index ;
   DayTipScreen(this.Index) ;
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50,left: 30,right: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Day ${Index.toString()}" ,style: GoogleFonts.abhayaLibre(fontSize: 24,fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Container(
            height: 360,
            width: 390,
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.black.withOpacity(.3)),
                borderRadius: BorderRadius.circular(30)
              ),
              child: Center(
                child: Text(
                 context.read<PlanTipsCubit>().PlansTopicTips.Activities[Index].content!,
                  style: GoogleFonts.abhayaLibre(fontSize: 24,fontWeight: FontWeight.bold), // Add your text style here
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
