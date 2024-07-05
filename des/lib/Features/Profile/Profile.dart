import 'dart:async';
import 'dart:convert';

import 'package:des/Components/ProfilePhoto.dart';
import 'package:des/Components/loader.dart';
import 'package:des/Features/Profile/ProfileEdit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants.dart' as constants;
import 'package:provider/provider.dart';
import '../../Models/user.dart';
import '../../Providers/UserProvider.dart';
import '../../main.dart';
import 'changePassword.dart';

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
      body: _isLoading
          ? Center(child: Loader())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: getProfilePhoto(context),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${currentUser?.firstName ?? ''} ${currentUser?.lastName ?? ''}',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${currentUser?.email}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text('Gender'),
                      subtitle: Text('${currentUser?.gender == 'M' ? 'Male' : 'Female'}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.cake_outlined),
                      title: Text('Birthdate'),
                      subtitle: Text('${currentUser?.dob ?? 'Not specified'}'),
                    ),
                    SizedBox(height: 100),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePassword()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      
                      child: Text(
                        'Change Password',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 30),
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

    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
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
