import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:des/Components/loader.dart';
import 'package:des/Models/user.dart';
import 'package:des/NotificationServices.dart';
import 'package:des/Screens/Temp.dart';
import 'package:des/cubit/cubit/cubit/weekly_cubit.dart';
import 'package:des/cubit/cubit/handle_home_cubit.dart';
import 'package:des/cubit/cubit/learning_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controllers/GoogleAuthController.dart';
import 'Providers/UserProvider.dart';
import 'Screens/Register/Data.dart';
import 'Screens/Register/VerifyEmail.dart';
import 'constants.dart' as constants;
import 'cubit/EmotionCubit.dart';
import 'cubit/cubit/activity_card_cubit.dart';
import 'cubit/cubit/home_cubit.dart';
import 'cubit/cubit/insigths_cubit.dart';
import 'cubit/cubit/slider_cubit.dart';
import 'cubit/mood_card_cubit.dart';
import 'screens/Onboarding.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized(); //done
  await AwesomeNotifications().isNotificationAllowed().then   //يطلب الاذن انه يعمل 
  (
    (isAllowed) 
    {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();          
      }
    },
  );
  await NotificationServices.initializeNotification();
  runApp(
    MultiBlocProvider(
      providers: [
         BlocProvider(
        create: (context) => WeeklyCubit(),
         ),
        BlocProvider(create: (context)=>InsigthsCubit()),
        BlocProvider(create: (context) => SecondLayerCubit()),
        BlocProvider(create: (context) => ActivitiesCubit()),
        BlocProvider(create: (context) => SliderCubit()),
        BlocProvider(create: (context) => LearningCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => MoodCubit(context.read<SecondLayerCubit>())),
        BlocProvider<HandleHomeCubit>(
          create: (context) => HandleHomeCubit
          (
            moodCubit: BlocProvider.of<SecondLayerCubit>(context),
            weeklyCubit:BlocProvider.of<WeeklyCubit>(context),
            insigthsCubit: BlocProvider.of<InsigthsCubit>(context),
          )
        ),
       
      
      ],
      child: const MainNavigator(),
    ),
  );
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({Key? key}) : super(key: key);

  @override
  MainNavigatorState createState() => MainNavigatorState();
}

logout() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('accessToken');
  //tgghkjf  ycgb
  await prefs.remove('refreshToken');
  googleLogout();
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
    //logout();
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
        Uri.parse('${constants.BaseURL}/api/auth/user/'),
        headers: {'Authorization': 'Bearer $accessToken'});
    print(response.body);
    Map userData = jsonDecode(response.body);
    return userData;
  }

  _fetchUserProfile() async {
    Map<String, dynamic>? userData = await getProfile();

    userProvider = UserProvider();
    user.firstName = userData?['first_name'];
    user.lastName = userData?['last_name'];
    user.gender = userData?['gender'];
    user.dob = userData?['birthdate'];
    user.email = userData?['email'];
    user.isEmailVerified = userData?['is_verified'];
    user.image = userData?['image'];
    userProvider!.setUser(user);
    setState(() {});
  }

  bool _isLoggedInVerifiedAndProfileComplete() {
    return accessToken != null &&
        refreshToken != null &&
        user.isEmailVerified != null &&
        user.isEmailVerified! &&
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
    return accessToken == null || refreshToken == null;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedInVerifiedAndProfileComplete()) 
    {
      return _buildMaterialApp( const temp());
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
           routes: {
        '/home': (context) => temp(),
      },
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: constants.pageColor,
            body://ContentLesson()
            homeWidget,
            //ContentLesson()
            //SecondViewMoodPage(),
            //ContentsLearning(),
            //TotalLessons(),
            //WeeklyGraph()
            //WeeklySurvey(),
          ),
        ),
      ),
    );
  }
}



class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await printAllSharedPreferences();
          },
          child: Text('Print Shared Preferences'),
        ),
      ),
    );
  }

  Future<void> printAllSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, Object> allEntries = prefs.getKeys().fold({}, (map, key) {
      map[key] = prefs.get(key)!;
      return map;
    });

    allEntries.forEach((key, value) {
      print('$key: $value');
    });
  }
}
