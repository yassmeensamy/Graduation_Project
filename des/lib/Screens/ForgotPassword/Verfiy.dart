import 'dart:async';
import 'dart:convert';
import 'package:des/Components/AuthButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../Components/LoginTemp.dart';
import '../../Components/Toasts.dart';
import '../../Components/VerificationCodeFields.dart';
import '../../constants.dart' as constants;
import 'Reset.dart';

class Verfiy extends StatelessWidget {
  String email = '';

  Verfiy(this.email);

  @override
  Widget build(BuildContext context) {
    return LoginTemp(
        constants.babyBlue70, 'Forgot Password?', 390.0, Content(email));
  }
}

class Content extends StatelessWidget {
  Content(this.email);

  String email = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 340,
        ),
        Text(
          'Verify its you.',
          style: TextStyle(fontSize: 24),
        ),
        Text(
          'Enter the code sent to ',
          style: TextStyle(color: constants.txtGrey, fontSize: 18),
        ),
        Text(
          email,
          style: TextStyle(
              color: constants.txtGrey,
              decoration: TextDecoration.underline,
              fontSize: 18),
        ),
        CodeFrom(email),
      ],
    );
  }
}

class CodeFrom extends StatefulWidget {
  String email;
  CodeFrom(this.email);

  @override
  State<CodeFrom> createState() => _CodeFromState();
}

class _CodeFromState extends State<CodeFrom> {
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  bool isLoading = false;

  verifyOTP() {
    List<String> otpArray = [];
    for (var controller in controllers) {
      otpArray.add(controller.text);
    }
    String otp = otpArray.join();
    verifyResetOTP(otp, context, widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const constants.VerticalPadding(32),
        VerificationCodeFields(controllers),
        const constants.VerticalPadding(32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Didn’t receive code ? '),
            GestureDetector(
                onTap: () {
                  callResetOTPApi(widget.email, context);
                },
                child: const Text('Resend',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        const constants.VerticalPadding(32),
        AuthButton(
            isLoading: isLoading,
            onPressed: verifyOTP,
            txt: "Submit",
            color: constants.babyBlue),
      ],
    );
  }

  Future<void> verifyResetOTP(
      String otp, BuildContext context, String email) async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await post(
          Uri.parse('${constants.BaseURL}/api/auth/verify-reset-otp/'),
          body: {
            "email": email,
            "otp": otp,
          });
      if (response.statusCode == 200) {
        successToast(jsonDecode(response.body)['message']);
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Reset(email)));
        });
      } else if (response.statusCode == 400) {
        print(response.body);
        errorToast(jsonDecode(response.body)['non_field_errors'][0].toString());
      } else {
        errorToast('Something went wrong. Please try again later');
      }
    } catch (e) {
      errorToast('Something went wrong. Please try again later');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> callResetOTPApi(String email, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await post(
          Uri.parse('${constants.BaseURL}/api/auth/send-reset-otp/'),
          body: {
            "email": email,
          }); 
      if (response.statusCode == 200) {
        successToast('OTP sent Successfully');
      } else {
        errorToast('Something went wrong. Please try again later');
      }
    } catch (e) {
      errorToast('Something went wrong. Please try again later');
    }
    setState(() {
      isLoading = false;
    });
  }
}
