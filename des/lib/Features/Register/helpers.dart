import 'dart:convert';
import 'package:des/Features/Notification/NotificationServices.dart';
import 'package:des/Features/Notification/Schedule.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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


DateTime HandleNotificationTime(DateTime? Selectedtime ,int dayDifference,DateTime scheduledday)
 {

  DateTime scheduledTime = DateTime
  (
   scheduledday.year,
   scheduledday.month,
   scheduledday.day,
   Selectedtime!.hour,
  Selectedtime!.minute,
  );
  if (scheduledTime.isBefore( DateTime.now())) 
  {
    scheduledTime = scheduledTime.add(Duration(days:dayDifference));
  }
  return scheduledTime;
}

//MedtitaionTrack
Future<void> scheduleMeditationReminders(String NotificationType,{DateTime? meditaion, String? selectedWeekday}) 
async 
{
  Map<String, int> dayMapping = 
  {
    "Sunday": DateTime.sunday,
    "Monday": DateTime.monday,
    "Tuesday": DateTime.tuesday,
    "Wednesday": DateTime.wednesday,
    "Thursday": DateTime.thursday,
    "Friday": DateTime.friday,
    "Saturday": DateTime.saturday,
  };

  List<bool> _selectedDays = List.generate(7, (index) => false);
  if (dayMapping.containsKey(selectedWeekday == null ? meditationDay : selectedWeekday)) 
  {
    _selectedDays[dayMapping[selectedWeekday == null ? meditationDay: selectedWeekday]!-1] = true;
  } 
  else 
  {
    print(selectedWeekday);
    print("Invalid day: $meditationDay");
    return;
  }

  DateTime now = DateTime.now();

  for (int i = 0; i < _selectedDays.length; i++) 
  {
            if (_selectedDays[i]) 
        {
      int currentWeekday = now.weekday; 
      int dayDifference = (i - currentWeekday + 7) % 7;
      if (dayDifference == 0 && (now.hour > meditationTime!.hour || (now.hour == meditationTime!.hour && now.minute >= meditationTime!.minute)))
       {
        dayDifference += 7;
      }
      print(i);
      print(now.weekday);
      print(((i+1)- now.weekday + 7) % 7);
       DateTime scheduledday =  now.add(Duration(days: ((i+1)- now.weekday + 7) % 7));
       DateTime scheduledTime= HandleNotificationTime(meditaion== null ? meditationTime: meditaion, 0, scheduledday);   
        int notificationId = await NotificationServices.scheduleNotification(
        Schedule(
          details: NotificationType,
          time: scheduledTime,
        ),
      );   
       SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt(NotificationType, notificationId);
      print(prefs.getInt(NotificationType));
       print('Notification ID saved Meditaion: $notificationId');
      
    
     }
  }
}

/// TrackNotification
Future<void> scheduleTrackingReminders(String notificationType,{DateTime? trackTime}) async 
{
 DateTime scheduledTime=HandleNotificationTime(trackTime ==null? trackingTime : trackTime,1, DateTime.now());
  int notificationId = await NotificationServices.scheduleNotification(
    Schedule(
      details: notificationType,
      time: scheduledTime,
    ),
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(notificationType, notificationId);
  print('Notification ID saved: $notificationId');
}

