import 'package:des/Screens/Test/TestScreen.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog {
  final BuildContext context;
  final String title;
  final String message;
  final String actionText;
  final IconData icon;

  CustomAlertDialog({
    required this.context,
    required this.title,
    required this.message,
    required this.actionText,
    required this.icon,
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
          padding: EdgeInsets.all(10),
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
                  Expanded(child: 
               Text(
                title,
                softWrap: true,
                maxLines: 2,

                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
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
                    icon: Icon(icon),
                    label: Text(actionText),
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
