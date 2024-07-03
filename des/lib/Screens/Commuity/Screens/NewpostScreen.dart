import 'dart:io';
import 'package:des/Components/Toasts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart';

import 'CommuintyScreens.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final TextEditingController _postController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitPost() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');

      var request = http.MultipartRequest(
          'POST', Uri.parse('${constants.BaseURL}/api/posts/create/'));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['content'] = _postController.text;

      if (_image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('img', _image!.path));
      }

      var response = await request.send();

      if (response.statusCode == 201) {
        successToast('Post created successfully');
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => PostsCommunityScreen()));
      } else {
        errorToast('Failed to create post');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.pageColor,
      appBar: AppBar(
          elevation: 0,
          title: Text(
            'Create New Post',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: constants.pageColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _postController,
                decoration: InputDecoration(
                  labelText: 'Share Your Positivity Today!',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _image != null
                  ? Image.file(
                      _image!,
                      height: 200,
                    )
                  : Text('No image selected'),
              ElevatedButton(
                onPressed: _pickImage,
                child: Icon(Icons.image),
              ),
              ElevatedButton(
                onPressed: _submitPost,
                child: Text('Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
