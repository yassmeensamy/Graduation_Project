import 'package:des/Models/user.dart';
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
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  String? accessToken;
  String? refreshToken;
  User user = User();

  UserProvider? userProvider;

  @override
  void initState() {
    super.initState();
    getTokens();
  }

  void getTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('accessToken');
      refreshToken = prefs.getString('refreshToken');
    });
    if (accessToken != null && refreshToken != null) {
      fetchUserProfile();
    }
  }

  fetchUserProfile() {
    userProvider = UserProvider();
    user.firstName = 'Yara';
    user.lastName = 'Muhammad';
    user.gender = 'Female';
    user.dob = '2001-18-10';
    user.email = 'yara@gmail.com';
    user.isEmailVerified = true;
    user.image = '';
    userProvider!.setUser(user);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (accessToken != null && refreshToken != null) {
      if (user.isEmailVerified! && user.gender != null && user.dob != null) {
        return _buildMaterialApp(const Home());
      } else if (user.isEmailVerified! &&
          (user.gender == null || user.dob == null)) {
        return _buildMaterialApp(const Data());
      } else {
        return _buildMaterialApp(const VerifyEmail());
      }
    } else {
      return _buildMaterialApp(const OnBoarding());
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
