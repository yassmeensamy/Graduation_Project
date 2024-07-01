import 'dart:convert';
import 'package:des/Components/AuthButton.dart';
import 'package:des/Components/FormFields/PasswordField.dart';
import 'package:des/Screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../Components/LoginTemp.dart';
import '../../Components/Toasts.dart';
import '../../constants.dart' as constants;

String email = '';

class Reset extends StatelessWidget {
  Reset(e) {
    email = e;
  }

  @override
  Widget build(BuildContext context) {
    return LoginTemp(
        constants.babyBlue70, 'Forgot Password?', 390.0, Content());
  }
}

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
  @override
  State<LoginFrom> createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  updatePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        Response response = await post(
            Uri.parse('${constants.BaseURL}/api/auth/reset-password/'),
            body: {
              "email": email,
              "new_password": passwordController.text,
            });
        if (response.statusCode == 200) {
          successToast(jsonDecode(response.body)['message']);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Login()),
            (Route<dynamic> route) => false,
          );
        } else {
          errorToast('Something went wrong. Please try again later');
        }
      } catch (e) {
        errorToast('Something went wrong. Please try again later');
      }
    }
  }

  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          PasswordField(passwordController, obscureText: true, labelText: 'Password', toggleVisibility: () {  }, ),
          const constants.VerticalPadding(5),
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
      ),
    );
  }
}
