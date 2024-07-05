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
        style: TextStyle(color: constants.babyBlue80),
      ),
      background: backgrounds,
      totalPage: 4,
      speed: 1.8,
      pageBodies: [
        slide('assets/images/slide 1.png',
            'your personal companion on a journey towards mindfulness and well-being. Our app is designed to help you cultivate a balanced mind and improve your mental health through meditation, daily check-ins, and personalized plans. Let’s embark on this journey together!'),
        slide('assets/images/slide 2.png',
            'Explore a variety of guided meditations tailored to your needs. Whether you\'re seeking relaxation, stress relief, or a boost in focus, SoulSync provides sessions that fit into your schedule. Dive into mindfulness and start experiencing the benefits today.'),
        slide('assets/images/slide 3.png',
            'Stay in tune with your emotions through daily mood tracking. SoulSync helps you identify patterns and triggers, providing insights into your mental well-being. Reflect on your feelings and gain a deeper understanding of your emotional health.'),
        slide('assets/images/slide 4.png',
            'Create a wellness plan that suits your lifestyle. Customize your meditation schedule, set reminders, and choose specific days for your sessions. SoulSync adapts to your preferences, ensuring a seamless integration into your daily routine.'),
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
