import 'package:des/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../Providers/UserProvider.dart';
import '../../../constants.dart' as constants;

class MindfulMomentsTracker extends StatefulWidget {
  @override
  _MindfulMomentsTrackerState createState() => _MindfulMomentsTrackerState();
}

class _MindfulMomentsTrackerState extends State<MindfulMomentsTracker> {
  Map<String, String> moodData = {};
  bool isLoading = true;
  DateTime currentDate = DateTime.now();
  String date = DateFormat.yMMM().format(DateTime.now());

  @override
  void initState() {
    super.initState();
    fetchMoodData(currentDate.month);
  }

  Future<void> fetchMoodData(int month) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    final url = '${constants.BaseURL}/api/user-input-list-by-month/';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $accessToken"
      },
      body: json.encode({"month_number": month}),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      setState(() {
        moodData.clear();
        for (var item in data) {
          moodData[item['date']] = item['emotion_image'];
        }
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Widget buildCalendar() {
    int daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: daysInMonth,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
            itemBuilder: (context, index) {
              String date = DateFormat('yyyy-MM-dd').format(
                  DateTime(currentDate.year, currentDate.month, index + 1));
              String? imageUrl = moodData[date];

              return Container(
                margin: EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    imageUrl != null
                        ? Expanded(
                            child: Image.network(constants.BaseURL + imageUrl,
                                height: 40, width: 40))
                        : Container(height: 40, width: 40),
                    Text((index + 1).toString()),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void changeMonth(int offset) {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month + offset, 1);
      date = DateFormat.yMMM().format(currentDate);
      isLoading = true;
      fetchMoodData(currentDate.month);
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User? currentUser = userProvider.user;
    return Scaffold(
      backgroundColor: constants.pageColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: constants.pageColor,
        title: Padding(
          padding: const EdgeInsets.only(top:25.0),
          child: Text(
            'Hello, ${currentUser!.firstName}!',
            style: TextStyle(color: Colors.black, fontSize: 32),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top:25.0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 45),
              child: Column(
                children: [
                  Text('Mindful Moments Tracker',
                      style: TextStyle(fontSize: 18, color: Colors.blue)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => changeMonth(-1)),
                      Text(date, style: TextStyle(fontSize: 18)),
                      IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () => changeMonth(1)),
                    ],
                  ),
                  Expanded(child: buildCalendar()),
                ],
              ),
            ),
    );
  }
}
