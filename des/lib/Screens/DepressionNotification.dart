import 'package:des/Screens/Test/TestScreen.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog {
  final BuildContext context;
  final String title;
  final String message;

  CustomAlertDialog({
    required this.context,
    required this.title,
    required this.message,
  });

  void show() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: contentBox(context),
        );
      },
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
        
          ),
          child:
           Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               Text(
                title,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),

              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 20,
                  ),
                )

                ]
              ),
              SizedBox(height: 16.0),
              Text(
                message,
                style: TextStyle(fontSize: 14.0),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TestScreen()));
                    },
                    icon: Icon(Icons.arrow_forward),
                    label: Text('Go to Test'),
                  ),
                  SizedBox(width: 16.0),
                  
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
