import 'dart:async';
import 'package:des/Components/loader.dart';
import 'package:des/main.dart';
import 'package:flutter/material.dart';
import '../../constants.dart' as constants;

class CustomizingLoader extends StatefulWidget {
  const CustomizingLoader({super.key});

  @override
  State<CustomizingLoader> createState() => _CustomizingLoaderState();
}

class _CustomizingLoaderState extends State<CustomizingLoader> {
  List texts = [
    'Customizing Your Experience',
    'Getting things ready',
    'Saving your preferences'
  ];
  int i = 0;
  String txt = 'Customizing Your Experience';

  @override
  void initState() {
    var t = Timer.periodic(const Duration(seconds: 3), (timer) {
      i++;
      if (i > 2) {
        i = 0;
      }
      setState(() {
        txt = texts[i];
      });
    });
    Timer.periodic(const Duration(seconds: 10), (timer) {
      t.cancel();
      timer.cancel();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MainNavigator()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constants.pageColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Loader(),
            Container(
                padding: const EdgeInsets.only(top: 64.0),
                child: Text(
                  txt,
                  style: const TextStyle(fontSize: 24),
                ))
          ],
        ));
  }
}
