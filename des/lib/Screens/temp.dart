import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Components/BottomNavigation.dart';
import '../cubit/cubit/home_cubit.dart';


class temp extends StatelessWidget {
  const temp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body:  BlocProvider.of<HomeCubit>(context).Screens[BlocProvider.of<HomeCubit>(context).currentIndex],
          bottomNavigationBar:BottomNavigator(),
        );
      },
    );
  }
}
