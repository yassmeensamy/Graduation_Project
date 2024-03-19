import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/user.dart';
import '../Providers/UserProvider.dart';

getProfilePhoto(BuildContext context)
{
  UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User currentUser = userProvider.user!;
    if (currentUser.image != null) {
      return NetworkImage(currentUser.image!);
    } else {
      if (currentUser.gender == 'M') {
        return const AssetImage('assets/images/malePhoto.png');
      } else {
        return const AssetImage('assets/images/femalePhoto.png');
      }
    }
}
