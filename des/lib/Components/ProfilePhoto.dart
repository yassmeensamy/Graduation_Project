import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/user.dart';
import '../Providers/UserProvider.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User currentUser = userProvider.user!;
    if (currentUser.image != null) {
      return Image(
          image: MemoryImage(
        Uint8List.fromList(currentUser.image!),
      ));
    } else if (currentUser.googlePhoto != null) {
      return Image(image: NetworkImage(currentUser.googlePhoto!));
    } else {
      if (currentUser.gender == 'M') {
        return Image.asset('asset/images/malePhoto');
      } else {
        return Image.asset('asset/images/femalePhoto');
      }
    }
  }
}
