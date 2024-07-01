import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Components/Toasts.dart';
import '../Screens/Profile/Profile.dart';
import '../constants.dart' as constants;

void callUpdateProfileApi(BuildContext context, data, image) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    var request = http.MultipartRequest(
        'PATCH', Uri.parse('${constants.BaseURL}/api/auth/user/'));
    if (image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', (image!.path)));
    }

    request.headers['Authorization'] = 'Bearer $accessToken';
    print(accessToken);
    request.fields.addAll(data);
    print(data);

    final response = await request.send();

    if (response.statusCode == 200) {
      successToast('Profile updated successfully');
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => (Profile())),
      );
    } else if (response.statusCode == 413) {
      errorToast('The image size is very large');
    } else {
      errorToast('Failed to update profile');
    }
  } catch (e) {
    print(e);
    errorToast('Failed to update profile');
  }
}
