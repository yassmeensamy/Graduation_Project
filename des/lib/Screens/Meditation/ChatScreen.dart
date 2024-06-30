import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'ChallengeYourThoughtsPage.dart';
import 'ChatBubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    fetchNegativeThoughts();
  }

  List<String> thoughtExplanations = [];
  List<String> thoughtTypes = [];
  List<String> thoughtTips = [];
  String tip = '';
  List<Map<String, String>> questionsAndTips = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int currentQuestionIndex = 0;
  bool showFinishButton = false;

  Future<void> fetchNegativeThoughts() async {
    final response = await http
        .get(Uri.parse('http://16.24.83.230/api/negative-thinking-types/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      thoughtTypes = data.map((item) => item['name'] as String).toList();
      thoughtExplanations =
          data.map((item) => item['explanation'] as String).toList();
      thoughtTips =
          data.map((item) => item['tips'] as String).toList();
      setState(() {
        messages.add({
          'message': 'What type of negative thoughts do you have?',
          'isMe': false,
          'options': thoughtTypes
        });
      });
    } else {
      throw Exception('Failed to load thought types');
    }
  }

  Future<void> fetchQuestions(int thoughtTypeId) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? accessToken = prefs.getString('accessToken');
   
      Map<String, String> headers = 
      {
        'Authorization':
            'Bearer $accessToken',
             'Content-Type': 'application/json',
      };     
    final response = await http
        .post(Uri.parse('http://16.24.83.230/api/cbt-questions-by-type/'),
            body: json.encode({
              "type_ids": [thoughtTypeId],
            }), headers:headers,);

    if (response.statusCode == 200)
     {
      final List<dynamic> data = json.decode(response.body);
      questionsAndTips = data
          .map((item) => {
                "question": item['question_text'] as String,
                "tip": item['after_question_tip'] as String
              })
          .toList();
      if (questionsAndTips.isNotEmpty) {
        setState(() {
          messages.add({
            'message': questionsAndTips[0]['question']!,
            'isMe': false,
          });
        });
      }
    } 
    else {
      print(response.statusCode);
      print(response.body);
    }
  }

  List<Map<String, dynamic>> messages = [];

  void handleOptionSelected(String option) {
    setState(() {
      messages.add({
        'message': option,
        'isMe': true,
      });
    });
    if (thoughtTypes.contains(option)) {
      int index = thoughtTypes.indexOf(option);
      tip = thoughtTips[index];

      if (index != -1) {
        String explanation = thoughtExplanations[index];

        setState(() {
          messages.add({
            'message': explanation,
            'isMe': false,
            'options': ['Yes', 'No'],
          });
        });
      }
    }
    if (option == 'Yes') {
      int index = thoughtTypes.indexOf(option);
      fetchQuestions(index);
    } else if (option == 'No') {
      fetchNegativeThoughts();
    }
    _scrollToBottom();
  }

  void handleSendMessage() {
    String messageText = _textController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        messages.add({
          'message': messageText,
          'isMe': true,
        });
        _textController.clear();
      });

      if (currentQuestionIndex < questionsAndTips.length) {
        setState(() {
          messages.add({
            'message': questionsAndTips[currentQuestionIndex]['tip']!,
            'isMe': false,
          });
          currentQuestionIndex++;
        });

        if (currentQuestionIndex < questionsAndTips.length) {
          setState(() {
            messages.add({
              'message': questionsAndTips[currentQuestionIndex]['question']!,
              'isMe': false,
            });
          });
        } else {
          setState(() {
            showFinishButton = true;
          });
        }
      }
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void handleFinish() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChallengeYourThoughtsPage(
            topText:
                'After the session, On a scale of 0 to 100, how would you rate how you are feeling each of these emotions:',
            buttonText: 'Finish', tip: tip,

          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        title: const Text(
          'Challenge Your Thoughts',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xfff5f5f5),
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatBubble(
                  message: message['message'],
                  isMe: message['isMe'],
                  options: message['options'],
                  onOptionSelected: handleOptionSelected,
                );
              },
            ),
          ),
          if (showFinishButton)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: handleFinish,
                child: const Text('Finish'),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: handleSendMessage,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
