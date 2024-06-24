import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChatScreen.dart';
import 'MoodImprovementScreen.dart';

class ChallengeYourThoughtsPage extends StatefulWidget {
  final String topText;
  final String buttonText;

  const ChallengeYourThoughtsPage({
    super.key,
    required this.topText,
    required this.buttonText,
  });

  @override
  ChallengeYourThoughtsPageState createState() =>
      ChallengeYourThoughtsPageState();
}

class ChallengeYourThoughtsPageState extends State<ChallengeYourThoughtsPage> {
  double happy = 50;
  double sad = 50;
  double loved = 50;
  double fear = 50;
  double disgust = 50;
  double surprised = 50;
  double angry = 50;


  Future<void> handleValues(double happy, double sad, double loved, double fear,
      double disgust, double surprised, double angry) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('happy')) {
       double oldHappy = prefs.getDouble('happy')!;
    double oldSad = prefs.getDouble('sad')!;
    double oldLoved = prefs.getDouble('loved')!;
    double oldFear = prefs.getDouble('fear')!;
    double oldDisgust = prefs.getDouble('disgust')!;
    double oldSurprised = prefs.getDouble('surprised')!;
    double oldAngry = prefs.getDouble('angry')!;
    // Calculate mood improvement
    double moodImprovement = ((happy - oldHappy) + (oldSad - sad) + (loved - oldLoved) + (oldFear - fear) + (oldDisgust - disgust) + (surprised - oldSurprised) + (oldAngry - angry)) / 7;

    // Delete the old values from SharedPreferences
    await prefs.remove('happy');
    await prefs.remove('sad');
    await prefs.remove('loved');
    await prefs.remove('fear');
    await prefs.remove('disgust');
    await prefs.remove('surprised');
    await prefs.remove('angry');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MoodImprovementScreen(moodImprovementPercentage: moodImprovement)),
    );

    } else {
      await prefs.setDouble('happy', happy);
      await prefs.setDouble('sad', sad);
      await prefs.setDouble('loved', loved);
      await prefs.setDouble('fear', fear);
      await prefs.setDouble('disgust', disgust);
      await prefs.setDouble('surprised', surprised);
      await prefs.setDouble('angry', angry);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ChatScreen()));
    }
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.topText,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildEmotionSlider(
                'Happy', happy, 'assets/images/Emotions/Proud.png', (value) {
              setState(() {
                happy = value;
              });
            }),
            _buildEmotionSlider('Sad', sad, 'assets/images/Emotions/Sad.png',
                (value) {
              setState(() {
                sad = value;
              });
            }),
            _buildEmotionSlider(
                'Loved', loved, 'assets/images/Emotions/Loved.png', (value) {
              setState(() {
                loved = value;
              });
            }),
            _buildEmotionSlider(
                'Fear', fear, 'assets/images/Emotions/Insecure.png', (value) {
              setState(() {
                fear = value;
              });
            }),
            _buildEmotionSlider(
                'Disgust', disgust, 'assets/images/Emotions/Bitter.png',
                (value) {
              setState(() {
                disgust = value;
              });
            }),
            _buildEmotionSlider(
                'Surprised', surprised, 'assets/images/Emotions/Startled.png',
                (value) {
              setState(() {
                surprised = value;
              });
            }),
            _buildEmotionSlider(
                'Angry', angry, 'assets/images/Emotions/Threatended.png',
                (value) {
              setState(() {
                angry = value;
              });
            }),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  handleValues(
                      happy, sad, loved, fear, disgust, surprised, angry);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A6DCD),
                ),
                child: Text(widget.buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmotionSlider(String label, double value, String assetPath,
      Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.asset(assetPath, width: 50, height: 50),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Slider(
                value: value,
                min: 0,
                max: 100,
                divisions: 100,
                activeColor: const Color(0xFF6A6DCD),
                inactiveColor: const Color(0xFF6A6DCD).withOpacity(0.3),
                label: value.round().toString(),
                onChanged: onChanged,
              ),
            ),
            Text(value.round().toString(),
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ],
    );
  }
}
