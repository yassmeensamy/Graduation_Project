import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Tokens {
  final String accessToken;
  final String refreshToken;

  Tokens(this.accessToken, this.refreshToken);
}

Tokens parseTokens(String responseBody) {
  final Map<String, dynamic> parsed = jsonDecode(responseBody);
  final String accessToken = parsed['access'];
  final String refreshToken = parsed['refresh'];
  return Tokens(accessToken, refreshToken);
}

void saveTokensToSharedPreferences(Tokens tokens) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('accessToken', tokens.accessToken);
  await prefs.setString('refreshToken', tokens.refreshToken);
}
