import 'package:des/Components/Toasts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../constants.dart' as constants;

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<dynamic> questions = [];
  Map<String, String> answers = {};

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    final response = await http.get(
        Uri.parse('${constants.BaseURL}/api/preference-questions/'),
        headers: {"Authorization": "Bearer $accessToken"});

    if (response.statusCode == 200) {
      setState(() {
        questions = json.decode(response.body);
      });
    } else {
      print(response.body);
      print(response.statusCode);
      print('Failed to load questions');
    }
  }

  void submitAnswers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    List<Map<String, String>> answerList = answers.entries
        .map((entry) => {'tag': entry.key, 'answer': entry.value})
        .toList();

    print(json.encode({'answers': answerList}));

    final response = await http.post(
      Uri.parse('${constants.BaseURL}/api/preference-questions/answer/'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $accessToken"
      },
      body: json.encode({'answers': answerList}),
    );

    if (response.statusCode == 200) {
      successToast(jsonDecode(response.body)['message']);
      Navigator.of(context).pop();
    } else {
      errorToast('Something went wrong, please try again later.');
      print(response.body);
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.pageColor,
      appBar: AppBar(
        title: Text(
          'Preferences',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: constants.pageColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
        ),
      ),
      body: questions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question['question_text'],
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    answers[question['tag']['name']] == 'yes'
                                        ? Colors.green
                                        : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  answers[question['tag']['name']] = 'yes';
                                });
                              },
                              child: Text('Yes'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    answers[question['tag']['name']] == 'no'
                                        ? Colors.red
                                        : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  answers[question['tag']['name']] = 'no';
                                });
                              },
                              child: Text('No'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: submitAnswers,
        child: Icon(Icons.send),
      ),
    );
  }
}
