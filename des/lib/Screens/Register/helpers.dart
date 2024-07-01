import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../NotificationServices.dart';
import '../../Schedule.dart';
import '../../constants.dart' as constants;
import 'Forms/Preferences.dart';
import 'Forms/DataForm.dart';
import 'Forms/imageForm.dart';
import 'Forms/MeditationForm.dart';

Map<String, String> body = {};
String? imgPath;
Map<String, String> preferencesAnswers = {};
List<Widget> preferencesWidgets = [];
String? meditationDay;
DateTime? meditationTime;
DateTime? trackingTime;

int Notification_id=0;
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
    print('Failed to load preferences');
  }

  return preferencesWidgets;
}

List<Widget> getScreens(BuildContext context) {
  return [
    DataForm(
      onBirthdaySelected: (selectedBirthday) {
        body = {'birthdate': selectedBirthday};
      },
      onGenderSelected2: (selectedGender) {
        body.addAll({'gender': selectedGender});
      },
    ),
    ...preferencesWidgets,
    ImageForm(onImageSelected: (imagePath) {
      imgPath = imagePath;
    }),
    MeditationForm(onMeditationTimeSelected: (weekday, time) {
      setMeditationTime(weekday, time);
    }, question: 'When do you want to meditate?', day: true,),
    MeditationForm(onMeditationTimeSelected: (weekday, time) {
      setTrackingTime(time);
    }, question: 'When do you want to be notified about daily tracking?', day: false,),
  ];
}

void setTrackingTime(DateTime time) {
  trackingTime = time;
}

void setMeditationTime(String weekday, DateTime time) {
  meditationDay = weekday;
  meditationTime = time;
}

void updateProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');
  var request = http.MultipartRequest(
    'PATCH',
    Uri.parse('${constants.BaseURL}/api/auth/user/'),
  );

  if (imgPath != null) {
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
    print('Failed to update preferences');
  }
}

Future<void> scheduleMeditationReminders(String NotificationType) 
async {
  Map<String, int> dayMapping = {
    "Sunday": 0,
    "Monday": 1,
    "Tuesday": 2,
    "Wednesday": 3,
    "Thursday": 4,
    "Friday": 5,
    "Saturday": 6
  };

  List<bool> _selectedDays = List.generate(7, (index) => false);
  if (dayMapping.containsKey(meditationDay)) 
  {
    _selectedDays[dayMapping[meditationDay]!] = true;
  } 
  else {
    print("Invalid day: $meditationDay");
    return;
  }

  DateTime now = DateTime.now();

  for (int i = 0; i < _selectedDays.length; i++) 
  {
    if (_selectedDays[i]) {
      int dayDifference = (i - now.weekday + 7) % 7;
      if (dayDifference == 0 &&
          now.hour >= meditationTime!.hour &&
          now.minute >= meditationTime!.minute) 
          {
                dayDifference += 7;
           }

      DateTime scheduledTime = DateTime(
        now.year,
        now.month,
        now.day,
        meditationTime!.hour,
        meditationTime!.minute,
      ).add(Duration(days: dayDifference));

     Notification_id= await NotificationServices.scheduleNotification( 
      Schedule( 
         details: NotificationType,
          time: scheduledTime,
        ),
      );
       SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt(NotificationType, Notification_id);
       print('Notification ID saved: $Notification_id');
    }
  }

}


void scheduleTrackingReminders()
{
  print(trackingTime);
}