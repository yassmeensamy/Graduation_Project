import 'package:des/Components/AuthButton.dart';
import 'package:des/Components/FormFields/PasswordField.dart';
import 'package:des/main.dart';
import 'package:flutter/material.dart';
import '../../Components/LoginTemp.dart';
import '../../constants.dart' as constants;

class Reset extends StatelessWidget {
  const Reset({super.key});

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
          'Reset Your Password',
          style: TextStyle(fontSize: 24),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Enter a new pasword',
            style: TextStyle(color: constants.txtGrey),
          ),
        ),
        LoginFrom(),
      ],
    );
  }
}

class LoginFrom extends StatefulWidget {
  const LoginFrom({super.key});

  @override
  State<LoginFrom> createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {
  updatePassword() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MainNavigator()));
  }

  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PasswordField(passwordController),
        const constants.VerticalPadding(5),
        PasswordField(passwordController),
        const SizedBox(
          height: 16,
        ),
        const constants.VerticalPadding(16),
        AuthButton(
            isLoading: isLoading,
            onPressed: updatePassword,
            txt: "Submit",
            color: constants.babyBlue),
      ],
    );
  }
}
