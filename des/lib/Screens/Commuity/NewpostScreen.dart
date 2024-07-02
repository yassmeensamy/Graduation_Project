import 'package:des/Components/NextButton.dart';
import 'package:des/Components/ProfilePhoto.dart';
import 'package:des/Models/user.dart';
import 'package:des/Providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/constants.dart' as constants;
import 'Screens/CommuintyScreens.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController newPostContent = TextEditingController();
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User currentUser = userProvider.user!;

    return Scaffold(
      backgroundColor:
          constants.pageColor, // Assuming constants.pageColor is defined
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Create Post",
          style: GoogleFonts.nunitoSans(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle post action
            },
            child: Text(
              "Post",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              HeaderPost(), // Ensure HeaderPost widget is correctly implemented
              SizedBox(height: 30),
              NewPostContainer(NewPostContent: newPostContent),
              SizedBox(height: 60),
              NextButton(
                ontap: () {
                  // Handle next button action
                },
                groundColor:
                    constants.mint, // Assuming constants.mint is defined
                text: "Post",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class NewPostContainer extends StatelessWidget {
  TextEditingController NewPostContent;
  NewPostContainer({required this.NewPostContent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10 ),
      child: Stack(
        children: [
          SizedBox(
            //width: 330,
            child: TextField(
              controller: NewPostContent,
              maxLines: 17,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17),
                  borderSide:
                      const BorderSide(color: Color.fromARGB(255, 18, 26, 170)),
                ),
                hintText: 'Share your postivity today',
                hintStyle: GoogleFonts.lato(
                  textStyle: TextStyle(fontSize: 18, letterSpacing: .5),
                ),
              ),
             
            ),
          ),
          
              
            
        ],
      ),
    );
  }
}
