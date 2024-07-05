
import 'package:des/Features/temp.dart';
import 'package:flutter/material.dart';

class Conclusion extends StatelessWidget {
  Conclusion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              // Reset the state of SecondLayerCubit

              // Navigate back to the Home screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => temp()),
              );
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
