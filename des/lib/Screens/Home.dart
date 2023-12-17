import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart' as constants;

class Home extends StatelessWidget {
  static const List<List<String>> emotions = [
    [
      'Happy',
      'assets/images/Emotions/Proud.png',
    ],
    [
      'Sad',
      'assets/images/Emotions/Sad.png',
    ],
    [
      'Loved',
      'assets/images/Emotions/Loved.png',
    ],
    [
      'Fear',
      'assets/images/Emotions/Insecure.png',
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
      'Angry',
      'assets/images/Emotions/Threatended.png',
    ],
  ];

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: constants.pageColor,
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32.0, horizontal: 16),
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
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 16),
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Image.asset('assets/images/female.png'),
                              ),
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  DateFormat('EEEE').format(DateTime.now()),
                                  style: TextStyle(
                                      color: constants.txtGrey, fontSize: 16),
                                ),
                                Text(
                                  DateFormat.MMMMd().format(DateTime.now()),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
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
                        const Text(
                          'Welcome Back, Yara',
                          style: TextStyle(fontSize: 22),
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
                            children: getEmotions(),
                          ),
                        ),
                        RectangleContainer(
                          constants.mint,
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Depression Test',
                                  style: TextStyle(fontSize: 22),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Take a test to determine your depression level',
                                    style: TextStyle(color: constants.darkGrey),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Start Now',
                                      style: TextStyle(
                                          color: constants.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    Icon(
                                      Icons.play_arrow,
                                      color: constants.green,
                                      size: 20,
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
                                    Text(
                                      'Depression Test',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        'Take a test to determine your \n depression level',
                                        style: TextStyle(
                                            color: constants.darkGrey),
                                      ),
                                    ),
                                    Row(
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
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      'Daily Tasks',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.sports_gymnastics,
                                      color: Colors.white,
                                      size: 36,
                                    ),
                                    title: Text('Meditate for 5 minutes'),
                                    subtitle: Text('Meditaion Plan'),
                                    trailing: Checkbox(
                                        value: false, onChanged: (b) {}),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.work,
                                      color: Colors.white,
                                      size: 36,
                                    ),
                                    title: Text('Meditate for 5 minutes'),
                                    subtitle: Text('Meditaion Plan'),
                                    trailing: Checkbox(
                                        value: false, onChanged: (b) {}),
                                  ),
                                ])),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: constants.mint,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.home,
                      color: constants.babyBlue,
                    ),
                    Icon(
                      Icons.calendar_month,
                      color: constants.txtGrey,
                    ),
                    Icon(
                      Icons.group,
                      color: constants.txtGrey,
                    ),
                    Icon(
                      Icons.timer,
                      color: constants.txtGrey,
                    ),
                    Icon(
                      Icons.person,
                      color: constants.txtGrey,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  getEmotions() {
    List<Widget> result = [];
    for (int i = 0; i < emotions.length; i++) {
      result.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          margin: EdgeInsets.only(left: 8.0),
          child: Column(
            children: [
              Image.asset(
                emotions[i][1],
                width: 63,
              ),
              Text(emotions[i][0]),
            ],
          ),
        ),
      );
    }
    return result;
  }
}

class RectangleContainer extends StatelessWidget {
  Color? color;
  Widget? child;
  RectangleContainer(Color c, Widget ch, {super.key}) {
    color = c;
    child = ch;
  }

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
