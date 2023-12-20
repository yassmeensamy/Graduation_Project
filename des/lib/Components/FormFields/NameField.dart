import 'package:flutter/material.dart';
import '../../constants.dart' as constants;

class NameField extends StatelessWidget {
  final TextEditingController controller;
  const NameField(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a name';
            } else if (!RegExp(r'^\S+\s\S+$').hasMatch(value)) {
              return 'Please enter both first and last names';
            }
            return null;
          },
          controller: controller,
          decoration: constants.getInputDecoration('Name', Icons.person)),
    );
  }
}
