import 'package:flutter/material.dart';

class PreferencesForm extends StatefulWidget {
  final String? question;
  final String? tag;
  final Function(String, bool) onAnswerSelected;

  const PreferencesForm(this.question,this.tag, {required this.onAnswerSelected, Key? key}) : super(key: key);

  @override
  _PreferencesFormState createState() => _PreferencesFormState();
}

class _PreferencesFormState extends State<PreferencesForm> {
  bool? isYesSelected;

  void selectAnswer(bool answer) {
    setState(() 
    {
      isYesSelected = answer;
    });
    widget.onAnswerSelected(widget.tag!, answer);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50),
        Text(
          widget.question!,
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
        SizedBox(height: 72),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => selectAnswer(true),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  color: isYesSelected == true ? Colors.green.shade700 : Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => selectAnswer(false),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  color: isYesSelected == false ? Colors.red.shade700 : Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'No',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
