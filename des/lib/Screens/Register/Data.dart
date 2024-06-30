import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../Components/upperBgCircle.dart';
import '../../Models/user.dart';
import '../../Providers/UserProvider.dart';
import '../../constants.dart' as constants;

import 'CustomizingLoader.dart';
import 'helpers.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  List<Widget> screens = [];
  int currentIndex = 0;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchPreferencesWidgets().then((widgets) {
      setState(() {
        screens = getScreens(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User? currentUser = userProvider.user;

    return WillPopScope(
      onWillPop: () async {
        if (currentIndex > 0) {
          if (currentIndex == 1) {
            body = {};
          }
          if (preferencesAnswers.length > 1 && preferencesAnswers.length < 6) {
            preferencesAnswers.remove(preferencesAnswers.keys.last);
          }
          setState(() {
            currentIndex--;
            errorMessage = '';
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: constants.pageColor,
                child: Stack(
                  children: <Widget>[
                    UpperBgCircle(constants.babyBlue70,
                        'Welcome ${currentUser!.firstName}', 370),
                    buildNextButton(),
                    buildFormContent(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Positioned buildNextButton() {
    return Positioned(
      top: 515.h,
      left: 100.h,
      child: GestureDetector(
        onTap: onNext,
        child: Container(
          width: 380.0,
          height: 380.0,
          decoration: const BoxDecoration(
            color: constants.lilac70,
            shape: BoxShape.circle,
          ),
          child: const Padding(
            padding: EdgeInsets.only(bottom: 100.0, left: 130),
            child: Row(
              children: [
                Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildFormContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 290),
          const Text('Tell us more about you!', style: TextStyle(fontSize: 24)),
          Text(errorMessage,
              style: const TextStyle(fontSize: 12, color: Colors.red)),
          if (screens.isNotEmpty) screens[currentIndex],
        ],
      ),
    );
  }

  void onNext() {
    print(preferencesAnswers.length);
    print(currentIndex);
    setState(() {
      errorMessage = '';
      if (currentIndex < screens.length - 1) {
        if (currentIndex == 0 && validatePersonalInfo()) {
          currentIndex++;
        } else if (currentIndex > 0 &&
            currentIndex < screens.length - 2 &&
            validatePreferences()) {
          currentIndex++;
        } else if (currentIndex >= screens.length - 2) {
          currentIndex++;
        } else {
          errorMessage = 'Please answer the question(s)';
        }
      } else if (validateMeditation()) {
        scheduleMeditationReminders();
        sendPreferences();
        updateProfile();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const CustomizingLoader()));
      } else {
        errorMessage = 'Please answer the question(s)';
      }
    });
  }

  bool validatePersonalInfo() {
    return body.containsKey('birthdate') && body.containsKey('gender');
  }

  bool validatePreferences() {
    return preferencesAnswers.length == currentIndex;
  }

  bool validateMeditation() {
    return meditationDay != null &&
        meditationDay != 'None' &&
        meditationTime != null;
  }

  void onBack() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        errorMessage = '';
      }
    });
  }
}
