import 'package:des/Components/AuthButton.dart';
import 'package:des/Components/FormFields/EmailField.dart';
import 'package:des/Components/FormFields/PasswordField.dart';
import 'package:des/Components/LoginTemp.dart';
import 'package:des/Components/SocialAuth.dart';
import 'package:des/Components/navigationLink.dart';
import 'package:des/Controllers/AuthController.dart';
import 'package:flutter/material.dart';
import 'ForgotPassword/Forgot.dart';
import 'Register/Register.dart';
import '../constants.dart' as constants;

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginTemp(
        constants.babyBlue70, 'Sign In', 390.0, LoginContent());
  }
}

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const constants.VerticalPadding(340.0),
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
        const constants.VerticalPadding(16),
        const Text(
          'Our Journey to Well-being Continues Here.',
          style: constants.regularTextStyle,
        ),
        const constants.VerticalPadding(16),
        const LoginFrom(),
        Row(
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
        ),
        const SocialAuth('or sign in with', constants.babyBlue),
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    void login() async {
      if (_formKey.currentState!.validate()) {
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
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          EmailField(emailController),
          const constants.VerticalPadding(5),
          PasswordField(
            passwordController,
            obscureText: _obscurePassword,
            labelText: 'Password',
            toggleVisibility: _togglePasswordVisibility,
          ),
          const constants.VerticalPadding(16),
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
          const constants.VerticalPadding(16),
          AuthButton(
            isLoading: isLoading,
            onPressed: login,
            txt: 'Let\'s Begin',
            color: constants.babyBlue,
          ),
        ],
      ),
    );
  }
}
