import 'package:des/Components/CustomAlertDialog.dart';
import 'package:des/Components/Drawer.dart';
import 'package:des/Components/ProfilePhoto.dart';
import 'package:des/Features/Commuity/Screens/CommuintyScreens.dart';
import 'package:des/Features/HomeScreen/HomeCubits/DepressionPlanCubit/depression_cubit.dart';
import 'package:des/Features/HomeScreen/HomeCubits/PlanTaskCubit/plan_tasks_cubit.dart';
import 'package:des/Features/HomeScreen/HomeCubits/WeeklyTasks/weekly_tasks_cubit.dart';
import 'package:des/Features/HomeScreen/Widgets/Calender.dart';
import 'package:des/Features/HomeScreen/Widgets/Rectangle.dart';
import 'package:des/Features/HomeScreen/Widgets/ToDo.dart';
import 'package:des/Features/Insigth/InsigthCubit/insigths_cubit.dart';
import 'package:des/Features/MoodTracker/DailyTrackCubit/EmotionCubit.dart';
import 'package:des/Features/MoodTracker/Models/ActivityModel.dart';
import 'package:des/Features/MoodTracker/Models/ReportModel.dart';
import 'package:des/Features/MoodTracker/Screens/SecondLayerMood.dart';
import 'package:des/Features/Test/TestScreen.dart';
import 'package:des/Features/Weekly/WeeklyCubit/weekly_cubit.dart';
import 'package:des/Features/Weekly/WeeklySurvey.dart';
import 'package:des/Models/user.dart';
import 'package:des/Providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constants.dart' as constants;
import 'HomeScreen/HomeCubits/MoodEntryCubit/handle_emojy_daily_cubit.dart';

class NewHome extends StatelessWidget {
  NewHome({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ValueNotifier<bool> showDepressionTest =ValueNotifier<bool>(true); 
  final ValueNotifier<bool> showRetakeTest = ValueNotifier<bool>(true); 

  void showCustomDialog(BuildContext context, String title, String message) {
    CustomAlertDialog(
        context: context,
        title: title,
        message: message,
        actionText: 'Go To Test',
        icon: Icons.arrow_back,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TestScreen()));
        }).show();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    User? currentUser = userProvider.user;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: constants.pageColor,
      drawer: myDrawer(),
      body: Builder(
        builder: (context) {
          context.watch<DepressionCubit>().state;
          context.watch<InsigthsCubit>().state;
          context.watch<WeeklyCubit>().state;
          context.watch<PlanTasksCubit>().state;

          Future.microtask(() {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (showDepressionTest.value &&context.read<DepressionCubit>().Retaketest == true) {
                showCustomDialog(
                  context,
                  'Test Notification',
                  "We've noticed that you've been tracking your mood with us for the past 15 days. Based on the information you've shared, it might be helpful to take a quick depression test to better understand your mental health. This can provide valuable insights and help us offer you the best support possible.",
                );
                showDepressionTest.value = false;
              }
            });
          });

          Future.microtask(() {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (showRetakeTest.value && context.read<DepressionCubit>().checkDepression) 
              {
                showCustomDialog(
                  context,
                  'Depression Notification',
                  "We've noticed that you've been tracking your mood with us for the past 15 days. Based on the information you've shared, it might be helpful to take a quick depression test to better understand your mental health. This can provide valuable insights and help us offer you the best support possible.",
                );
                showRetakeTest.value = false;
              }
            });
          });
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32.0, horizontal: 16),
                    child: Column(
                      children: [
                        //HeaderHomeSCreen(_scaffoldKey),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _scaffoldKey.currentState?.openDrawer();
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
                                        DateFormat('EEEE')
                                            .format(DateTime.now()),
                                        style: const TextStyle(
                                            color: constants.txtGrey,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        DateFormat.MMMMd()
                                            .format(DateTime.now()),
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(top: 16.0),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MindfulMomentsTracker()));
                                        },
                                        icon: Icon(
                                          Icons.calendar_month_outlined,
                                          color: constants.darkGrey,
                                        ),
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Welcome Back, ${currentUser!.firstName}',
                                style: const TextStyle(fontSize: 22),
                              ),
                            ]),
                        EmotionsContainer(),
                        DepressionTestContainer(),
                        CommuintyContainer(),
                        BlocProvider.of<InsigthsCubit>(context).is7DaysAgo ==
                                false
                            ? WeeklySurveyContainer()
                            : SizedBox.shrink(),
                        BlocProvider.of<InsigthsCubit>(context).results.isEmpty
                            ? SizedBox.shrink()
                            : DisplayWeeklyTasks(),
                            BlocProvider.of<DepressionCubit>(context).CurrentDepressionAcitivy == 0 || BlocProvider.of<PlanTasksCubit>(context) .plan
                                        .length ==
                                    0
                            ? SizedBox.shrink()
                            : MixToDoTasks(),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class DepressionTestContainer extends StatelessWidget {
  const DepressionTestContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return RectangleContainer(
      constants.mint,
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Depression Test',
          style: TextStyle(fontSize: 22),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: const Text(
            'Take a test to determine your depression level',
            style: TextStyle(color: constants.darkGrey),
          ),
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TestScreen()));
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
    );
  }
}

class DisplayWeeklyTasks extends StatelessWidget {
  DisplayWeeklyTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return RectangleContainer(
      constants.lilac30,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Weekly Tasks",
            style: GoogleFonts.openSans(fontSize: 24, color: Colors.black),
          ),
          Container(
            child: BlocBuilder<WeeklyTasksCubit, WeeklyTasksState>(
                builder: (context, state) {
              if (state is WeeklyTasksLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return BlocProvider.of<WeeklyTasksCubit>(context)
                          .WeeklyToDo
                          .length !=
                      0
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: BlocProvider.of<WeeklyTasksCubit>(context)
                                  .WeeklyToDo
                                  .length >
                              3
                          ? 3
                          : BlocProvider.of<WeeklyTasksCubit>(context)
                              .WeeklyToDo
                              .length,
                      itemBuilder: (BuildContext context, int index) {
                        return BlocProvider<CheckboxCubit>(
                          create: (context) => CheckboxCubit(),
                          child: TODo(
                              todo: BlocProvider.of<WeeklyTasksCubit>(context)
                                  .WeeklyToDo[index]),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                          " Weekly Tasks done, Celebrate this achievement and keep moving forward.",
                          style: TextStyle(fontSize: 20)));
            }),
          ),
        ],
      ),
    );
  }
}

class EmotionsContainer extends StatelessWidget {
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
    return BlocBuilder<HandleEmojyDailyCubit, HandleEmojyDailyState>(
      builder: (context, state) {
        if (state is HandleEmojyDailyError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is HandleEmojyDailyError) {
          return Container(
            color: Colors.red,
          );
        } else if (state is HandleReportloaded) {
          return MoodSelectedContainer(
            dailyreport: state.report,
          );
        }
        return Column(
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
        );
      },
    );
  }

  getEmotions(BuildContext context) {
    List<Widget> result = [];
    for (int i = 0;
        i <
            BlocProvider.of<HandleEmojyDailyCubit>(context)
                .primaryEmotions
                .length;
        i++) {
      result.add(
        GestureDetector(
          onTap: () => {
            BlocProvider.of<SecondLayerCubit>(context).SavePrimaryEmotions(
                BlocProvider.of<HandleEmojyDailyCubit>(context)
                    .primaryEmotions[i]
                    .Text),
            (
              BlocProvider.of<HandleEmojyDailyCubit>(context)
                  .primaryEmotions[i]
                  .Text,
              emotionsIcons[i][1],
            ),
            BlocProvider.of<SecondLayerCubit>(context).getSecondEmotions(
              BlocProvider.of<HandleEmojyDailyCubit>(context)
                  .primaryEmotions[i]
                  .Text,
              emotionsIcons[i][1],
            ),
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondViewMoodPage(),
              ),
            )
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            margin: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: [
                Image.asset(
                  emotionsIcons[i][1],
                  width: 63,
                ),
                Text(BlocProvider.of<HandleEmojyDailyCubit>(context)
                    .primaryEmotions[i]
                    .Text),
              ],
            ),
          ),
        ),
      );
    }
    return result;
  }
}

class MoodSelectedContainer extends StatelessWidget {
  ReportModel dailyreport;
  MoodSelectedContainer({required this.dailyreport});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12), // Adjust bottom padding only
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.only(right: 4),
                  minimumSize: Size(0, 0),
                  tapTargetSize:
                      MaterialTapTargetSize.shrinkWrap, // Shrink wrap
                  visualDensity:
                      VisualDensity.compact, // Make the button more compact
                ),
                onPressed: () {
                  BlocProvider.of<HandleEmojyDailyCubit>(context)
                      .DeleteEntryToday(context);
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
                  tapTargetSize:
                      MaterialTapTargetSize.shrinkWrap, // Shrink wrap
                  visualDensity:
                      VisualDensity.compact, // Make the button more compact
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
          SizedBox(height: 4),
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
                      second: dailyreport.primarymood.Text,
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

class MixToDoTasks extends StatelessWidget {
  const MixToDoTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return RectangleContainer(
      constants.babyBlue30,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Daily Tasks",
            style: GoogleFonts.openSans(fontSize: 24, color: Colors.black),
          ),
          BlocBuilder<PlanTasksCubit, PlanTasksState>(
            builder: (context, planTasksState) {
              return BlocBuilder<DepressionCubit, DepressionState>(
                builder: (context, depressionState) {
                  if (planTasksState is PlanTasksloading ||
                      depressionState is Depressionloading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (planTasksState is PlanTasksError ||
                      depressionState is DepressionError) {
                    return Container(
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          'An error occurred',
                          style: GoogleFonts.openSans(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                    );
                  }

                  final planTasks =
                      context.read<PlanTasksCubit>().CurrentActivityplan;
                       final depressionTasks =
                      context.read<DepressionCubit>().CurrentDepressionAcitivy;

                  final combinedTasks = [...planTasks, ...depressionTasks];

                  return combinedTasks.isNotEmpty
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: combinedTasks.length,
                          itemBuilder: (BuildContext context, int index) {
                            final task = combinedTasks[index];
                            return BlocProvider<CheckboxCubit>(
                              create: (context) => CheckboxCubit(),
                              child: TODo(
                                todo: task,
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Tasks done, Celebrate this achievement and keep moving forward.",
                              softWrap: true,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                },
              );
            },
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
      List<TextSpan> activitySpans = activities
          .map((activity) => TextSpan(
                text: activity.Text,
                style: GoogleFonts.abhayaLibre(
                  fontSize: 19,
                  color: Color(0xff100F11),
                  fontWeight: FontWeight.bold,
                ),
              ))
          .toList();

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

class WeeklySurveyContainer extends StatelessWidget {
  const WeeklySurveyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return RectangleContainer(
      constants.lilac30,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Weekly Check in',
              style: TextStyle(fontSize: 22),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Text(
                'Take a test to determine your \n depression level',
                style: TextStyle(color: constants.darkGrey),
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WeeklySurvey()));
                },
                child: Row(
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
                )),
          ]),
          Image.asset(
            'assets/images/Emotions/meetup.png',
            width: 92,
          ),
        ],
      ),
    );
  }
}

class CommuintyContainer extends StatelessWidget {
  CommuintyContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return RectangleContainer(
      constants.lilac30,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Peer Group Meetup',
              style: TextStyle(fontSize: 22),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Text(
                'Let’s open up to the  thing that \n matters amoung the people',
                softWrap: true,
                style: TextStyle(color: constants.darkGrey),
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => PostsCommunityScreen()));
                },
                child: Row(
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
                )),
          ]),
          Image.asset(
            'assets/images/Emotions/meetup.png',
            width: 92,
          ),
        ],
      ),
    );
  }
}
