import 'package:des/Components/AuthButton.dart';
import 'package:des/Components/FormFields/EmailField.dart';
import 'package:flutter/material.dart';
import '../../Components/LoginTemp.dart';
import '../../constants.dart' as constants;
import 'Verfiy.dart';

class Forgot extends StatelessWidget {
  const Forgot({super.key});

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
          'Forgot Your Password?',
          style: TextStyle(fontSize: 24),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Don’t worry it happens! Enter your Email to get the verification code.',
            style: TextStyle(color: constants.txtGrey),
          ),
        ),
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
  sendOTP() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Verfiy()),
    );
  }

  TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const constants.VerticalPadding(32),
        EmailField(emailController),
        const constants.VerticalPadding(48),
        AuthButton(isLoading: isLoading, onPressed: sendOTP, txt: "Send Code", color: constants.babyBlue),

      ],
    );
  }
}
