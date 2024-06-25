import 'dart:async';
import 'package:des/Components/Toasts.dart';
import 'package:des/Tokens.dart';
import 'package:des/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart' as constants;

Future<int> callLoginApi(
    BuildContext context, String email, String password) async {
  try {
    Response response =
        await post(Uri.parse('${constants.BaseURL}/api/auth/login/'), body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      Tokens tokens = parseTokens(response.body);
      saveTokensToSharedPreferences(tokens);
      successToast('Logged In Successfully');
      Timer(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainNavigator()),
          (Route<dynamic> route) => false,
        );
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
    Response response =
        await post(Uri.parse('${constants.BaseURL}/api/auth/register/'), body: {
      "first_name": name.split(' ')[0],
      "last_name": name.split(' ')[1],
      "email": email,
      "password": password,
    });

    if (response.statusCode == 201) {
      Tokens tokens = parseTokens(response.body);
      saveTokensToSharedPreferences(tokens);
      successToast('Registered Successfully');
      Timer(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainNavigator()),
          (Route<dynamic> route) => false,
        );
      });
    } else if (response.statusCode == 400) {
      print(response.body);
      errorToast('This Email is already used');
    } else {
      errorToast('Something went wrong. Please try again later');
    }
  } catch (e) {
    errorToast('Something went wrong. Please try again later');
  }

  return 100;
}

Future<int> callVerifyOTPApi(BuildContext context, String otp) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? accessToken = prefs.getString('accessToken');

  try {
    Response response = await post(
        Uri.parse('${constants.BaseURL}/api/auth/verify-email/'),
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
        body: {
          "otp": otp,
        });
    if (response.statusCode == 200) {
      successToast('Verified Successfully');
      Timer(const Duration(seconds: 2), () {
       Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainNavigator()),
          (Route<dynamic> route) => false,
        );
      });
    } else if (response.statusCode == 400) {
      errorToast('Invalid or expired OTP');
    } else {
      errorToast('Something went wrong. Please try again later');
    }
  } catch (e) {
    errorToast('Something went wrong. Please try again later');
  }

  return 100;
}

Future<int> callResendOTPApi() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? accessToken = prefs.getString('accessToken');

  try {
    Response response = await post(
        Uri.parse('${constants.BaseURL}/api/auth/resend-verification-otp/'),
        headers: {'Authorization': 'Bearer $accessToken'});

    if (response.statusCode == 200) {
      successToast('OTP resent to your email.');
    } else {
      errorToast('Something went wrong. Please try again later');
    }
  } catch (e) {
    errorToast('Something went wrong. Please try again later');
  }

  return 100;
}
