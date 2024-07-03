import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageProfile extends StatefulWidget 
{
  
  ImageProfile();
  @override
  _ImageProfileState createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> 
{
  XFile? imageFile;
  @override
  void initState() 
  {
    super.initState();
  }

  Future<void> updateImageFile(XFile? newImage) async 
  {
    setState(() {
      imageFile = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      CustomBottomSheet(updateImageFile: updateImageFile),
                );
              },
              icon: Icon(Icons.camera_alt),
              color: Colors.black,
              iconSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  final Function(XFile?) updateImageFile;

  CustomBottomSheet({Key? key, required this.updateImageFile})
      : super(key: key);

  void takePhoto(ImageSource source) async 
  {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        updateImageFile(
            pickedFile); // Ensure this is called only if pickedFile is not null
      }
    } catch (e) {
      // Consider handling errors or logging them as needed
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text(
              "Choose Profile Photo",
              style: TextStyle(fontSize: 17),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text("Camera"),
                    leading: Icon(Icons.camera),
                    onTap: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                      takePhoto(ImageSource.camera);
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text("Gallery"),
                    leading: Icon(Icons.photo_library),
                    onTap: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                      takePhoto(ImageSource.gallery);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

