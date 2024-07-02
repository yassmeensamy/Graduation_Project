import 'package:flutter_bloc/flutter_bloc.dart';

class SliderCubit extends Cubit<double> {
  SliderCubit() : super(1);

  void updateSliderValue(double newValue) {
    emit(newValue);
  }
}
