import 'package:des/Cubits/TestCubits/TestCubit.dart';
import 'package:des/GlobalData.dart';
import 'package:des/Screens/Result.dart';
import 'package:des/Screens/TestScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() 
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 final int total=60;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home:Result( total_score: total,),
      /* BlocProvider
      (
        create: (context) => Testcubit(),
        child: TestScreen(),
      
      ),
      */
    );
  }
}
