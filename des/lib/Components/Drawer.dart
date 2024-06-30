import 'package:des/Screens/Profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/user.dart';
import '../Providers/UserProvider.dart';
import '../constants.dart' as constants;
import 'package:des/Controllers/AuthController.dart';

import 'ProfilePhoto.dart';

class myDrawer extends StatelessWidget {
  const myDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User? currentUser = userProvider.user;
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: constants.pageColor,
            ),
            accountName: Text(
              '${currentUser?.firstName ?? ''} ${currentUser?.lastName ?? ''}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            accountEmail: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (Profile())),
                );
              },
              child: Text(
                'view profile →',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: getProfilePhoto(context),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.notifications,
              size: 24.0,
              color: Colors.black,
            ),
            title: Text('Notifications'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 24.0,
              color: Colors.black,
            ),
            title: Text('Prefernces'),
            onTap: () {},
          ),
          Spacer(),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 24.0,
              color: Colors.black,
            ),
            title: Text('Logout'),
            onTap: () async {
              logout(context);
            },
          ),
        ],
      ),
    );
  }
}
