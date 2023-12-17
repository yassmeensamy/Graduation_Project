import 'package:des/Models/SecondMoodModel.dart';
import 'package:des/Screens/JournalingScreen.dart';
import 'package:des/Widgets/DataCard.dart';
import 'package:des/Widgets/Horizontal.dart';
import 'package:des/Widgets/MoodCard.dart';
import 'package:des/Widgets/NextButton.dart';
import 'package:flutter/material.dart';
import '../constants.dart' as constants;


class SecondViewMood extends StatefulWidget {
  @override
  _SecondViewMoodState createState() => _SecondViewMoodState();
}

class _SecondViewMoodState extends State<SecondViewMood> {
  List<SecondMoodModel> moods = [
    SecondMoodModel(
      Description: 'Happy Description',
      ImagePath: 'assets/images/Emotions/Proud.png',
      moodText: 'Happy',
    ),
      SecondMoodModel(
      Description: 'Happy Description',
      ImagePath: 'assets/images/Emotions/Proud.png',
      moodText: 'Happy',
    ),
       SecondMoodModel(
      Description: 'Happy Description',
      ImagePath: 'assets/images/Emotions/Proud.png',
      moodText: 'Happy',
    ),
       SecondMoodModel(
      Description: 'Happy Description',
      ImagePath: 'assets/images/Emotions/Proud.png',
      moodText: 'Happy',
    ),
       SecondMoodModel(
      Description: 'Happy Description',
      ImagePath: 'assets/images/Emotions/Proud.png',
      moodText: 'Happy',
    ),
       SecondMoodModel(
      Description: 'Happy Description',
      ImagePath: 'assets/images/Emotions/Proud.png',
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
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 13),
                ),
                SizedBox(width: 35),
                Text(
                  "How are you Feeling?",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 12),
            DateCard(Date: "Today 11:47"),
            SizedBox(height: 25),
            Image(
              image: AssetImage("assets/images/Emotions/Proud.png"),
              width: 130.0,
              height: 130.0,
            ),
            SizedBox(height: 25),
            HorizontalLineDrawingWidget(),
            SizedBox(height: 25),
            Text(
              "Happy",
              style: TextStyle(fontSize: 40, color: Colors.black, fontFamily: 'Roboto'),
            ),
            SizedBox(height: 20),
            Text(
              "Which words describe your feeling best?",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
              padding: EdgeInsets.only(bottom: 20),
              child: NextButton(ontap: ()
              {
                 Navigator.push(context,MaterialPageRoute(builder: (context) => Journalingcreen()));
              },),
            ),
          ],
        ),
      ),
    );
  }
}
