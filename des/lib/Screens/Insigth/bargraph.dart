
import 'package:des/Models/ActivityModel.dart';
import 'package:des/Screens/Register/Data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
enum Tab { Monthly, Annually }
class TabState 
{
  final Tab selectedTab;
  TabState(this.selectedTab);
}
class TabCubit extends Cubit<TabState> {
  TabCubit() : super(TabState(Tab.Monthly));
  void selectTab(Tab tab) 
  {
      emit(TabState(tab));
  }
}


  class Bargraph extends StatelessWidget {
  final List<ActivityModel> monthlyData;
  final List<ActivityModel> annuallyData;

  Bargraph({required this.monthlyData, required this.annuallyData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: BlocProvider(
        create: (context) => TabCubit(),
        child: BlocBuilder<TabCubit, TabState>(
          builder: (context, state) {
            final data = state.selectedTab == Tab.Monthly
                ? monthlyData
                : annuallyData;
       
            return 
            ConstrainedBox(constraints: 
            BoxConstraints(
              maxHeight: 340,
            ),
              child:Container(
              width: double.infinity,
              //height:data.length >=3 ? 340 : 200,
              // containerHeight,
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Activities Tracker",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SelectedTime(), 
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount:data.length,
                        itemBuilder: (BuildContext context, int index) {   
                          return BarActivity(
                            totalactivity: data[index].Count!,//activity.totalActivity,
                            totaldays: state.selectedTab == Tab.Monthly ? 30 : 365,
                            ActivityName: data[index].Text,
                          );
                        },
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            
            );
          },
        ),
      ),
    );
  }
}
/*
class Bars extends StatelessWidget
 {

  const Bars({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          //final activity = data[index];
                          return BarActivity(
                            totalactivity: 5 ,//activity.totalActivity,
                            totaldays: state.selectedTab == Tab.Monthly ? 30 : 365,
                            ActivityName: "shop",
                          );
                        },
                      ),
                    ),
  }
}
*/
class SelectedTime extends StatelessWidget {
  const SelectedTime({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabCubit, TabState>(
                builder: (context, state) {
                  return   Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                    Stack(
                     children: [
    InkWell( 
      onTap: () 
      {
            context.read<TabCubit>().selectTab(Tab.Monthly);
      },
  child: Container(
    width: 179,
    height: 38,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color:state.selectedTab == Tab.Monthly
                                ?  Color(0xff000000)
                                : Color(0xffF8F8FF),
    ),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 14),
        child: Text(
          "Monthly",
          style: GoogleFonts.inter(
            color:
             Color(0xff9291A5),
            fontSize: 16,
          ),
        ),
      ),
    ),
  ),
),

    Positioned(
      left: 80, // Adjust the position of the red container horizontally to overlap with the blue container
      child:   InkWell(
      onTap: () 
      { 
        context.read<TabCubit>().selectTab(Tab.Annually);
      }, // Use onTap instead of onPressed
       child:  Container(
        width: 99, // Adjust the width of the red container to extend beyond the blue container
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color:state.selectedTab==Tab.Annually
                                ?  Color(0xff000000)
                                : Color(0xffF8F8FF),),
        child:Center(child:Text("Annually",style: GoogleFonts.inter(color: Color(0xff9291A5),fontSize: 16), ), ),
           ),
          ),
    ),
                   ])],
                  );
                },
              );
  }
}


class BarActivity extends StatelessWidget {
  final int totaldays;
  final num totalactivity;
  final String ActivityName;

  const BarActivity({
    Key? key,
    required this.totalactivity,
    required this.totaldays,
    required this.ActivityName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ActivityName,
                style: GoogleFonts.inter(fontSize: 20),
              ),
              Text(
                totalactivity.toString(),
                style: GoogleFonts.inter(fontSize: 20),
              ),
            ],
          ),
          Container(
            width: 400,
            height: 17,
            decoration: BoxDecoration(
              color: Color(0xffF8F8FF),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: (totalactivity / totaldays) * 300,
                height: 17,
                decoration: BoxDecoration(
                  color: Color(0xff9A89FF).withOpacity(.7),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


