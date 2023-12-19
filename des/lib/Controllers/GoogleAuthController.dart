import 'dart:async';
import 'package:des/main.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import '../tokens.dart';
import '../Components/Toasts.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  static Future<GoogleSignInAccount?> logout() => _googleSignIn.disconnect();
}

void googleAuth(BuildContext context) async {
  final user = await GoogleSignInApi.login();

  if (user == null) {
    errorToast("Sign In Faild");
  } else {
    GoogleSignInAuthentication googleAuth = await user.authentication;
    String accessToken = googleAuth.accessToken!;
    googleAuthApi(accessToken, context);
  }
}

void googleAuthApi(String token, BuildContext context) async {
  try {
    Response response = await post(
        Uri.parse('https://mentally.duckdns.org/api/auth/google/'),
        body: {'token': token});
    if (response.statusCode == 200) {
      Tokens tokens = parseTokens(response.body);
      saveTokensToSharedPreferences(tokens);
      successToast('Logged In Successfully');
      Timer(const Duration(seconds: 2), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const MainNavigator()));
      });
    } else if (response.statusCode == 201) {
      Tokens tokens = parseTokens(response.body);
      saveTokensToSharedPreferences(tokens);
      successToast('Registered Successfully');
      Timer(const Duration(seconds: 2), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const MainNavigator()));
      });
    } else {
      errorToast('Somthing Went Wrong. Please Try Again Later.');
    }
  } catch (e) {
    errorToast('Somthing Went Wrong. Please Try Again Later.');
  }
}
