import 'package:flutter/material.dart';
import '../../Components/LoginTemp.dart';
import '../../Components/VerificationCodeFields.dart';
import '../../constants.dart' as constants;
import 'Data.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginTemp(constants.lilac70, 'Verfiy Your Email', 390, Content());
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
        constants.VerticalPadding(340),
        Text(
          'Verify its you.',
          style: TextStyle(fontSize: 24),
        ),
        constants.VerticalPadding(8),
        Row(
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
        constants.VerticalPadding(8),
        EmailFrom(),
      ],
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
        ElevatedButton(
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
        const constants.VerticalPadding(16),
      ],
    );
  }
}
