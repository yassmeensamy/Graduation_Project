import 'package:flutter/material.dart';

import '../../constants.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  final VoidCallback toggleVisibility;
  const PasswordField(this.controller,
      {super.key,
      required this.obscureText,
      required this.labelText,
      required this.toggleVisibility});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a Password';
            } else if (value.length < 8) {
              return 'Password must be at least 8 characters';
            }
            return null;
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: txtGrey),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: babyBlue70),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            hintText: labelText,
            hintStyle: const TextStyle(color: txtGrey),
            suffixIconColor: txtGrey,
            labelText: labelText,
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: toggleVisibility,
            ),
          ),
          controller: controller,
          obscureText: obscureText,
        ));
  }
}
