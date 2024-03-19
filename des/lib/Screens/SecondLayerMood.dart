import 'package:des/Models/SecondMoodModel.dart';
import 'package:des/Screens/JournalingScreen.dart';
import 'package:des/Widgets/DataCard.dart';
import 'package:des/Widgets/Horizontal.dart';
import 'package:des/Widgets/MoodCard.dart';
import 'package:des/Widgets/NextButton.dart';
import 'package:flutter/material.dart';

class SecondViewMood extends StatefulWidget {
  const SecondViewMood({super.key});

  @override
  SecondViewMoodState createState() => SecondViewMoodState();
}

class SecondViewMoodState extends State<SecondViewMood> {
  List<SecondMoodModel> moods = [
    SecondMoodModel(
      description: 'Happy Description',
      imagePath: 'assets/images/Emotions/Proud.png',
      moodText: 'Happy',
    ),
      SecondMoodModel(
      description: 'Happy Description',
      imagePath: 'assets/images/Emotions/Proud.png',
      moodText: 'Happy',
    ),
       SecondMoodModel(
      description: 'Happy Description',
      imagePath: 'assets/images/Emotions/Proud.png',
      moodText: 'Happy',
    ),
       SecondMoodModel(
      description: 'Happy Description',
      imagePath: 'assets/images/Emotions/Proud.png',
      moodText: 'Happy',
    ),
       SecondMoodModel(
      description: 'Happy Description',
      imagePath: 'assets/images/Emotions/Proud.png',
      moodText: 'Happy',
    ),
       SecondMoodModel(
      description: 'Happy Description',
      imagePath: 'assets/images/Emotions/Proud.png',
      moodText: 'Happy',
    ),
    // Add other mood models as needed
  ];

  int selectedMoodIndex = -1; // Initialize with an invalid index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios, size: 13),
                ),
                const SizedBox(width: 35),
                const Text(
                  "How are you Feeling?",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const DateCard(date: "Today 11:47"),
            const SizedBox(height: 25),
            const Image(
              image: AssetImage("assets/images/Emotions/Proud.png"),
              width: 130.0,
              height: 130.0,
            ),
            const SizedBox(height: 25),
            const HorizontalLineDrawingWidget(),
            const SizedBox(height: 25),
            const Text(
              "Happy",
              style: TextStyle(fontSize: 40, color: Colors.black, fontFamily: 'Roboto'),
            ),
            const SizedBox(height: 20),
            const Text(
              "Which words describe your feeling best?",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: moods.length,
                itemBuilder: (context, index) {
                  return MoodCard(
                    mood: moods[index],
                    isSelected: selectedMoodIndex == index,
                    onPressed: (isSelected) 
                    {
                      setState(() {
                        if (selectedMoodIndex == index) {
                          // Deselect if the same mood is tapped again
                          selectedMoodIndex = -1;
                        } else {
                          // Select the tapped mood
                          selectedMoodIndex = index;
                        }
                      });
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: NextButton(ontap: ()
              {
                 Navigator.push(context,MaterialPageRoute(builder: (context) => const Journalingcreen()));
              },),
            ),
          ],
        ),
      ),
    );
  }
}
