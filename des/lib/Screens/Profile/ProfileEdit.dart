import 'dart:io';
import 'package:des/Screens/Profile/Profile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants.dart' as constants;
import '../../Components/ProfilePhoto.dart';
import '../../Components/Toasts.dart';
import '../../Models/user.dart';
import '../../Providers/UserProvider.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  late String gender;
  XFile? image;
  ImageProvider? photo;
  final ImagePicker picker = ImagePicker();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _birthdateController;

  @override
  void initState() {
    super.initState();
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User? currentUser = userProvider.user;
    gender = currentUser?.gender ?? '';

    _firstNameController =
        TextEditingController(text: '${currentUser?.firstName}');
    _lastNameController =
        TextEditingController(text: '${currentUser?.lastName}');
    _emailController = TextEditingController(text: '${currentUser?.email}');
    _birthdateController = TextEditingController(text: '${currentUser?.dob}');
    setImage(context);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _birthdateController.dispose();
    super.dispose();
  }

  void setImage(BuildContext context) {
    photo = getProfilePhoto(context);
  }

  Future getImage(ImageSource media) async {
    try {
      XFile? img = await picker.pickImage(source: media);
      if (img != null) {
        setState(() {
          image = img;
        });
      }
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  void myAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text('Please choose media to select'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.image),
                      Text('From Gallery'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.camera);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.camera),
                      Text('From Camera'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User? currentUser = userProvider.user;

    Widget radio(String i, String txt, String img) {
      return GestureDetector(
        onTap: () {
          setState(() {
            gender = gender == i ? '' : i;
            currentUser!.gender = gender;
            userProvider.setUser(currentUser);
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (gender == i) ? constants.lightGrey : Colors.transparent,
          ),
          child: Column(
            children: [
              Image.asset(
                img,
                width: 125,
              ),
              Text(txt),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: constants.pageColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: constants.pageColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Profile Edit',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 210,
              width: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: (image == null)
                    ? photo != null
                        ? DecorationImage(image: photo!, fit: BoxFit.cover)
                        : null
                    : DecorationImage(
                        image: FileImage(File(image!.path)),
                        fit: BoxFit.cover,
                      ),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: myAlert,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 40, bottom: 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(Icons.edit),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            TextField(
              enabled: false,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: constants.babyBlue,
                          onPrimary: Colors.white,
                          onSurface: Colors.black,
                          onBackground: constants.lilac,
                        ),
                      ),
                      child: child!,
                    );
                  },
                  context: context,
                  initialDate: DateTime.tryParse(currentUser!.dob ?? '')?? DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate:
                      DateTime.now().subtract(const Duration(days: 18 * 365)),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    _birthdateController.text = formattedDate;
                  });
                }
              },
              controller: _birthdateController,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: constants.txtGrey),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: constants.lilac70),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                hintText: 'MM-DD-YYYY',
                suffixIcon: Icon(Icons.calendar_month),
                hintStyle: TextStyle(color: constants.txtGrey),
                suffixIconColor: constants.txtGrey,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                radio('M', 'Male', 'assets/images/male.png'),
                const SizedBox(width: 32),
                radio('F', 'Female', 'assets/images/female.png'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveProfile();
              },
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    final String firstName = _firstNameController.text.trim();
    final String lastName = _lastNameController.text.trim();
    final String birthdate = _birthdateController.text.trim();

    Map<String, String> data = {
      'first_name': firstName,
      'last_name': lastName,
      'birthdate': birthdate,
      'gender': gender,
    };

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
      } else {
        print(response.statusCode);
        errorToast('Failed to update profile');
      }
    } catch (e) {
      print(e);
      errorToast('Failed to update profile');
    }
  }
}
