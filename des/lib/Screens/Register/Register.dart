import 'package:des/Components/AuthButton.dart';
import 'package:des/Components/FormFields/EmailField.dart';
import 'package:des/Components/FormFields/NameField.dart';
import 'package:des/Components/FormFields/PasswordField.dart';
import 'package:des/Components/SocialAuth.dart';
import 'package:des/screens/Login.dart';
import 'package:flutter/material.dart';
import '../../Components/LoginTemp.dart';
import '../../Components/navigationLink.dart';
import '../../Controllers/AuthController.dart';
import '../../constants.dart' as constants;

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginTemp(constants.lilac70, 'Sign Up', 380, Content());
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          constants.VerticalPadding(310),
          Text(
            'Hello! ',
            style: constants.welcomeTextStyle,
          ),
          constants.VerticalPadding(16),
          Text(
            'Our Journey to Well-being Starts Here.',
            style: TextStyle(color: constants.txtGrey),
          ),
          constants.VerticalPadding(16),
          RegisterFrom(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: TextStyle(color: constants.lilac),
              ),
              NavigationLink(
                  Text(
                    'Login Now',
                    style: TextStyle(
                        color: constants.lilac, fontWeight: FontWeight.bold),
                  ),
                  Login()),
            ],
          ),
          SocialAuth('or sign up with', constants.lilac)
        ],
      ),
    );
  }
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController nameController = TextEditingController();

class RegisterFrom extends StatefulWidget {
  const RegisterFrom({super.key});

  @override
  State<RegisterFrom> createState() => _RegisterFromState();
}

class _RegisterFromState extends State<RegisterFrom> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    void register() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        String email = emailController.text.toString();
        String password = passwordController.text.toString();
        String name = nameController.text.toString();
        await callRegisterApi(context, name, email, password);
        setState(() {
          isLoading = false;
        });
      }
    }
    return Form(
      key: _formKey,
      child: Column(
        children: [
          NameField(nameController),
          const constants.VerticalPadding(5),
          EmailField(emailController),
          const constants.VerticalPadding(5),
          PasswordField(passwordController, obscureText: true, labelText: 'Password', toggleVisibility: () {  },),
          const constants.VerticalPadding(13),
          AuthButton(
              isLoading: isLoading,
              onPressed: register,
              txt: "Let's Begin",
              color: constants.lilac),
          const constants.VerticalPadding(8),
        ],
      ),
    );
  }
}
