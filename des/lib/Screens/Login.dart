import 'dart:async';

import 'package:des/Components/Toasts.dart';
import 'package:des/Tokens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:oktoast/oktoast.dart';
import '../Components/upperBgCircle.dart';
import 'ForgotPassword/Forgot.dart';
import 'Home.dart';
import 'Register/Register.dart';
import '../constants.dart' as constants;

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: constants.pageColor,
                child: Stack(
                  children: <Widget>[
                    UpperBgCircle(constants.babyBlue70, 'Sign In', 390.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 340,
                          ),
                          const Row(
                            children: [
                              Text(
                                'Welcome ',
                                style: TextStyle(fontSize: 24),
                              ),
                              Text(
                                'Back!',
                                style: TextStyle(
                                    fontSize: 24, color: constants.babyBlue),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Our Journey to Well-being Continues Here.',
                              style: TextStyle(color: constants.txtGrey),
                            ),
                          ),
                          const LoginFrom(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'New Here? ',
                                style: TextStyle(color: constants.babyBlue),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Register()));
                                  },
                                  child: const Text(
                                    'Register Now',
                                    style: TextStyle(
                                        color: constants.babyBlue,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: 3,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                      colors: [
                                        constants.babyBlue,
                                        Color(0x00C4C4C4),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text('Or sign in with'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: 3,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                      colors: [
                                        Color(0x00C4C4C4),
                                        constants.babyBlue,
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: constants.lightGrey,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  MdiIcons.google,
                                  color: Colors.red,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: constants.lightGrey,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.facebook,
                                  color: Colors.blue,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: constants.lightGrey,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.apple,
                                  color: Colors.black,
                                  size: 32,
                                ),
                              ),
                            ],
                          )
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

class LoginFrom extends StatefulWidget {
  const LoginFrom({super.key});

  @override
  State<LoginFrom> createState() => _LoginFromState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginFromState extends State<LoginFrom> {
  bool isLoading = false;

  void login(BuildContext context) async {
    String email = emailController.text.toString();
    String password = passwordController.text.toString();
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await post(
          Uri.parse('https://mentally.duckdns.org/api/auth/login/'),
          body: {
            "username": email,
            "password": password,
          });
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        Tokens tokens = parseTokens(response.body);
        saveTokensToSharedPreferences(tokens);
        successToast('Logged In Successfully');
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Home()));
        });
      } else if (response.statusCode == 401) {
        errorToast('Invalid Credentials');
      } else {
        errorToast('Something went wrong. Please try again later');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: constants.txtGrey),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: constants.babyBlue70),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              hintText: 'Email Address',
              suffixIcon: Icon(Icons.email_outlined),
              hintStyle: TextStyle(color: constants.txtGrey),
              suffixIconColor: constants.txtGrey,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 60,
          child: TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: constants.txtGrey),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: constants.babyBlue70),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              hintText: 'Password',
              suffixIcon: Icon(Icons.lock),
              hintStyle: TextStyle(color: constants.txtGrey),
              suffixIconColor: constants.txtGrey,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Forgot()));
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: constants.babyBlue, fontSize: 12),
                )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ElevatedButton(
            onPressed: () {
              login(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: constants.babyBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 72.0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
            ),
            child: isLoading
                ? LoadingAnimationWidget.prograssiveDots(
                    color: Colors.white, size: 16)
                : const Text(
                    "Let's Begin",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
          ),
        )
      ],
    );
  }
}
