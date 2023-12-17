import 'package:flutter/material.dart';


class AnswerButton extends StatefulWidget {
  final String textButton;
  final bool isSelected;   //بيشوف اختاره ولا لا
  final Function(bool) onPressed;

  const AnswerButton({super.key, 
    required this.textButton,
    required this.isSelected,//اختار ده ولا انهون
    required this.onPressed,//نتيجه الاختيار
  });

  @override
  _AnswerButtonState createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () 
      {
        widget.onPressed(!widget.isSelected);
              
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20 ,left: 10,right: 10),
        child: Container(
          width: 330,
          height: 44,
          decoration: BoxDecoration(
            border: Border.all(
              //color: widget.isSelected ? Color(0xFF4A4983) : Colors.black12,
              color: widget.isSelected ? const Color.fromARGB(255, 135, 199, 182) : Colors.white,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(17),
            color: widget.isSelected ? const Color.fromARGB(255, 127, 204, 184) : Colors.white,
          ),
          child: Center(
            child: Text(
              widget.textButton,
              style: const TextStyle(
                //color: widget.isSelected ? Colors.white : Colors.black,
                color: Colors.black,
                fontFamily: 'NotoSansKawi',
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}