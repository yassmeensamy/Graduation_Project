import 'dart:io';
import 'package:des/Components/Toasts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart';
import 'CommuintyScreens.dart';

class EditPostPage extends StatefulWidget {
  final int postId;
  final String initialContent;
  final String? initialImageUrl;

  EditPostPage({
    required this.postId,
    required this.initialContent,
    this.initialImageUrl,
  });

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  bool _imageDeleted = false;
  late TextEditingController _postController;

  @override
  void initState() {
    super.initState();
    _postController = TextEditingController(text: widget.initialContent);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imageDeleted = false;
      });
    }
  }

  Future<void> _submitPost() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');

      var request = http.MultipartRequest(
          'POST', Uri.parse('${constants.BaseURL}/api/posts/update/'));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['content'] = _postController.text;
      request.fields['id'] = widget.postId.toString();

      if (!_imageDeleted && _image!=null) {
        request.files
            .add(await http.MultipartFile.fromPath('img', _image!.path));
      } else {
        request.files.remove('img');
      }
      var response = await request.send();

      if (response.statusCode == 200) {
        successToast('Post updated successfully');
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PostsCommunityScreen()));
      } else {
        errorToast('Failed to update post');
      }
    }
  }

  void _deleteImage() {
    setState(() {
      _image = null;
      _imageDeleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.pageColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Edit Post',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: constants.pageColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Update Your Post',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      controller: _postController,
                      maxLines: 15,
                      decoration: InputDecoration(
                        hintText: 'What\'s on your mind?',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.image),
                          onPressed: _pickImage,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                widget.initialImageUrl != null &&
                        _image == null &&
                        !_imageDeleted
                    ? Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              widget.initialImageUrl!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: _deleteImage,
                          ),
                        ],
                      )
                    : Container(),
                _image != null
                    ? Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.file(
                              _image!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: _deleteImage,
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitPost,
                  child: Text('Update'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
