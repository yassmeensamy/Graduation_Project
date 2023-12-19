import 'dart:async';
import 'package:des/main.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../constants.dart' as constants;
import '../tokens.dart';
import 'Toasts.dart';

class SocialAuth extends StatelessWidget {
  String? txt;
  Color? color;
  SocialAuth(String t, Color c, {super.key}) {
    txt = t;
    color = c;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 4,
              height: 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    color!,
                    const Color(0x00C4C4C4),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(txt!),
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
          SocialIcon(
              Icon(
                MdiIcons.google,
                color: Colors.red,
                size: 32,
              ),
              googleAuth),
          const SizedBox(
            width: 25,
          ),
          SocialIcon(
              const Icon(
                Icons.facebook,
                color: Colors.blue,
                size: 32,
              ),
              googleAuth),
          const SizedBox(
            width: 25,
          ),
          SocialIcon(
              const Icon(
                Icons.apple,
                color: Colors.black,
                size: 32,
              ),
              googleAuth),
        ],
      )
    ]);
  }
}

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
    print(accessToken);
    user.photoUrl;
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

class SocialIcon extends StatelessWidget {
  Icon? icon;
  Function? func;

  SocialIcon(Icon i, Function fn, {super.key}) {
    icon = i;
    func = fn;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        func!(context);
      },
      child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
              color: constants.lightGrey, shape: BoxShape.circle),
          child: icon),
    );
  }
}
