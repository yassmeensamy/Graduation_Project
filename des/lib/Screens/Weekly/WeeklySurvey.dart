import 'package:des/Components/NextButton.dart';
import 'package:des/Models/WeeklyModel.dart';
import 'package:des/Screens/Home.dart';
import 'package:des/Screens/temp.dart';
import 'package:des/cubit/cubit/cubit/weekly_cubit.dart';
import 'package:des/cubit/cubit/handle_home_cubit.dart';
import 'package:des/cubit/cubit/insigths_cubit.dart';
import 'package:des/cubit/cubit/slider_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart' as constants;
class WeeklySurvey extends StatelessWidget {
  const WeeklySurvey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Weekly Check-In",
          style: GoogleFonts.abhayaLibre(fontSize: 20, color: Colors.black),
        ),
      ),
      body: BlocBuilder<WeeklyCubit, WeeklyState>(
          builder: (context, state) {
            List<WeelklyModel> aspects = context.read<WeeklyCubit>().Aspects;
            return Padding(padding: EdgeInsets.only(bottom:10,),
            child:
             Column(
              children: [
                Line(), // Assuming Line is a custom widget
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "On a scale of 1 to 10, how would you rate the following aspects of your life this week:",
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.abhayaLibre(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: aspects.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BlocProvider<SliderCubit>(
                        create: (context) => SliderCubit(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${index + 1} - ${aspects[index].aspect}:",
                                style: GoogleFonts.abhayaLibre(fontSize: 24),
                              ),
                              SliderButton(Aspect_id: aspects[index].id),
                             
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Move the NextButton here
                NextButton(
                  ontap: () async {
                    await  context.read<WeeklyCubit>().CreateRecord();
                    BlocProvider.of<InsigthsCubit>(context).loadInsights();
                         Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                    BlocProvider.of<HandleHomeCubit>(context).resetHomeAfterWeeklycheckin() ;
                    
                    
                                    
                     
                                 
                    
                  },
                  groundColor: constants.purpledark,
                  text: "Submit",
                ),
              ],
            ),
            );
          },
        ),
      );
  }
}


class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 1, // Height of the divider
      color: Color(0xff9E9E9E), // Color of the divider
    );
  }
}

class SliderButton extends StatelessWidget {
  int Aspect_id;
   SliderButton({ required this.Aspect_id}) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: constants.purpledark, //
            inactiveTrackColor: Color(0xff307FE2)
                .withOpacity(.3), // Customize the inactive track color
            thumbColor:  constants.purpledark, // Customize the thumb color
            overlayColor:  constants.purpledark, // Customize the overlay color
            trackHeight: 8.0,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 4.0),
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent,
          ),
          child: BlocBuilder<SliderCubit, double>(builder: (context, state) {
            return Slider(
              value: context.read<SliderCubit>().state,
              onChanged: (newValue) {
                context.read<SliderCubit>().updateSliderValue(newValue);
                context.read<WeeklyCubit>().UpdateAspects(Aspect_id, newValue.toInt());
                print(context.read<WeeklyCubit>().Rating);
              },
              min: 1,
              max: 10,
              divisions: 9,
              label: "Rating",
            );
          })),
    );
  }
}
