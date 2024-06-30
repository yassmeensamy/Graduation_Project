import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import '../constants.dart' as constants;
import 'Login.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  static List<Widget> backgrounds = [
    Container(),
    Container(),
    Container(),
    Container()
  ];

  Widget slide(String img, String txt) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(img),
            const Text(
              'Welcome to SoulSync',
              style: TextStyle(color: constants.babyBlue, fontSize: 22),
            ),
            Text(
              txt,
              style: const TextStyle(color: constants.txtGrey, fontSize: 16),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      pageBackgroundColor: constants.pageColor,
      headerBackgroundColor: constants.pageColor,
      finishButtonText: 'Get Started',
      finishButtonStyle: const FinishButtonStyle(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          backgroundColor: constants.babyBlue,
          foregroundColor: Colors.white,
          highlightElevation: 0),
      onFinish: () {
        finishOnboarding(context);
      },
      trailing: const Text(''),
      indicatorAbove: true,
      controllerColor: constants.babyBlue,
      skipTextButton: const Text(
        'Skip',
        style: TextStyle(color: constants.babyBlue80, height: 3),
      ),
      background: backgrounds,
      totalPage: 4,
      speed: 1.8,
      pageBodies: [
        slide('assets/images/slide 1.png',
            'Begin your path to inner peace and emotional well-being. Our caring community is here to walk beside you on your journey to a brighter future.'),
        slide('assets/images/slide 2.png',
            'Begin your path to inner peace and emotional well-being. Our caring community is here to walk beside you on your journey to a brighter future.'),
        slide('assets/images/slide 3.png',
            'Begin your path to inner peace and emotional well-being. Our caring community is here to walk beside you on your journey to a brighter future.'),
        slide('assets/images/slide 4.png',
            'Begin your path to inner peace and emotional well-being. Our caring community is here to walk beside you on your journey to a brighter future.'),
      ],
    );
  }

  void finishOnboarding(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }
}
