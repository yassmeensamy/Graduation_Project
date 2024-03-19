import 'package:des/Cubits/TestCubits/TestCubit.dart';
import 'package:des/Cubits/TestCubits/TestCubitStates.dart';
import 'package:des/Screens/Result.dart';
import 'package:des/Screens/TextView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Testcubit(),
      child: Testcreen(),
    );
  }
}

class Testcreen extends StatelessWidget {
  int currentQuestionindex = 1;
  bool isAnswerSelected = false;

  Testcreen({super.key});

  void selectAnswer() {
    isAnswerSelected = true;
  }

  List<Map<String, int>> scores = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF0F3),
        body: Padding(
          padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
          child: BlocBuilder<Testcubit, TestState>(
            builder: (context, state) {
              if (state is TestInitial) {
                // Handle the initial state, you can return a loading indicator or any other widget.

                return Scaffold(
                  backgroundColor: Colors.green,
                  body: ElevatedButton(
                    onPressed: () {
                      context.read<Testcubit>().fetchQuestions();
                    },
                    child: const Text('Start test'),
                  ),
                );
              } else if (state is TestQuestion) {
                return TestView(
                  questionModel: state.questions[currentQuestionindex - 1],
                  currentQuestion: currentQuestionindex,
                  Next: () {
                    if (currentQuestionindex <= 25) {
                      context.read<Testcubit>().fetchNextQuestions();
                      currentQuestionindex++;
                    }
                  },
                  Back: () {
                    context.read<Testcubit>().fetchPreviousQuestions();
                    currentQuestionindex--;
                  },
                );
              } else if (state is TestError) {
                // Handle the error state, you can return an error message or any other widget.
                return const Scaffold(backgroundColor: Colors.black);
              } else if (state is TestFinished) {
                // Handle the finished state, you can return a completion message or any other widget.

                return ResultScreen(totalScore: state.finalScore);
              } else {
                // Handle any other states here.
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
