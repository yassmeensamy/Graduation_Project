import 'dart:async';
import 'dart:convert';

import 'package:des/Components/ProfilePhoto.dart';
import 'package:des/Components/loader.dart';
import 'package:des/Screens/Profile/ProfileEdit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants.dart' as constants;
import 'package:provider/provider.dart';
import '../../Models/user.dart';
import '../../Providers/UserProvider.dart';
import '../../main.dart';

String capitalize(String s) {
  if (s.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}

String capitalizeEachWord(String s) {
  return s.split(' ').map(capitalize).join(' ');
}
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    await fetchUserProfile(context);
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    User? currentUser = userProvider.user;

    return Scaffold(
      backgroundColor: constants.pageColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: constants.pageColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainNavigator()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: constants.babyBlue80),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileEdit()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _isLoading
            ? Loader()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: getProfilePhoto(context),
                    ),
                    SizedBox(height: 16),
                    Text(
                      capitalizeEachWord(
                          '${currentUser?.firstName ?? ''} ${currentUser?.lastName ?? ''}'),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${currentUser?.email}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Gender: ${currentUser?.gender  == 'M'? 'Male' : 'Female'}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Birthdate: ${currentUser?.dob ?? 'Not specified'}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Handle change password
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Change Password',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> fetchUserProfile(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    Response response = await get(
      Uri.parse('${constants.BaseURL}/api/auth/user/'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    Map userData = jsonDecode(response.body);

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User? user = userProvider.user;

    user!.firstName = userData['first_name'];
    user.lastName = userData['last_name'];
    user.gender = userData['gender'];
    user.dob = userData['birthdate'];
    user.email = userData['email'];
    user.isEmailVerified = userData['is_verified'];
    user.image = userData['image'];
    userProvider.setUser(user);
  }
}
