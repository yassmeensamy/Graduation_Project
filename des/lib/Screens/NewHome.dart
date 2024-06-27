import 'package:des/cubit/cubit/handle_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class newHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HandleHomeCubit, HandleHomeState>(
        builder: (context, state) 
        {
          if (state is HomeLoading) {
            return Center(child: CircularProgressIndicator());
          } 
          else if (state is HomeError) 
          {
          return Container( color: Colors.red,
          );
          } 
          else if (state is HomeError) {
            return Center(child: Text('Error: ${state.errormessge}'));
          }

          return Container(
            color: Colors.red,
          );
        },
      ),
    );
  }
}

class NewHome extends StatelessWidget {
  const NewHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}