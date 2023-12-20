import 'package:flutter/material.dart';

const Color pageColor = Color(0xfff5f5f5);
const Color babyBlue = Color(0xff6495ED);
const Color babyBlue80 = Color.fromRGBO(100, 149, 237, 0.8);
const Color babyBlue70 = Color.fromRGBO(100, 149, 237, 0.7);
const Color babyBlue30 = Color.fromRGBO(100, 149, 237, 0.3);
const Color lilac = Color(0xffB57EDC);
const Color lilac80 = Color.fromRGBO(181, 126, 220, 0.8);
const Color lilac70 = Color.fromRGBO(181, 126, 220, 0.7);
const Color lilac30 = Color.fromRGBO(181, 126, 220, 0.3);
const Color txtGrey = Color(0xff7F7F7F);
const Color lightGrey = Color(0xffECE9EC);
const Color darkGrey = Color(0xff1E1E1E);
const Color mint = Color(0xffD5E8E4);
const Color green = Color(0xff6FDFC7);
List<Map<String, int>> scores = List.generate(25, (index) => {"value": -1});
const TextStyle welcomeTextStyle = TextStyle(fontSize: 24);
const TextStyle regularTextStyle = TextStyle(color: txtGrey);
const TextStyle linkTextStyle = TextStyle(color: babyBlue);

InputDecoration getInputDecoration(String hintText, IconData suffixIcon) {
  return InputDecoration(
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
    hintText: hintText,
    suffixIcon: Icon(suffixIcon),
    hintStyle: const TextStyle(color: txtGrey),
    suffixIconColor: txtGrey,
  );
}

class VerticalPadding extends StatelessWidget {
  const VerticalPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 16,
    );
  }
}

ButtonStyle getButtonStyle(Color color) {
  return ElevatedButton.styleFrom(
    backgroundColor: color,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 72.0),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0))),
  );
}
