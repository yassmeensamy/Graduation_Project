import 'dart:async';
import 'package:des/main.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import '../Tokens.dart';
import '../Components/Toasts.dart';
import '../constants.dart' as constants;

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  static Future<GoogleSignInAccount?> logout() => _googleSignIn.disconnect();
}

void googleLogout() async {
  try{
    await GoogleSignInApi.logout();
  }
  catch(e)
  {
    print(e);
  }
}

void googleAuth(BuildContext context) async {
  final user = await GoogleSignInApi.login();

  if (user == null) {
    errorToast("Sign In Faild");
  } else {
    GoogleSignInAuthentication googleAuth = await user.authentication;
    String? img = user.photoUrl;
    String accessToken = googleAuth.accessToken!;
    print(accessToken);
    googleAuthApi(accessToken, context, img);
  }
}

void googleAuthApi(String token, BuildContext context, String? img) async {
  try {
    Response response = await post(
        Uri.parse('${constants.BaseURL}/api/auth/google/'),
        body: {'token': token, 'image': img});
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
    } else if (response.statusCode == 201) {
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
    } else {
      print(response.body);
      print(response.statusCode);
      errorToast('Somthing Went Wrong. Please Try Again Later.');
    }
  } catch (e) {
    print(e);
    errorToast('Somthing Went Wrong. Please Try Again Later.');
  }
}
