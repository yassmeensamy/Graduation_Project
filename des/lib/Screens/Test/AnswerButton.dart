
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart' as constants;
import '../../Models/AnswerOptionModel.dart';
import '../../cubit/cubit/Test/TestCubit.dart';
import '../../cubit/cubit/Test/TestCubitStates.dart';
import '../../cubit/cubit/Test/answer_cubit.dart';

class AnswerButton extends StatelessWidget 
{
  AnswerOption answeroption;
  AnswerButton({
   required this.answeroption,
    });
  @override
  Widget build(BuildContext context)
   {
    return BlocBuilder<Testcubit, TestState>
    (
      builder: (context, state) 
      {
        return BlocBuilder<AnswerCubit, AnswerState>(
          builder: (context, state) {
           
           //print(state.Selectedindex);
        final isSelected = state.Selectedindex == answeroption.value ;  //دايما يبقي بزيرو لحد ما تختاري
        return InkWell(
          onTap: () {
            if (isSelected)
             {
              context.read<AnswerCubit>().disSelected();
              
            } else
             {
              context.read<AnswerCubit>().Selected(answeroption.value);   
            } 
          },
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              width: 320,
              height: 55,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? constants.babyBlue  : Colors.black12,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(30),
                color: isSelected ? constants.babyBlue : Colors.white60,
             
              ),
              child: Center(
                child: Text(
                  answeroption.label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontFamily: 'NotoSansKawi',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        );
      },
        );
      }
    );
  

}
   }