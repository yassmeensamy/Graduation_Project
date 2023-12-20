import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../Controllers/GoogleAuthController.dart';
import '../constants.dart' as constants;

class SocialAuth extends StatelessWidget {
  final String? txt;
  final Color? color;
  const SocialAuth(this.txt, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 4,
              height: 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    color!,
                    const Color(0x00C4C4C4),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(txt!),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4,
              height: 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color(0x00C4C4C4),
                    constants.babyBlue,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SocialIcon(
              Icon(
                MdiIcons.google,
                color: Colors.red,
                size: 32,
              ),
              googleAuth),
          const SizedBox(
            width: 25,
          ),
          const SocialIcon(
              Icon(
                Icons.facebook,
                color: Colors.blue,
                size: 32,
              ),
              googleAuth),
          const SizedBox(
            width: 25,
          ),
          const SocialIcon(
              Icon(
                Icons.apple,
                color: Colors.black,
                size: 32,
              ),
              googleAuth),
        ],
      ),
      const constants.VerticalPadding(10)
    ]);
  }
}

class SocialIcon extends StatelessWidget {
  final Icon? icon;
  final Function? func;

  const SocialIcon(this.icon, this.func, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        func!(context);
      },
      child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
              color: constants.lightGrey, shape: BoxShape.circle),
          child: icon),
    );
  }
}
