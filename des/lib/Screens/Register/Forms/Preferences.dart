import 'package:flutter/material.dart';

class PreferencesForm extends StatelessWidget {
  final String? question;
  const PreferencesForm(this.question,{super.key});
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

List preferencesWidgets = [const PreferencesForm('Do you like sports?'),const PreferencesForm('Are you in a good health state?')];