import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../constants.dart' as constants;

class AuthButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String txt;
  final Color color;

  const AuthButton({
    Key? key,
    required this.isLoading,
    required this.onPressed,
    required this.txt,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: constants.getButtonStyle(color),
      child: isLoading
          ? LoadingAnimationWidget.prograssiveDots(
              color: Colors.white, size: 16)
          : Text(
              txt,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
    );
  }
}
