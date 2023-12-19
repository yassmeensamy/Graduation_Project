import 'package:flutter/material.dart';

class VerificationCodeFields extends StatefulWidget {
  const VerificationCodeFields({super.key});

  @override
  State<VerificationCodeFields> createState() => _VerificationCodeFieldsState();
}

class _VerificationCodeFieldsState extends State<VerificationCodeFields> {
  List<FocusNode>? _focusNodes;
  List<TextEditingController>? _controllers;
  final _numberOfFields = 4;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(_numberOfFields, (index) => FocusNode());
    _controllers =
        List.generate(_numberOfFields, (index) => TextEditingController());
    _initListeners();
  }

  void _initListeners() {
    for (int i = 0; i < _numberOfFields; i++) {
      _controllers![i].addListener(() {
        if (_controllers![i].text.length == 1 && i < _numberOfFields - 1) {
          _focusNodes![i].unfocus();
          FocusScope.of(context).requestFocus(_focusNodes![i + 1]);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          _numberOfFields,
          (index) => SizedBox(
            width: 50.0,
            child: TextField(
              controller: _controllers![index],
              focusNode: _focusNodes![index],
              keyboardType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: '-',
                counterText: '',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
