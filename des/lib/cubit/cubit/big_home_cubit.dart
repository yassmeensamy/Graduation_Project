import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'big_home_state.dart';

class BigHomeCubit extends Cubit<BigHomeState>
{
  BigHomeCubit() : super(BigHomeInitial());
  
}
