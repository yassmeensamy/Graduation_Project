import 'package:des/Components/NextButton.dart';
import 'package:des/Features/HomeScreen/HomeCubits/PlanTaskCubit/plan_tasks_cubit.dart';
import 'package:des/Features/Plans/Models/TopicModel.dart';
import 'package:des/Features/Plans/Plan.dart';
import 'package:des/Features/Plans/Widgets/TopicPhoto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class PlanDescrtion extends StatelessWidget 
{
  late TopicModel PlansTopicTips;
  PlanDescrtion(this.PlansTopicTips);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body:
    Stack(
      children: [
        TopicPhoto(PlansTopicTips.image),
        Positioned(
          top: screenHeight * 0.45,
          left: 20,
          right: 20,
          child: Center(
              child: Text(PlansTopicTips.description!,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(fontSize: 30))),
        ),
        Positioned(
            top: screenHeight * 0.8,
            left: 20,
            right: 20,
            child: NextButton(
                ontap: () 
                async 
                {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => PlanScreen(PlansTopicTips.name),));
                },
                groundColor: Color(int.parse(PlansTopicTips.colorTheme.replaceFirst('#', '0xFF'))),
                text: "Enroll",
                TextColor: Colors.white))
      ],
    ),
    );
  }
}
