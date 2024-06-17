import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';

class SliderCubit extends Cubit<double> {
  SliderCubit() : super(1);

  void updateSliderValue(double newValue) {
    emit(newValue);
  }
}
/*

class WeeklyRating extends Cubit<Map<String,double>>
{

   WeeklyRating():super();
   setAspects()
   {

   }
   void SaveAspectRating(String Aspect,Double)
   {
     
   }

}
*/