import 'package:des/Components/AuthButton.dart';
import 'package:flutter/material.dart';
import '../../Components/LoginTemp.dart';
import '../../Components/VerificationCodeFields.dart';
import '../../constants.dart' as constants;
import 'Reset.dart';

class Verfiy extends StatelessWidget {
  const Verfiy({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginTemp(
        constants.babyBlue70, 'Forgot Password?', 390.0, Content());
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
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
                style: TextStyle(color: constants.txtGrey, fontSize: 18),
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
        CodeFrom(),
      ],
    );
  }
}

class CodeFrom extends StatefulWidget {
  const CodeFrom({super.key});

  @override
  State<CodeFrom> createState() => _CodeFromState();
}

class _CodeFromState extends State<CodeFrom> {
  verifyOTP() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Reset()));
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const constants.VerticalPadding(32),
        const VerificationCodeFields(),
        const constants.VerticalPadding(32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Didn’t receive code ? '),
            GestureDetector(
                child: const Text('Resend',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        const constants.VerticalPadding(32),
        AuthButton(
            isLoading: isLoading,
            onPressed: verifyOTP,
            txt: "Submit",
            color: constants.babyBlue),
      ],
    );
  }
}
