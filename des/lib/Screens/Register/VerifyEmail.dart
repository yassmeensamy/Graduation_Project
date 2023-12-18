import 'package:flutter/material.dart';
import '../../constants.dart' as constants;
import 'Data.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
            child: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: constants.pageColor,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -80,
                      left: -50,
                      child: Container(
                        width: 390.0,
                        height: 390.0,
                        decoration: const BoxDecoration(
                          color: constants.lilac70,
                          shape: BoxShape.circle,
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(85.0),
                              child: Text(
                                'Verify Your Email',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 44,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 340,
                          ),
                          Text(
                            'Verify its you.',
                            style: TextStyle(fontSize: 24),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Enter the code sent to ',
                                  style: TextStyle(
                                      color: constants.txtGrey, fontSize: 18),
                                ),
                                Text(
                                  'abc@example.com',
                                  style: TextStyle(
                                      color: constants.txtGrey,
                                      decoration: TextDecoration.underline,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          EmailFrom(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmailFrom extends StatefulWidget {
  const EmailFrom({super.key});

  @override
  State<EmailFrom> createState() => _EmailFromState();
}

class _EmailFromState extends State<EmailFrom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 32,
        ),
        const VerificationCodeFields(),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Didn’t receive code ? '),
              GestureDetector(
                  child: const Text('Resend',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Data()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: constants.lilac,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 72.0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
            ),
            child: const Text(
              "Submit",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    );
  }
}

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
