
import 'package:des/Features/Test/Models/QuestionModel.dart';
import 'package:des/Features/Test/TestCubit/TestCubit.dart';
import 'package:des/Features/Test/TestCubit/TestCubitStates.dart';
import 'package:des/Features/Test/TestCubit/answer_cubit.dart';
import 'package:des/Features/Test/Widgets/AnswerButton.dart';
import 'package:des/Features/Test/Widgets/CardQuestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart' as constants;


import '../Temp.dart';

import 'ResultScreen.dart';

class TestScreen extends StatelessWidget {
  List<Question> questions = [];
  @override
  Widget build(BuildContext context)
   {
   //BlocProvider.of<Testcubit>(context).getQuestions(context);
   return  BlocProvider<Testcubit>(
      create: (context) => Testcubit(context),
      child:BlocProvider<AnswerCubit>(
          create: (context) => AnswerCubit(testcubit: context.read<Testcubit>()),
        child:
        Scaffold(
      body: BlocConsumer<Testcubit, TestState>
      (
        listener: (context, state) {
          if (state is HomeNaviagtion) 
          {
            Navigator.push(context,MaterialPageRoute(builder: (context) => temp()),
            );
          }
        },
        builder: (context, state) 
        {
          if (state is TestLoading) 
          {
            return Center(child: CircularProgressIndicator());
          } 
          else if (state is TestQuestion) 
          {
                
            questions = context.read<Testcubit>().questions;
            return TestView(currentQuestion: 0, questions: questions);
          } 
          else if (state is TestQuestionChanged)
           {
                 print("${state.currentQuestionIndex}");
                 return TestView(currentQuestion: state.currentQuestionIndex,questions: questions);
           } 
          else if (state is TestFinished)
           {  
            /*           لو داس باك يرجع للهوم ولا سؤال الي قبله احط pop   */
             return ResultScreen(testResult: state.testresult);
           } 
          else 
          {
            print(state.runtimeType);
            return Container(
              color: Colors.blue,
            ); // Fallback for other states
          }
        },
      ),
    ),
   ),
   );
  }
}

class TestView extends StatelessWidget {
  final List<Question> questions;
  final int currentQuestion;

  TestView({
    Key? key,
    required this.questions,
    required this.currentQuestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 40, left: 20),
          child:   currentQuestion != 0
    ? Row(
        children: [
          Icon(Icons.arrow_back_ios, size: 13),
          InkWell(
            onTap: () {
              BlocProvider.of<Testcubit>(context)
                  .fetchPreveriousQuestions(currentQuestion, context);
            },
            child: Text("Previous", style: TextStyle(color: Colors.black)),
          ),
        ],
      )
    : SizedBox(),
        ),
        Expanded(
          child: ListView(
            children: [
              CardQuestion(
                
                Question: questions[currentQuestion].question
              ),
              SizedBox(height: 8),
              ...questions[currentQuestion]
                  .answerOptions
                  .map((answerOption) => AnswerButton(
                        answeroption: answerOption,
                      ))
                  .toList(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Container(
            width: 302,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: constants.babyBlue,
            ),
            child: InkWell(
              onTap: () {
                BlocProvider.of<Testcubit>(context)
                    .fetchNextQuestions(currentQuestion, context);
              },
              child: const Center(
                child: Text('Next', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class testViewLoading extends StatelessWidget {
  const testViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
             Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(30), ),
           //color: ,
            child: Container(
              width: 400,
              height: 200,
            ),
             ),
              Container(
              width: 320,
              height: 55,
              decoration: BoxDecoration(
                border: Border.all(
                
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(30),
                
              ),
              ),
      ],
      

    );
  }
}