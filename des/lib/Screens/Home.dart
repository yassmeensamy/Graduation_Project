import 'package:des/Components/ProfilePhoto.dart';
import 'package:des/Controllers/GoogleAuthController.dart';
import 'package:des/Screens/Homeloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/PrimaryEmotionsModel.dart';
import '../Models/user.dart';
import '../Providers/UserProvider.dart';
import '../constants.dart' as constants;
import '../cubit/EmotionCubit.dart';
import '../cubit/EmotionCubitState.dart';
import 'MoodTracker/SecondLayerMood.dart';
import 'Test/TestScreen.dart';

class _Home extends StatefulWidget {
  final List<PrimaryMoodModel> emotions;

   _Home({required this.emotions, Key? key}) : super(key: key);

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

class _HomeState extends State<_Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User? currentUser = userProvider.user;
     void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
      child: ListView(children: [
        // Row(
              
        //       children: [
        //            CircleAvatar(
        //             radius: 28,
        //             backgroundImage:  AssetImage("Assets/Ellipse.png"),
        //            ),
        //            SizedBox(width: 10,),
        //            Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text("Yara Muhammad",style: GoogleFonts.openSans(fontSize:18 ),),
        //                Row(
        //                 children: [
        //                   Text("view profile ",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: constants.darkGrey.withOpacity(.5)),)
        //                    ,//Icon(Icons.arrow_back_ios_new),
        //                 ],
        //               ),
        ListTile(
          
              onTap: (){},
              title: Text("About you"),
              leading: Icon(Icons.notification_add),
            ),
            ListTile(
              onTap: (){},
              title: Text("Notification"),
              leading: Icon(Icons.notification_add),
            ),
             ListTile(
               onTap: (){},
              title: Text("AcountSettings"),
              leading: Icon(Icons.notification_add),
            ),
             
           
            ListTile(
               onTap: (){},
              title: Text("Log Out"),
              leading: Icon(Icons.notification_add),
            ),
          
      ],)),
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
                          //  _openDrawer();
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
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Icon(
                            Icons.calendar_month_outlined,
                            color: constants.darkGrey,
                          ),
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
                    RectangleContainer(
                      constants.lilac30,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                    'Take a test to determine your \n depression level',
                                    style: TextStyle(color: constants.darkGrey),
                                  ),
                                ),
                                const Row(
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
                              ]),
                          Image.asset(
                            'assets/images/Emotions/meetup.png',
                            width: 92,
                          ),
                        ],
                      ),
                    ),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getEmotions(BuildContext context) {
    List<Widget> result = [];
    for (int i = 0; i < widget.emotions.length; i++) {
      result.add(
        GestureDetector(
          onTap: () => {
            BlocProvider.of<SecondLayerCubit>(context).getSecondEmotions(
              widget.emotions[i].moodText,
              _Home.emotionsIcons[i][1],
            ),
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
                Text(widget.emotions[i].moodText),
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

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SecondLayerCubit, SecondLayerCubitCubitState>(
          listener: (context, state) {
        if (state is EmotionCubitStateSucess) //layer2
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondViewMoodPage(),
            ),
          );
        }
      }, builder: (context, state) {
        if (state is PrimaryEmotionsState) {
          return _Home(
              emotions:
                  BlocProvider.of<SecondLayerCubit>(context).primaryEmotions);
        } else
         {
         
          return HomeLoading();
        }
      }),
    );
  }
}






