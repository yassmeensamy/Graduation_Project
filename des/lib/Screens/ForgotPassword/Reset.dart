import 'package:des/main.dart';
import 'package:flutter/material.dart';
import '../../Components/upperBgCircle.dart';
import '../../constants.dart' as constants;

class Reset extends StatelessWidget {
  const Reset({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: constants.pageColor,
          child: Stack(
            children: <Widget>[
              UpperBgCircle(constants.babyBlue70, 'Forgot Password?', 390.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 340,
                    ),
                    Text(
                      'Reset Your Password',
                      style: TextStyle(fontSize: 24),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Enter a new pasword',
                        style: TextStyle(color: constants.txtGrey),
                      ),
                    ),
                    LoginFrom(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginFrom extends StatefulWidget {
  const LoginFrom({super.key});

  @override
  State<LoginFrom> createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: constants.txtGrey),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: constants.babyBlue70),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              hintText: 'Password',
              suffixIcon: Icon(Icons.lock),
              hintStyle: TextStyle(color: constants.txtGrey),
              suffixIconColor: constants.txtGrey,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 60,
          child: TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: constants.txtGrey),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: constants.babyBlue70),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              hintText: 'Confirm Password',
              suffixIcon: Icon(Icons.lock),
              hintStyle: TextStyle(color: constants.txtGrey),
              suffixIconColor: constants.txtGrey,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MainNavigator()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: constants.babyBlue,
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
        )
      ],
    );
  }
}
