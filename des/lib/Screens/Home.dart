import 'package:des/Components/ProfilePhoto.dart';
import 'package:des/Controllers/GoogleAuthController.dart';
import 'package:des/Models/ActivityModel.dart';
import 'package:des/Models/MoodModel.dart';
import 'package:des/Models/ReportModel.dart';
import 'package:des/Models/WeeklyToDoModel.dart';
import 'package:des/Screens/Weekly/WeeklySurvey.dart';
import 'package:des/cubit/cubit/handle_home_cubit.dart';
import 'package:des/cubit/cubit/insigths_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/user.dart';
import '../Providers/UserProvider.dart';
import '../constants.dart' as constants;
import '../cubit/EmotionCubit.dart';
import 'MoodTracker/SecondLayerMood.dart';
import 'Test/TestScreen.dart';

class Home extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HandleHomeCubit, HandleHomeState>(
        builder: (context, state) 
      {  
          if (state is HomeLoading) 
          {
            return Center(child: CircularProgressIndicator());
          } 
         else if (state is HomeLoaded) 
          {
            return  _Home( emotions:state.primaryEmotions,weeklyToDo:state.WeeklyToDo,IsEntry: state.isEntry!,dailyReport: state.report,);       
          }
           else if (state is HomeError) 
          {
            return Center(child: Text('Error: ${state.errormessge}')); 
          }

          return Container(color: Colors.red,);
        },
      ),
    );
  }
}

class _Home extends StatelessWidget {
  final List<MoodModel>? emotions;
  final List<WeeklyToDoPlan>? weeklyToDo;
  final bool IsEntry;
  final ReportModel? dailyReport;
   _Home({ this.dailyReport,this.emotions,  this.weeklyToDo ,required this.IsEntry });
  static const List<List<String>> emotionsIcons = [
    [
      'Loved',
      'assets/images/Emotions/Loved.png',
    ],
    [
      'Disgust',
      'assets/images/Emotions/Bitter.png',
    ],
    [
      'Surprised',
      'assets/images/Emotions/Startled.png',
    ],
    [
      'Happy',
      'assets/images/Emotions/Proud.png',
    ],
    [
      'Fear',
      'assets/images/Emotions/Insecure.png',
    ],
    [
      'Angry',
      'assets/images/Emotions/Threatended.png',
    ],
    [
      'Sad',
      'assets/images/Emotions/Sad.png',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =Provider.of<UserProvider>(context, listen: false);
    User? currentUser = userProvider.user;
    return Scaffold(
      backgroundColor: constants.pageColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.remove('accessToken');
                            await prefs.remove('refreshToken');
                            googleLogout();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 16),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: getProfilePhoto(context))),
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat('EEEE').format(DateTime.now()),
                              style: const TextStyle(
                                  color: constants.txtGrey, fontSize: 16),
                            ),
                            Text(
                              DateFormat.MMMMd().format(DateTime.now()),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: IconButton(onPressed:()
                          {
                           print(DateFormat('yyyy-MM-dd').format(DateTime.now()));
                           print(DateFormat('d').format(DateTime.now()));
                          } ,
                          icon:  Icon(
                            Icons.calendar_month_outlined,
                            color: constants.darkGrey,
                          ),
                          )
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Welcome Back, ${currentUser!.firstName}',
                      style: const TextStyle(fontSize: 22),
                    ),
    
                    
           
  IsEntry==false    
  ? 
  Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'How\'s your mental status at the moment?',
            style: TextStyle(color: constants.txtGrey),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: getEmotions(context),
          ),
        ),
      ],
    )
  : MoodSelectedContainer(dailyreport: dailyReport!,),

                    RectangleContainer(
                      constants.mint,
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Depression Test',
                              style: TextStyle(fontSize: 22),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: const Text(
                                'Take a test to determine your depression level',
                                style: TextStyle(color: constants.darkGrey),
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TestScreen()));
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Start Now',
                                        style: TextStyle(
                                          color: constants.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Icon(
                                        Icons.play_arrow,
                                        color: constants.green,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ]),
                    ),
          BlocProvider.of<InsigthsCubit>(context).weeklyhistoy.is7DaysAgo== false 
          ?
          Column
          (
            children: 
            [
               RectangleContainer(
                      constants.lilac30,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Weekly Check in',
                                  style: TextStyle(fontSize: 22),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: const Text(
                                    'Take a test to determine your \n depression level',
                                    style: TextStyle(color: constants.darkGrey),
                                  ),
                                ),
                                 InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WeeklySurvey()));
                                  },
                                  child:Row(
                                  children: [
                                    Text(
                                      'Join Now',
                                      style: TextStyle(
                                          color: constants.lilac,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    Icon(
                                      Icons.play_arrow,
                                      color: constants.lilac,
                                      size: 20,
                                    )
                                  ],
                                )
                                 ),
                              ]),
                          Image.asset(
                            'assets/images/Emotions/meetup.png',
                            width: 92,
                          ),
                        ],
                      ),
                    ),
                
            ],

          ):SizedBox.shrink(),
           BlocProvider.of<InsigthsCubit>(context).weeklyhistoy.history.isNotEmpty?
           RectangleContainer(
                          constants.lilac30,
                       Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                           children: [                   
       Container( 
        child:BlocBuilder<HandleHomeCubit, HandleHomeState>(
          builder: (context, state) 
          { 
              print("howww");
              return 
              BlocProvider.of<HandleHomeCubit>(context).WeeklyToDo.length!=0 ?
                 ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: BlocProvider.of<HandleHomeCubit>(context).WeeklyToDo.length >3 ?3 : BlocProvider.of<HandleHomeCubit>(context).WeeklyToDo.length,
                  itemBuilder: (BuildContext context, int index) {
                   return BlocProvider<CheckboxCubit>(create: (context) => CheckboxCubit(),
                              child: TODo(todo:weeklyToDo![index]),
                                   );
                                 },
                                   ):  Center(child:
                                   Text(" Weekly Tasks done, Celebrate this achievement and keep moving forward." ,style:TextStyle(fontSize: 20)));
           
          
          }
        ),
      ),
    ],
  ),
):
SizedBox.shrink(),
          
                
                  ],
                  )
                   )
                ),
              ),
        ]
      )
    );
        
  }
  getEmotions(BuildContext context) {
    List<Widget> result = [];
    for (int i = 0; i < emotions!.length; i++) {
      result.add(
        GestureDetector(
          onTap: () => 
          {
            BlocProvider.of<SecondLayerCubit>(context).SavePrimaryEmotions( emotions![i].Text),
            (
              emotions![i].Text,
              _Home.emotionsIcons[i][1],
            ),
            BlocProvider.of<SecondLayerCubit>(context).getSecondEmotions
            (
              emotions![i].Text,
              _Home.emotionsIcons[i][1],
            ),
            Navigator.push(context,MaterialPageRoute(  builder: (context) => SecondViewMoodPage(),),
          )  
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            margin: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: [
                Image.asset(
                  _Home.emotionsIcons[i][1],
                  width: 63,
                ),
                Text(emotions![i].Text),
              ],
            ),
          ),
        ),
      );
    }
    return result;
  }
}

class RectangleContainer extends StatelessWidget {
  final Color? color;
  final Widget? child;
  const RectangleContainer(this.color, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
class TODo extends StatelessWidget {
  final WeeklyToDoPlan todo;
  TODo( { required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.activityName ,style: TextStyle(fontSize: 20),),
      subtitle: Text(todo.activityDescription),
      trailing: BlocBuilder<CheckboxCubit, bool>(
        builder: (context, isChecked) {
          return Checkbox(
            value: isChecked,
            onChanged: (newValue)
             {
              context.read<CheckboxCubit>().toggleCheckbox(newValue!);
               BlocProvider.of<HandleHomeCubit>(context).RemoveFromToDoList(todo.id);
               context.read<CheckboxCubit>().toggleCheckbox(!newValue);
             }, 
          );
        },
      ),
    );
  }
}



class MoodSelectedContainer extends StatelessWidget 
{
  ReportModel dailyreport;
   MoodSelectedContainer({required this.dailyreport}) ;
 
  @override
  Widget build(BuildContext context) 
  {
   
     //ReportModel dailyreport=BlocProvider.of<HandleHomeCubit>(context).dailyReport!;
    return Padding(
      padding: EdgeInsets.only(bottom: 12), // Adjust bottom padding only
      child: 
       Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.only(right: 4),
                    minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink wrap
                    visualDensity: VisualDensity.compact, // Make the button more compact
                  ),
                  onPressed: () 
                  
                  {
                     BlocProvider.of<HandleHomeCubit>(context).DeleteEntryToday();

                  },
                  child: Text(
                    "delete",
                    style: GoogleFonts.abhayaLibre(
                      fontSize: 18,
                      color: Color(0xffFC4C4C),
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  height: 20,
                  color: Color(0xff100F11).withOpacity(.2),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.only(left: 4), // Remove default padding
                    minimumSize: Size(0, 0), // Minimum size to zero
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink wrap
                    visualDensity: VisualDensity.compact, // Make the button more compact
                  ),
                  onPressed: () {},
                  child: Text(
                    "Edit",
                    style: GoogleFonts.abhayaLibre(
                      fontSize: 18,
                      color: Color(0xff8B4CFC),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4), // Adjust this height to control the space between the rows
            Row(
              children: [
               Container(
                       width: 63,
                       height: 63,
                       decoration: BoxDecoration(                 
                           image: DecorationImage(
                           fit: BoxFit.cover,
                           image: NetworkImage(dailyreport.primarymood.ImagePath!),
                                                  ),
                                                  ),
                                                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextLine(
                        first: "You are feeling",
                        second:dailyreport.primarymood.Text,
                      ),
                      
                      TextLine(
                        first: "You made these Activities",
                        second: dailyreport.activities,
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }
}


class TextLine extends StatelessWidget {
  final String first;
  final dynamic second;

  TextLine({required this.first, required this.second});

  @override
  Widget build(BuildContext context) {
    return RichText(
      softWrap: true,
      text: TextSpan(
        text: first,
        style: GoogleFonts.abhayaLibre(fontSize: 20, color: constants.textGrey),
        children: _buildChildren(),
      ),
    );
  }

  List<TextSpan> _buildChildren() {
    if (second is String) {
      return _buildStringChildren(second as String);
    } else if (second is List<ActivityModel>) {
      return _buildListChildren(second as List<ActivityModel>);
    } else {
      throw ArgumentError('Invalid type for second parameter');
    }
  }

  List<TextSpan> _buildStringChildren(String text) {
    return [
      TextSpan(text: ' '),
      TextSpan(
        text: text,
        style: GoogleFonts.abhayaLibre(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ];
  }

  List<TextSpan> _buildListChildren(List<ActivityModel> activities) {
    if (activities.isEmpty) {
      return [
        TextSpan(text: ' '),
        TextSpan(
          text: "None",
          style: GoogleFonts.abhayaLibre(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ];
    } else {
      List<TextSpan> activitySpans = activities.map((activity) => TextSpan(
        text: activity.Text!,
        style: GoogleFonts.abhayaLibre(
          fontSize: 19,
          color: Color(0xff100F11),
          fontWeight: FontWeight.bold,
        ),
      )).toList();

      // Add comma separator between activities
      List<TextSpan> spansWithCommas = [];
      for (int i = 0; i < activitySpans.length; i++) {
        spansWithCommas.add(activitySpans[i]);
        if (i < activitySpans.length - 1) {
          spansWithCommas.add(TextSpan(text: ", "));
        }
      }

      return [
        TextSpan(text: ' '),
        ...spansWithCommas,
      ];
    }
  }
}





  //Plan

    /*

                    RectangleContainer(
                        constants.babyBlue30,
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: const Text(
                                  'Daily Tasks',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.sports_gymnastics,
                                  color: Colors.white,
                                  size: 36,
                                ),
                                title: const Text('Meditate for 5 minutes'),
                                subtitle: const Text('Meditaion Plan'),
                                trailing:
                                    Checkbox(value: false, onChanged: (b) {}),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.work,
                                  color: Colors.white,
                                  size: 36,
                                ),
                                title: const Text('Meditate for 5 minutes'),
                                subtitle: const Text('Meditaion Plan'),
                                trailing:
                                    Checkbox(value: false, onChanged: (b) {}),
                              ),
                            ])),
                            */





 /*
                 BlocProvider.of<InsigthsCubit>(context).weeklyhistoy.history.isNotEmpty?
                 RectangleContainer(
                          constants.lilac30,
                       Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                           children: [                   
       Container( 
        child:BlocBuilder<HandleHomeCubit, HandleHomeState>(
          builder: (context, state) 
          { 
            if(state is ToDoDoneClass || state is HomeLoaded )
            {
              print("error in buildeing");
              return 
              BlocProvider.of<HandleHomeCubit>(context).WeeklyToDo.length!=0 ?
                 ListView.builder(
                  shrinkWrap: true,
                  itemCount: BlocProvider.of<HandleHomeCubit>(context).WeeklyToDo.length >3 ?3 : BlocProvider.of<HandleHomeCubit>(context).WeeklyToDo.length,
                  itemBuilder: (BuildContext context, int index) {
                   return BlocProvider<CheckboxCubit>(create: (context) => CheckboxCubit(),
                              child: TODo(todo:widget.weeklyToDo[index]),
                                   );
                                 },
                                   ):  Center(child:
                                   Text(" Weekly Tasks done, Celebrate this achievement and keep moving forward." ,style:TextStyle(fontSize: 20)));
           }
          else 
          {
            return Container();
          }
          
          }
        ),
      ),
    ],
  ),
):  RectangleContainer(
                      constants.lilac30,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Weekly Check in',
                                  style: TextStyle(fontSize: 22),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: const Text(
                                    'Take a test to determine your \n depression level',
                                    style: TextStyle(color: constants.darkGrey),
                                  ),
                                ),
                                 InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WeeklySurvey()));
                                  },
                                  child:Row(
                                  children: [
                                    Text(
                                      'Join Now',
                                      style: TextStyle(
                                          color: constants.lilac,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    Icon(
                                      Icons.play_arrow,
                                      color: constants.lilac,
                                      size: 20,
                                    )
                                  ],
                                )
                                 ),
                              ]),
                          Image.asset(
                            'assets/images/Emotions/meetup.png',
                            width: 92,
                          ),
                        ],
                      ),
                    ),
                    */