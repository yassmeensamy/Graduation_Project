import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controllers/AuthController.dart';
import '../Models/user.dart';
import '../Providers/UserProvider.dart';
import '../Screens/Profile/Profile.dart';
import '../constants.dart' as constants;
import 'ProfilePhoto.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User? currentUser = userProvider.user;
    return Drawer(
      child: Container(
        color: constants.pageColor, // Set your desired background color
        child: ListView(
          padding: EdgeInsets.zero,
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
                    MaterialPageRoute(builder: (context) => Profile()),
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
              title: Text('Preferences'),
              onTap: () {},
            ),
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
      ),
    );
  }
}
