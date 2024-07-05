import 'dart:convert';

import 'package:des/Components/AuthButton.dart';
import 'package:des/Components/FormFields/PasswordField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Components/Toasts.dart';
import '../../constants.dart' as constants;
import '../../constants.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool isLoading = false;
  String error = '';

  void _toggleOldPasswordVisibility() {
    setState(() {
      _obscureOldPassword = !_obscureOldPassword;
    });
  }

  void _toggleNewPasswordVisibility() {
    setState(() {
      _obscureNewPassword = !_obscureNewPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.pageColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: constants.pageColor,
        title: Text(
          'Change Password',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPasswordField(
                    controller: _oldPasswordController,
                    labelText: 'Old Password',
                    obscureText: _obscureOldPassword,
                    toggleVisibility: _toggleOldPasswordVisibility,
                  ),
                  SizedBox(height: 16),
                  _buildPasswordField(
                    controller: _newPasswordController,
                    labelText: 'New Password',
                    obscureText: _obscureNewPassword,
                    toggleVisibility: _toggleNewPasswordVisibility,
                  ),
                  SizedBox(height: 16),
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirm New Password',
                    obscureText: _obscureConfirmPassword,
                    toggleVisibility: _toggleConfirmPasswordVisibility,
                  ),
                  Text(
                    error,
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  )
                ],
              ),
              Spacer(
                flex: 10,
              ),
              AuthButton(
                  isLoading: isLoading,
                  onPressed: _changePassword,
                  txt: 'Change Password',
                  color: babyBlue80),
              Spacer(
                flex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    required bool obscureText,
    required VoidCallback toggleVisibility,
  }) {
    return PasswordField(
      controller,
      obscureText: obscureText,
      labelText: labelText,
      toggleVisibility: toggleVisibility,
    );
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_newPasswordController.text != _confirmPasswordController.text) {
        setState(() {
          error = 'Passwords don\'t match';
        });
        return;
      }

      try {
        setState(() {
          isLoading = true;
          error = '';
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? accessToken = prefs.getString('accessToken');
        Response response = await post(
            Uri.parse('${constants.BaseURL}/api/auth/change-password/'),
            body: {
              "old_password": _oldPasswordController.text,
              "new_password": _newPasswordController.text,
            },
            headers: {
              'Authorization': "Bearer $accessToken"
            });
        if (response.statusCode == 200) {
          successToast(jsonDecode(response.body)['message']);
          Navigator.of(context).pop();
        } else if (response.statusCode == 400) {
          errorToast(jsonDecode(response.body)['old_password'][0].toString());
        } else {
          errorToast('Something went wrong. Please try again later');
        }
      } catch (e) {
        errorToast('Something went wrong. Please try again later');
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}
