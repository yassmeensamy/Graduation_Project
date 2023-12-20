import 'dart:async';
import 'package:des/Components/Toasts.dart';
import 'package:des/Tokens.dart';
import 'package:des/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

Future<int> callLoginApi(BuildContext context, String email, String password) async {
  try {
    Response response = await post(
        Uri.parse('https://mentally.duckdns.org/api/auth/login/'),
        body: {
          "username": email,
          "password": password,
        });

    if (response.statusCode == 200) {
      Tokens tokens = parseTokens(response.body);
      saveTokensToSharedPreferences(tokens);
      successToast('Logged In Successfully');
      Timer(const Duration(seconds: 2), () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const MainNavigator()));
      });
    } else if (response.statusCode == 401) {
      errorToast('Invalid Credentials');
    } else {
      errorToast('Something went wrong. Please try again later');
    }
  } catch (e) {
    print(e);
    errorToast('Something went wrong. Please try again later');
  }
  return 100;
}