import 'dart:convert';

import 'package:des/Components/loader.dart';
import 'package:des/Models/user.dart';
import 'package:http/http.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Providers/UserProvider.dart';
import 'Screens/Home.dart';
import 'Screens/Register/Data.dart';
import 'Screens/Register/VerifyEmail.dart';
import 'constants.dart' as constants;
import 'screens/Onboarding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainNavigator());
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({Key? key}) : super(key: key);

  @override
  MainNavigatorState createState() => MainNavigatorState();
}

class MainNavigatorState extends State<MainNavigator> {
  String? accessToken;
  String? refreshToken;
  User user = User();

  UserProvider? userProvider;

  @override
  void initState() {
    super.initState();
    _getTokens();
  }

  _getTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('accessToken');
      refreshToken = prefs.getString('refreshToken');
    });
    if (accessToken != null && refreshToken != null) {
      await _fetchUserProfile();
    }
  }

  getProfile() async {
    Response response = await get(
        Uri.parse('https://mentally.duckdns.org/api/profile/'),
        headers: {'Authorization': 'Bearer $accessToken'});
    Map userData = jsonDecode(response.body);
    return userData;
  }

  _fetchUserProfile() async {
    Map<String, dynamic>? userData = await getProfile();

    userProvider = UserProvider();
    user.firstName = userData?['first_name'];
    user.lastName = userData?['last_name'];
    user.gender = userData?['gender'];
    user.dob = userData?['birth_date'];
    user.email = 'yara@gmail.com';
    user.isEmailVerified = true;
    user.image = null;
    user.googlePhoto = '';
    userProvider!.setUser(user);
    setState(() {});
  }

  bool _isLoggedInVerifiedAndProfileComplete() {
    return accessToken != null &&
        refreshToken != null &&
        user.isEmailVerified != null && // Perform null check here
        user.isEmailVerified! && // Access property only if not null
        user.gender != null &&
        user.dob != null;
  }

  bool _isLoggedInVerifiedAndProfileIncomplete() {
    return accessToken != null &&
        refreshToken != null &&
        user.isEmailVerified != null &&
        user.isEmailVerified! &&
        (user.gender == null || user.dob == null);
  }

  bool _isLoggedInAndNotVerified() {
    return accessToken != null &&
        refreshToken != null &&
        user.isEmailVerified != null &&
        !user.isEmailVerified!;
  }
  bool _isnotLoggedIn() {
    return accessToken == null ||
        refreshToken == null;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedInVerifiedAndProfileComplete()) {
      return _buildMaterialApp(const Home());
    } else if (_isLoggedInVerifiedAndProfileIncomplete()) {
      return _buildMaterialApp(const Data());
    } else if (_isLoggedInAndNotVerified()) {
      return _buildMaterialApp(const VerifyEmail());
    } else if (_isnotLoggedIn()) {
      return _buildMaterialApp(const OnBoarding());
    } else {
      return _buildMaterialApp(const Loader());
    }
  }

  Widget _buildMaterialApp(Widget homeWidget) {
    return ChangeNotifierProvider.value(
      value: userProvider,
      child: OKToast(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: constants.pageColor,
            body: homeWidget,
          ),
        ),
      ),
    );
  }
}
