import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants.dart' as constants;
import '../cubit/cubit/home_cubit.dart';

class BottomNavigator extends StatelessWidget {
  BottomNavigator();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: constants.mint,
      ),child: 
     Padding(
        padding: EdgeInsets.only(left: 0, right: 0, bottom: 0),
        child: SizedBox(
            height:63,
            child:
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BottomNavigationBar(
            iconSize: 27,
            selectedItemColor: Color(0xff6495ED),
            unselectedItemColor: Color(0xff1E1E1E).withOpacity(.7),
            currentIndex: BlocProvider.of<HomeCubit>(context).currentIndex,
            onTap:(value)
            {
              BlocProvider.of<HomeCubit>(context).changeIndex(value);
            },
            //onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.bookOpen),
                label: 'Learning',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.book),
                label: 'Exercise',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.chartColumn),
                label: 'Insights',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.listCheck),
                label: 'Plans',
              ),
            ],
          ),
        ),
      ),
     )
    );
  }
  
 
}
