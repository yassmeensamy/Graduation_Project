import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeeklySurvey extends StatelessWidget {
   WeeklySurvey({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
    appBar:  AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text("Weekly Check-In",style: GoogleFonts.abhayaLibre(fontSize: 20,color: Colors.black),),
    ),
    body: 
    Padding(padding: EdgeInsets.only(left: 10,top: 10),
    child:
    Column(
      children: [
        Line(),
          Text(
            "On a scale of 1 to 10, how would you rate the following aspects of your life this week:",
            softWrap: true,
            textAlign: TextAlign.left,
            style: GoogleFonts.abhayaLibre(fontSize:22,color: Colors.black,fontWeight: FontWeight.w500)
          ),
          SizedBox(height: 10,),
          Inspectslife(),
    
      ]),
    ),
    );
  }
  
}
class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Padding( 
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 1, // Height of the divider
        color: Color(0xff9E9E9E), // Color of the divider
      ),
    );
  }
}
class SliderButton extends StatefulWidget {
  const SliderButton({Key? key}) : super(key: key);

  @override
  _SliderButtonState createState() => _SliderButtonState();
}

class _SliderButtonState extends State<SliderButton> {
  double sliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: const EdgeInsets.only(top:6),
      child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor:Color(0xff6A6DCD), // 
            inactiveTrackColor: Color(0xff307FE2).withOpacity(.3), // Customize the inactive track color
            thumbColor: Color(0xff6A6DCD), // Customize the thumb color
            overlayColor: Color(0xff6A6DCD), // Customize the overlay color
            trackHeight: 8.0, 
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0), 
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 4.0), 
            activeTickMarkColor: Colors.transparent, 
            inactiveTickMarkColor: Colors.transparent,
          
          ),
          child: 
      Slider(
        value: sliderValue,
        onChanged: (newValue) {
          setState(() {
            print(newValue);
            sliderValue = newValue;
          });
        },
        min: 1, 
        max: 10, 
        divisions: 9, 
         // Optional label for accessibility
      ),
    ),
    );
  }
}
class Inspectslife extends StatelessWidget {
  const Inspectslife({super.key});

  @override
  Widget build(BuildContext context) {
    return 
     Flexible(child: 
       ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) 
        {
          return Padding(padding: EdgeInsets.only(left: 10,top:15),child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
            [  
              Text( "${index+1}-family" ,style:GoogleFonts.abhayaLibre(fontSize: 25,color: Colors.black)),
               SliderButton(),
            ],
          ),
          );
        },
      ),
    );
  }
}
/*
class Inspect extends StatelessWidget {
  const Inspect({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column
      (

      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro/cubit/cubit/slider_cubit.dart';

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
      body: Column(
        children: [
          Line(),
          Text(
            "On a scale of 1 to 5, how would you rate the following aspects of your life this week:",
            softWrap: true,
            textAlign: TextAlign.left,
          ),
          Text("1-family"),
          SliderButton(),
          BlocBuilder<SliderCubit, double>(
            builder: (context, sliderValue) {
              return Text("Slider Value: $sliderValue");
            },
          ),
        ],
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
  const SliderButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderCubit, double>(
      builder: (context, sliderValue) {
        return Slider(
          value: sliderValue,
          onChanged: (newValue) {
            context.read<SliderCubit>().updateSliderValue(newValue);
          },
          min: 1,
          max: 10,
          divisions: 9,
          label: "Rating",
        );
      },
    );
  }
}
*/