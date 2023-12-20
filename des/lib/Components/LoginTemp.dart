import 'package:flutter/material.dart';
import '../constants.dart' as constants;
import 'UpperBgCircle.dart';

class LoginTemp extends StatelessWidget {
  final Color? color;
  final String? title;
  final double? size;
  final Widget? content;
  const LoginTemp(this.color, this.title, this.size, this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.pageColor,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: [
              UpperBgCircle(color!, title, size),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: content)
            ],
          ),
        ),
      ),
    );
  }
}
