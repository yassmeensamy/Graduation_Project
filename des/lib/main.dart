import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:des/Components/loader.dart';
import 'package:des/Controllers/AuthController.dart';
import 'package:des/Models/user.dart';
import 'package:des/NotificationServices.dart';
import 'package:des/Screens/Insigth/WeeklyGraph.dart';
import 'package:des/Screens/Temp.dart';
import 'package:des/cubit/PlanCubits/cubit/topics_plan_cubit.dart';
import 'package:des/cubit/cubit/cubit/depression_cubit.dart';
import 'package:des/cubit/cubit/cubit/plan_tasks_cubit.dart';
import 'package:des/cubit/cubit/cubit/weekly_cubit.dart';
import 'package:des/cubit/cubit/handle_emojy_daily_cubit.dart';
import 'package:des/cubit/cubit/learning_cubit.dart';
import 'package:des/cubit/cubit/weekly_tasks_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //done
  await AwesomeNotifications()
      .isNotificationAllowed().then 
      (
    (isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    },
  );
  await NotificationServices.initializeNotification();
  await NotificationServices().setupNotifications();
  runApp(
    MultiBlocProvider(
      providers: 
      [
        BlocProvider(create: (context) => WeeklyCubit()..GetAspects()),
        BlocProvider(create: (context) => InsigthsCubit()..loadInsights()),
        BlocProvider(create: (context) => TopicsPlanCubit()),
        BlocProvider(create: (context) => SecondLayerCubit()),
        BlocProvider(create: (context) => ActivitiesCubit()),
        BlocProvider(create: (context) => SliderCubit()),
        BlocProvider(create: (context) => LearningCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider( create: (context) => MoodCubit(context.read<SecondLayerCubit>())),
        BlocProvider(create: (context) => WeeklyTasksCubit()..GetWeeklyToDo()),
        BlocProvider( create: (context) => PlanTasksCubit()..FetchPlanToDoList()),
        BlocProvider(create: (context) => WeeklytabsCubit()),
        BlocProvider( create: (context) => HandleEmojyDailyCubit(  moodCubit: BlocProvider.of<SecondLayerCubit>(context),  )..loadData()),
        BlocProvider( create: (context) => DepressionCubit()..CheckDepression(),
        )
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
    // logout(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      refreshToken = prefs.getString('refreshToken');
      accessToken = prefs.getString('accessToken');
    });
    if (accessToken != null && refreshToken != null) {
      await fetchUserProfile();
    }
  }
  getProfile() async {
    Response response = await get(
        Uri.parse('${constants.BaseURL}/api/auth/user/'),
        headers: {'Authorization': 'Bearer $accessToken'});
    Map userData = jsonDecode(response.body);
    return userData;
  }

  fetchUserProfile() async {
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
  bool _isnotLoggedIn() 
  {
    return accessToken == null || refreshToken == null;
  }
  @override
  Widget build(BuildContext context) 
  {
    if (_isLoggedInVerifiedAndProfileComplete()) {
      return _buildMaterialApp(const temp());
    } else if (_isLoggedInVerifiedAndProfileIncomplete()) {
      return _buildMaterialApp(const Data());
    } else if (_isLoggedInAndNotVerified()) {
      return _buildMaterialApp(const VerifyEmail());
    } else if (_isnotLoggedIn()) {
      return _buildMaterialApp(const OnBoarding());
    } else
     {
      return _buildMaterialApp(const Loader());
    }
  }
  Widget _buildMaterialApp(Widget homeWidget) {
    return  ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => ChangeNotifierProvider.value(
        value: userProvider,
        child: OKToast(
          child: Builder(
            builder: (context) {
              return MaterialApp(
                routes: {
                  '/home': (context) => temp(), // Replace with your actual route
                },
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  backgroundColor: constants.pageColor,
                  body: homeWidget,
                ),
              );
            },
          ),
        )
      ),
    );
  }
}
