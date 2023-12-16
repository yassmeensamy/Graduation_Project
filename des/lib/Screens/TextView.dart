import 'package:des/GlobalData.dart';
import 'package:des/Models/QuestionModel.dart';
import 'package:des/Widgets/AnswerButton.dart';
import 'package:des/Widgets/CardQuestion.dart';
import 'package:flutter/material.dart';
class TestView extends StatefulWidget 
{
  final Question questionModel;
  final int currentQuestion;
  final VoidCallback? Next;
  final VoidCallback? Back;

  TestView({
    required this.questionModel,
    required this.currentQuestion,
    required this.Next,
    required this.Back
  });

  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  List<int> selectedAnswerIndices = List.filled(25, -1); // Initialize the list with -1 values for 25 questions
   bool Selected=false;
  @override
  Widget build(BuildContext context) {
 
    return Column(
      children: [
          Padding(padding:EdgeInsets.only(top:30),
            child:
            Row(
              children:[
                Icon(Icons.arrow_back_ios ,size: 13,),
               InkWell(onTap: (){
                widget.Back!();
               },
               child: Text("Previous", style: TextStyle(color: Colors.black)),
          ),
              ],
            ),
            ),
        CardQuestion(Question:widget.questionModel.question),
        SizedBox(height: 40,),
        Expanded(
          child: ListView.builder(
            itemCount: widget.questionModel.answerOptions.length,
            itemBuilder: (BuildContext context, int index) {
              final answerOption = widget.questionModel.answerOptions[index];
              return AnswerButton
              (
                textButton: answerOption.label,
                isSelected: index == selectedAnswerIndices[widget.currentQuestion - 1], //fبيرجع ترو او فولس
                onPressed: (isSelected) {
                  setState(() 
                  {
                    Selected=true;
                    selectedAnswerIndices[widget.currentQuestion - 1] = isSelected ? index : -1;
                    scores[widget.currentQuestion-1]["value"] =index;
                   
                  });
                },
              );
            },
          ),
        ),
      
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Container(
              width: 302, // Set the desired width
          height: 50, // Set the desired height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            color: Color(0xFF004743),
          ),
          child: InkWell(
            onTap: () 
            {
              if(Selected)
              {
              widget.Next!();
              Selected=false;
              }
              else 
              {
               ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                          content: Text("You should answer this question"),
                          duration: Duration(milliseconds: 500),
                ),
);
              }
             
            },
            child: Center
            (
              child: Text('Next', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        )
      ],
    );
    
    
  }
}
