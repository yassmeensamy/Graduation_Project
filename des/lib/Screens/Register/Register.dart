import 'dart:async';
import 'package:des/Components/SocialAuth.dart';
import 'package:des/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../Components/Toasts.dart';
import '../../constants.dart' as constants;
import '../../tokens.dart';

class Register extends StatelessWidget {
  const Register({super.key});

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
                  Positioned(
                    top: -80,
                    left: -50,
                    child: Container(
                      width: 380.0,
                      height: 380.0,
                      decoration: const BoxDecoration(
                        color: constants.lilac70,
                        shape: BoxShape.circle,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(85.0),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 310,
                        ),
                        const Text(
                          'Hello! ',
                          style: TextStyle(fontSize: 24),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Our Journey to Well-being Starts Here.',
                            style: TextStyle(color: constants.txtGrey),
                          ),
                        ),
                        const RegisterFrom(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(color: constants.lilac),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Login Now',
                                  style: TextStyle(
                                      color: constants.lilac,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        SocialAuth('or sign up with', constants.lilac)
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

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController nameController = TextEditingController();

class RegisterFrom extends StatefulWidget {
  const RegisterFrom({super.key});

  @override
  State<RegisterFrom> createState() => _RegisterFromState();
}

class _RegisterFromState extends State<RegisterFrom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: constants.txtGrey),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: constants.lilac70),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              hintText: 'Name',
              suffixIcon: Icon(Icons.person),
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
                borderSide: BorderSide(color: constants.lilac70),
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
                borderSide: BorderSide(color: constants.lilac70),
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ElevatedButton(
            onPressed: () {
              register(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: constants.lilac,
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
        ),
      ],
    );
  }

  bool isLoading = false;

  void register(BuildContext context) async {
    String email = emailController.text.toString();
    String password = passwordController.text.toString();
    String name = nameController.text.toString();
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await post(
          Uri.parse('https://mentally.duckdns.org/api/auth/register/'),
          body: {
            "first_name": name.split(' ')[0],
            "last_name": name.split(' ')[1],
            "username": email,
            "password": password,
          });
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 201) {
        Tokens tokens = parseTokens(response.body);
        saveTokensToSharedPreferences(tokens);
        successToast('Registered Successfully');
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const MainNavigator()));
        });
      } else if (response.statusCode == 400) {
        errorToast('This Email is already used');
      } else {
        errorToast('Something went wrong. Please try again later');
      }
    } catch (e) {
      print(e);
      errorToast('Something went wrong. Please try again later');
    }
  }
}
