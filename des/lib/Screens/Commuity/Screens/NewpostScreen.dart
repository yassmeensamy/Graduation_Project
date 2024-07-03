import 'dart:io';
import 'package:des/Components/NextButton.dart';
import 'package:des/Models/user.dart';
import 'package:des/Providers/UserProvider.dart';
import 'package:des/Screens/Commuity/cubit/commuity_cubit_cubit.dart';
import 'package:des/Screens/Commuity/cubit/cubit/picked_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/constants.dart' as constants;
import 'CommuintyScreens.dart';
import 'dart:io';
class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController newPostContent = TextEditingController();
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User currentUser = userProvider.user!;

    return BlocProvider<PickedImageCubit>(
      create: (context) => PickedImageCubit(),
      child:
       Scaffold(
        backgroundColor: constants.pageColor,
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
                context.read<CommuityCubitCubit>().CreateNewPost(
                      newPostContent.text,
                      context.read<PickedImageCubit>().image!,
                    );
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
                HeaderPost(),
                SizedBox(height: 30),
                NewPostContainer(newPostContent: newPostContent),
                SizedBox(height: 60),
                NextButton(
                  ontap: () {
                    // Handle next button action
                  },
                  groundColor: constants.mint,
                  text: "Post",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewPostContainer extends StatelessWidget {
  final TextEditingController newPostContent;

  NewPostContainer({required this.newPostContent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          TextField(
            controller: newPostContent,
            maxLines: 20,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              hintText: 'Share your positivity today',
              hintStyle: GoogleFonts.lato(
                textStyle: const TextStyle(fontSize: 18, letterSpacing: .5),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              onPressed: () {
                context.read<PickedImageCubit>().getImageFromGallery();
              },
              icon: Icon(Icons.photo),
            ),
          ),
          BlocBuilder<PickedImageCubit, PickedImageState>(
            builder: (context, state) {
              if (state is ImagePickerSuccess) {
                return Positioned(
                  bottom: 20,
                  right: 20,
                  left: 20,
                  child: Image.file(
                    File(state.image!.path),
                    height: 300,
                    width: 300,
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
