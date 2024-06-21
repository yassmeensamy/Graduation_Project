import 'package:des/Components/ProfilePhoto.dart';
import 'package:des/Controllers/GoogleAuthController.dart';
import 'package:des/Models/ActivityModel.dart';
import 'package:des/Models/MoodModel.dart';
import 'package:des/Models/ReportModel.dart';
import 'package:des/Models/WeeklyToDoModel.dart';
import 'package:des/cubit/cubit/handle_home_cubit.dart';
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
             print("home123");
            return  _Home(
              emotions:state.primaryEmotions! , weeklyToDo:state.WeeklyToDo!);       
          }
           else if (state is HomeError) 
          {
            return Center(child: Text('Error: ${state.errormessge}')); // Corrected variable name
          }
          return Container(color: Colors.red,);
        },
      ),
    );
  }
}

class _Home extends StatefulWidget {
  final List<MoodModel> emotions;
  final List<WeeklyToDoPlan> weeklyToDo;
   _Home({required this.emotions, required this.weeklyToDo});
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
  State<_Home> createState() => _HomeState();
}
class _HomeState extends State<_Home> 
{ 
  

   @override
    void initState() {
    super.initState();
    check(); // Call your async function here
  }

 
  bool myBoolVariable = true;
  /*   العيب انه كل ما بيروح الhome بيرجع يبنيها من الاول خالص خالص   */
  void check() async
  {
     bool moodEntry = await BlocProvider.of<HandleHomeCubit>(context).chechMoodEnrty();
     myBoolVariable=moodEntry;
      setState(() {
     myBoolVariable=moodEntry;
    });
  }

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
    
                    
              
    myBoolVariable==false             
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
  : MoodSelectedContainer(),

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
            if(state is HomeLoaded)
            {
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
            return Container();
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
    for (int i = 0; i < widget.emotions.length; i++) {
      result.add(
        GestureDetector(
          onTap: () => 
          {
            BlocProvider.of<SecondLayerCubit>(context).SavePrimaryEmotions( widget.emotions[i].Text),
            (
              widget.emotions[i].Text,
              _Home.emotionsIcons[i][1],
            ),
            BlocProvider.of<SecondLayerCubit>(context).getSecondEmotions
            (
              widget.emotions[i].Text,
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
                Text(widget.emotions[i].Text),
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
  
   MoodSelectedContainer({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) 
  {
     ReportModel dailyreport=BlocProvider.of<HandleHomeCubit>(context).dailyReport!;
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
  Widget build(BuildContext context) 
  {
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
      return [
        TextSpan(text: ' '),
        TextSpan(
          text: second,
          style: GoogleFonts.abhayaLibre(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ];
    } else if (second is List<ActivityModel>) {
      return [
        TextSpan(text: ' '),
        ...second.map((activity) => TextSpan(
          text: activity.Text!,
          style: GoogleFonts.abhayaLibre(
            fontSize: 19,
            color: Color(0xff100F11),
            fontWeight: FontWeight.bold,
          ),
        )).expand((e) => [e, TextSpan(text: ", ")]).toList()..removeLast(),
      ];
    } else {
      throw ArgumentError('Invalid type for second parameter');
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