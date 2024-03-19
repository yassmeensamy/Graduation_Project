import 'package:des/Providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Components/upperBgCircle.dart';
import '../../Models/user.dart';
import 'CustomizingLoader.dart';
import '../../constants.dart' as constants;
import 'Forms/DataForm.dart';
import 'Forms/Preferences.dart';
import 'Forms/imageForm.dart';

int i = 0;
List<Widget> arr = getScreens();
Map<String, String> body = {};
String? imgPath;

List<Widget> getScreens() {
  List<Widget> arr = [
    DataForm(
      onBirthdaySelected: (selectedBirthday) {
        body = {'birthdate': selectedBirthday};
      },
      onGenderSelected2: (selectedGender) {
        body.addAll({'gender': selectedGender});
      },
    )
  ];

  for (int i = 0; i < preferencesWidgets.length; i++) {
    arr.add(preferencesWidgets[i]);
  }
  arr.add(ImageForm(onImageSelected: (imagePath) {
    print(imagePath);
    imgPath = imagePath;
  }));
  return arr;
}

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User? currentUser = userProvider.user;
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: constants.pageColor,
              child: Stack(
                children: <Widget>[
                  UpperBgCircle(constants.babyBlue70,
                      'Welcome ${currentUser!.firstName}', 370),
                  Positioned(
                    top: 670,
                    left: 149,
                    child: Container(
                      width: 380.0,
                      height: 380.0,
                      decoration: const BoxDecoration(
                        color: constants.lilac70,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 100.0, left: 120),
                            child: GestureDetector(
                              onTap: () {
                                if (i != 3) {
                                  setState(() {
                                    i = i + 1;
                                  });
                                } else {
                                  updateProfile();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const CustomizingLoader()));
                                }
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    'Next',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 290,
                        ),
                        const Text(
                          'Tell us more about you! ',
                          style: TextStyle(fontSize: 24),
                        ),
                        arr[i],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void updateProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');
  var request = http.MultipartRequest(
      'PATCH', Uri.parse('${constants.BaseURL}/api/auth/user/'));
  if (imgPath != null) {
    request.files.add(await http.MultipartFile.fromPath('image', imgPath!));
  }
  request.headers['Authorization'] = 'Bearer $accessToken';
  request.fields.addAll(body);
  await request.send();
}
