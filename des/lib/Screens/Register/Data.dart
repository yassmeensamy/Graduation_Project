import 'dart:convert';
import 'package:des/Screens/Register/Forms/MeditationForm.dart';
import 'package:des/Screens/Register/Forms/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Components/upperBgCircle.dart';
import '../../Models/user.dart';
import '../../Providers/UserProvider.dart';
import '../../constants.dart' as constants;
import 'CustomizingLoader.dart';
import 'Forms/DataForm.dart';
import 'Forms/imageForm.dart';

int i = 0;
List<Widget> arr = getScreens();
Map<String, String> body = {};
String? imgPath;
Map<String, String> preferencesAnswers = {};
List<Widget> preferencesWidgets = [];

Future<List<Widget>> fetchPreferencesWidgets() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');
  var response = await http.get(
    Uri.parse('${constants.BaseURL}/api/preference-questions/'),
    headers: {'Authorization': "Bearer $accessToken"},
  );

  if (response.statusCode == 200) {
    List<dynamic> preferencesData = json.decode(response.body);
    preferencesWidgets = preferencesData.map((data) {
      Key formKey = Key(data["question_text"]);
      return PreferencesForm(
        data["question_text"],
        data['tag']['name'],
        key: formKey,
        onAnswerSelected: (question, answer) {
          preferencesAnswers[question] = answer ? 'yes' : 'no';
        },
      );
    }).toList();
  } else {
    print(response.statusCode);
    print('Failed to load preferences');
  }

  return preferencesWidgets;
}

List<Widget> getScreens() {
  List<Widget> screens = [
    DataForm(
      onBirthdaySelected: (selectedBirthday) {
        body = {'birthdate': selectedBirthday};
      },
      onGenderSelected2: (selectedGender) {
        body.addAll({'gender': selectedGender});
      },
    )
  ];

  screens.addAll(preferencesWidgets);
  screens.add(ImageForm(onImageSelected: (imagePath) {
    print(imagePath);
    imgPath = imagePath;
  }));
  screens.add(MeditationForm(onMeditationTimeSelected: (weekday, time) {
    setMeditaionTime(weekday, time);
  }));

  return screens;
}

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  String? meditationDay;
  DateTime? meditationTime;

  @override
  void initState() {
    super.initState();
    fetchPreferencesWidgets().then((widgets) {
      setState(() {
        arr = getScreens();
      });
    });
  }

  void setMeditationTime(String day, DateTime time) {
    setState(() {
      meditationDay = day;
      meditationTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User? currentUser = userProvider.user;

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: constants.pageColor,
              child: Stack(
                children: <Widget>[
                  UpperBgCircle(constants.babyBlue70,
                      'Welcome ${currentUser!.firstName}', 370),
                  Positioned(
                    top: 670,
                    left: 149,
                    child: Container(
                      width: 380.0,
                      height: 380.0,
                      decoration: const BoxDecoration(
                        color: constants.lilac70,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 100.0, left: 120),
                            child: GestureDetector(
                              onTap: () {
                                if (i < arr.length - 1) {
                                  setState(() {
                                    i = i + 1;
                                  });
                                } else {
                                  sendPreferences();
                                  updateProfile();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const CustomizingLoader()));
                                }
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    'Next',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 290,
                        ),
                        const Text(
                          'Tell us more about you! ',
                          style: TextStyle(fontSize: 24),
                        ),
                        arr[i],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void updateProfile() async 
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');
  var request = http.MultipartRequest(
      'PATCH', Uri.parse('${constants.BaseURL}/api/auth/user/'));
  if (imgPath != null)
   {
    request.files.add(await http.MultipartFile.fromPath('image', imgPath!));
  }
  request.headers['Authorization'] = 'Bearer $accessToken';
  request.fields.addAll(body);
  await request.send();
}

void sendPreferences() async {
  List<Map<String, String>> answers = preferencesAnswers.entries.map((entry) {
    return {"tag": entry.key, "answer": entry.value};
  }).toList();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');

  var response = await http.post(
    Uri.parse('${constants.BaseURL}/api/preference-questions/answer/'),
    headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    },
    body: json.encode({"answers": answers}),
  );

  if (response.statusCode != 200) {
    print(response.statusCode);
    print('Failed to update preferences');
  }
}

void setMeditaionTime(meditationDay, meditationTime) {
  if (meditationDay != null && meditationTime != null) {
    print('Meditation Day: $meditationDay, Time: $meditationTime');
  } else {
    print('Meditation time not set');
  }
}
