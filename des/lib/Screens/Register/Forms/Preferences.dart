import 'package:flutter/material.dart';



class PreferencesForm extends StatelessWidget {
  String? question;
  PreferencesForm(String q,{super.key, this.question})
  {
    question =q;
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Text(question!),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

List preferencesWidgets = [PreferencesForm('Do you like sports?'),PreferencesForm('Are you in a good health state?')];