import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? image;
  final ImagePicker picker = ImagePicker();

  Future<void> getImageFromGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print("No image picked");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null
                ? Image.file(
                    image!,
                    width: 300,
                    height: 300,
                  )
                : Text('No image selected.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImageFromGallery,
              child: Text('Pick Image from Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
