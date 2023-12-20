import 'package:flutter/material.dart';

class NavigationLink extends StatelessWidget {
  final Widget? widget;
  final Widget? dest;
  const NavigationLink(this.widget, this.dest, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => dest!));
        },
        child: widget);
  }
}
