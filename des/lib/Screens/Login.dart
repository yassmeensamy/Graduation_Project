import 'package:des/Components/LoginTemp.dart';
import 'package:des/Components/SocialAuth.dart';
import 'package:des/Components/navigationLink.dart';
import 'package:des/Controllers/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'ForgotPassword/Forgot.dart';
import 'Register/Register.dart';
import '../constants.dart' as constants;

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginTemp(
        constants.babyBlue70, 'Sign In', 390.0, const LoginContent());
  }
}

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

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
        WelcomeText(),
        constants.VerticalPadding(),
        LoginFrom(),
        Option(),
        SocialAuth('or sign in with', constants.babyBlue),
      ],
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Welcome ',
              style: constants.welcomeTextStyle,
            ),
            Text(
              'Back!',
              style: constants.welcomeTextStyle
                  .copyWith(color: constants.babyBlue),
            ),
          ],
        ),
        const constants.VerticalPadding(),
        const Text(
          'Our Journey to Well-being Continues Here.',
          style: constants.regularTextStyle,
        ),
      ],
    );
  }
}

class Option extends StatelessWidget {
  const Option({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'New Here? ',
          style: constants.linkTextStyle,
        ),
        NavigationLink(
            Text('Register Now',
                style: constants.linkTextStyle
                    .copyWith(fontWeight: FontWeight.bold)),
            const Register())
      ],
    );
  }
}

class LoginFrom extends StatefulWidget {
  const LoginFrom({super.key});

  @override
  State<LoginFrom> createState() => _LoginFromState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginFromState extends State<LoginFrom> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    void login() async {
      setState(() {
        isLoading = true;
      });
      String email = emailController.text.toString();
      String password = passwordController.text.toString();
      await callLoginApi(context, email, password);
      setState(() {
        isLoading = false;
      });
    }

    return Column(
      children: [
        SizedBox(
          height: 60,
          child: TextFormField(
              controller: emailController,
              decoration: constants.getInputDecoration(
                  'Email Address', Icons.mail_outline)),
        ),
        const constants.VerticalPadding(),
        SizedBox(
          height: 60,
          child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: constants.getInputDecoration('Password', Icons.lock)),
        ),
        const constants.VerticalPadding(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            NavigationLink(
                Text(
                  'Forgot Password?',
                  style: constants.linkTextStyle,
                ),
                Forgot()),
          ],
        ),
        const constants.VerticalPadding(),
        ElevatedButton(
          onPressed: login,
          style: constants.getButtonStyle(constants.babyBlue),
          child: isLoading
              ? LoadingAnimationWidget.prograssiveDots(
                  color: Colors.white, size: 16)
              : const Text(
                  "Let's Begin",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
        )
      ],
    );
  }
}
