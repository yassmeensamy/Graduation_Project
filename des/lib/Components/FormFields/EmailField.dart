import 'package:flutter/material.dart';
import '../../constants.dart' as constants;

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  bool enabled = true;
  EmailField(this.controller, {this.enabled = true, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: TextFormField(
          enabled: enabled,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an email';
            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                .hasMatch(value.trim())) {
              return 'Please enter a valid email';
            }
            return null;
          },
          controller: controller,
          decoration: constants.getInputDecoration(
              'Email Address', Icons.mail_outline)),
    );
  }
}
