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
      _fetchUserProfile();
    }
  }

  _fetchUserProfile() {
    userProvider = UserProvider();
    user.firstName = 'Yara';
    user.lastName = 'Muhammad';
    user.gender = null;
    user.dob = null;
    user.email = 'yara@gmail.com';
    user.isEmailVerified = true;
    user.image = null;
    user.googlePhoto='';
    userProvider!.setUser(user);
    setState(() {});
  }
  
  bool _isLoggedInVerifiedAndProfileComplete() {
    return accessToken != null &&
        refreshToken != null &&
        user.isEmailVerified! &&
        user.gender != null &&
        user.dob != null;
  }

  bool _isLoggedInVerifiedAndProfileIncomplete() {
    return accessToken != null &&
        refreshToken != null &&
        user.isEmailVerified! &&
        (user.gender == null || user.dob == null);
  }

  bool _isLoggedInAndNotVerified() {
    return accessToken != null &&
        refreshToken != null &&
        !user.isEmailVerified!;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedInVerifiedAndProfileComplete()) {
      return _buildMaterialApp(const Home());
    } else if (_isLoggedInVerifiedAndProfileIncomplete()) {
      return _buildMaterialApp(const Data());
    } else if (_isLoggedInAndNotVerified()) {
      return _buildMaterialApp(const VerifyEmail());
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
