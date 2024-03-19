import 'package:des/Controllers/AuthController.dart';
import 'package:des/Providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Components/LoginTemp.dart';
import '../../Components/VerificationCodeFields.dart';
import '../../Models/user.dart';
import '../../constants.dart' as constants;

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginTemp(
        constants.lilac70, 'Verfiy Your Email', 390, Content());
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User? currentUser = userProvider.user;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const constants.VerticalPadding(340),
        const Text(
          'Verify its you.',
          style: TextStyle(fontSize: 24),
        ),
        const constants.VerticalPadding(8),
        const Text(
          'Enter the code sent to ',
          style: TextStyle(color: constants.txtGrey, fontSize: 18),
        ),
        Text(
          currentUser!.email!,
          style: const TextStyle(
              color: constants.txtGrey,
              decoration: TextDecoration.underline,
              fontSize: 18),
        ),
        const constants.VerticalPadding(8),
        const EmailFrom(),
      ],
    );
  }
}

class EmailFrom extends StatefulWidget {
  const EmailFrom({super.key});

  @override
  State<EmailFrom> createState() => _EmailFromState();
}

class _EmailFromState extends State<EmailFrom> {
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 32,
        ),
        VerificationCodeFields(controllers),
        const constants.VerticalPadding(32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Didn’t receive code ? '),
            GestureDetector(
                onTap: () {
                  callResendOTPApi();
                },
                child: const Text('Resend',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        const constants.VerticalPadding(32),
        ElevatedButton(
          onPressed: () {
            List<String> otpArray=[];
            for (var controller in controllers) {
              otpArray.add(controller.text);
            }
            String otp = otpArray.join();
            callVerifyOTPApi(context, otp);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: constants.lilac,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 72.0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
          ),
          child: const Text(
            "Submit",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const constants.VerticalPadding(16),
      ],
    );
  }
}
