import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../Models/user.dart';
import '../../../Providers/UserProvider.dart';

typedef ImageCallback = void Function(String? image);

class ImageForm extends StatefulWidget {
  final ImageCallback onImageSelected;
  const ImageForm({Key? key, required this.onImageSelected}) : super(key: key);

  @override
  State<ImageForm> createState() => _ImageFormState();
}

class _ImageFormState extends State<ImageForm> {
  XFile? image;
  ImageProvider? photo;
  final ImagePicker picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    setImage(context);
  }

  void setImage(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User currentUser = userProvider.user!;
    photo = (currentUser.gender == 'M')
        ? const AssetImage('assets/images/malePhoto.png')
        : const AssetImage('assets/images/femalePhoto.png');
  }

  Future getImage(ImageSource media) async {
    XFile? img = await picker.pickImage(source: media);
    widget.onImageSelected(img!.path);

    setState(() {
      image = img;
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 16,
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Would you like to add a photo?'),
        ],
      ),
      const SizedBox(
        height: 16,
      ),
      Container(
        height: 210,
        width: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: (image == null)
              ? DecorationImage(image: photo!, fit: BoxFit.cover)
              : DecorationImage(
                  image: FileImage(
                    File(image!.path),
                  ),
                  fit: BoxFit.cover),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () {
              myAlert();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 40, bottom: 40),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(
                Icons.edit,
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
