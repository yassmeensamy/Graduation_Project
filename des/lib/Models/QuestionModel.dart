
import 'AnswerOptionModel.dart';

class Question {
  final String question;
  final List<AnswerOption> answerOptions;

  Question({
    required this.question,
    required this.answerOptions,
  });

  factory Question.fromJson(Map<String, dynamic> json)
   {
    List<dynamic> answerOptionList = json['answer_options'];
    final answerOptions = answerOptionList.map((item) {
      return AnswerOption.fromJson(item);
    }).toList();

    return Question(
      question: json['question'] ?? '',
      answerOptions: answerOptions,
    );
  }
}