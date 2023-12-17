import 'package:des/Cubits/TestCubits/TestCubit.dart';
import 'package:des/GlobalData.dart';
import 'package:des/Screens/Activities.dart';
import 'package:des/Screens/Exercise.dart';
import 'package:des/Screens/ReportScreen.dart';
import 'package:des/Screens/Result.dart';
import 'package:des/Screens/SecondLayerMood.dart';
import 'package:des/Screens/TestScreen.dart';
import 'package:des/Widgets/Horizontal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants.dart' as constants;
import 'screens/Onboarding.dart';

void main() 
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        
        backgroundColor: constants.pageColor,
        body: ExerciseScreen()
        

      )
    );
  }
}
/*
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Description App'),
        ),
        body: ImageWithDescription(),
      ),
    );
  }
}

class ImageWithDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        onHover: (event) {
          // Display the Snackbar with the image description
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Description of the image'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Emotions/Proud.png'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
*/