import 'dart:async';
import 'package:des/Components/Toasts.dart';
import 'package:des/Tokens.dart';
import 'package:des/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

Future<int> callLoginApi(
    BuildContext context, String email, String password) async {
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
    errorToast('Something went wrong. Please try again later');
  }
  return 100;
}

Future<int> callRegisterApi(
    BuildContext context, String name, String email, String password) async {
  try {
    Response response = await post(
        Uri.parse('https://mentally.duckdns.org/api/auth/register/'),
        body: {
          "first_name": name.split(' ')[0],
          "last_name": name.split(' ')[1],
          "username": email,
          "password": password,
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
    errorToast('Something went wrong. Please try again later');
  }

  return 100;
}
