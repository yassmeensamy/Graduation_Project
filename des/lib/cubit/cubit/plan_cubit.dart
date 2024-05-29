import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'plan_state.dart';

class PlanCubit extends Cubit<PlanState> 
{
  PlanCubit() : super(PlanInitial());
}
