import 'package:flutter/material.dart';
import '../constants.dart' as constants;
class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: constants.babyBlue,
    ));
  }
}
