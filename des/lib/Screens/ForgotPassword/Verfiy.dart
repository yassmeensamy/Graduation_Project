import 'package:flutter/material.dart';
import '../../Components/VerificationCodeFields.dart';
import '../../Components/upperBgCircle.dart';
import '../../constants.dart' as constants;
import 'Reset.dart';

class Verfiy extends StatelessWidget {
  const Verfiy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  UpperBgCircle(
                      constants.babyBlue70, 'Forgot Password?', 390.0),
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
                          padding: EdgeInsets.symmetric(vertical: 5.0),
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
                  .push(MaterialPageRoute(builder: (context) => const Reset()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: constants.babyBlue,
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

