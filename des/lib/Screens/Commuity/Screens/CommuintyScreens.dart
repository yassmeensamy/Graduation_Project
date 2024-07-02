import 'package:des/Components/ProfilePhoto.dart';
import 'package:des/Models/user.dart';
import 'package:des/Providers/UserProvider.dart';
import 'package:des/Screens/DepressionNotification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart' as constants;

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constants.pageColor,
        body: ListView.builder(
            itemCount: 2, // Total number of items
            itemBuilder: (context, index) {
              return PostCard();
            }));
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        //margin: EdgeInsets.only(top),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
            color: Colors.grey.withOpacity(.2),
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 12, right: 12),
          child: Column(
            children: [
              HeaderPost(createdAt: "11:30"),
              ContentPost(
                  contentpost:
                      "I'd love to hear how you manage anxiety in your life. Feel free to  your experiences or ask any questions you may have. Remember, you're not alone in this journey!,"),
              CommitsAndLikes(
                NumLikes: 21,
                NumComment: 7,
              )
            ],
          ),
        ));
  }
}

class HeaderPost extends StatelessWidget {
  final String? createdAt;

  HeaderPost({this.createdAt});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context,
        listen:
            false); // Make sure UserProvider is correctly imported and provided above in the widget tree.
    User currentUser = userProvider.user!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: getProfilePhoto(context),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                  width:
                      10), // Add some space between the profile picture and the text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${currentUser.firstName} ${currentUser.lastName}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                      height:
                          4), // Add some space between the name and createdAt
                  if (createdAt != null) // Check if createdAt is not null
                    Text(
                      '$createdAt',
                      style: GoogleFonts.comfortaa(
                          fontSize: 14,
                          color: Color(0xffB0B0B0) // Adjust color as needed
                          ),
                    ),
                ],
              ),
            ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.only(right: 4),
                minimumSize: Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink wrap
                visualDensity:
                    VisualDensity.compact, // Make the button more compact
              ),
              onPressed: () {
                print("delete");
                 {
                  CustomAlertDialog(
                    context: context,
                    title: 'do you Want to Delete this post',
                    message:
                        "We've noticed that you've been tracking your mood with us for the past 15 days. Based on the information you've shared, it might be helpful to take a quick depression test to better understand your mental health. This can provide valuable insights and help us offer you the best support possible.",
                  ).show();
                }
              },
              child: Text(
                "delete",
                style: GoogleFonts.abhayaLibre(
                  fontSize: 18,
                  color: Color(0xffFC4C4C),
                ),
              ),
            ),
            Container(
              width: 2,
              height: 20,
              color: Color(0xff100F11).withOpacity(.2),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.only(left: 4), // Remove default padding
                minimumSize: Size(0, 0), // Minimum size to zero
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink wrap
                visualDensity:
                    VisualDensity.compact, // Make the button more compact
              ),
              onPressed: () {},
              child: Text(
                "Edit",
                style: GoogleFonts.abhayaLibre(
                  fontSize: 18,
                  color: Color(0xff8B4CFC),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ContentPost extends StatelessWidget {
  String contentpost;
  ContentPost({required this.contentpost});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(contentpost,
          textAlign: TextAlign.center,
          style: GoogleFonts.abhayaLibre(
            fontSize: 22,
          )),
    );
  }
}

class CommitsAndLikes extends StatelessWidget {
  int NumLikes;
  int NumComment;
  CommitsAndLikes({required this.NumComment, required this.NumLikes});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.black,
                )),
            Text(
              NumLikes.toString(),
              style: GoogleFonts.comfortaa(color: Color(0xffB0B0B0)),
            )
          ],
        ),
        Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
            Text(
              NumComment.toString(),
              style: GoogleFonts.comfortaa(color: Color(0xffB0B0B0)),
            )
          ],
        )
      ],
    );
  }
}
