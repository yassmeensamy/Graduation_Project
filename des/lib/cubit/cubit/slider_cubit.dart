import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';

class SliderCubit extends Cubit<double> {
  SliderCubit() : super(0);

  void updateSliderValue(double newValue) {
    emit(newValue);
  }
}
