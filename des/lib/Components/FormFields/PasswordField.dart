import 'package:flutter/material.dart';
import '../../constants.dart' as constants;

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  const PasswordField(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a name';
            } else if (value.length < 3) {
              return 'Name must be at least 3 characters';
            }
            return null;
          },
          controller: controller,
          obscureText: true,
          decoration: constants.getInputDecoration('Password', Icons.lock)),
    );
  }
}
