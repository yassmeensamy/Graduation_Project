import 'package:des/Components/CachedNetworl.dart';
import 'package:des/Components/ProfilePhoto.dart';
import 'package:des/Screens/Commuity/Models/Post.dart';
import 'package:des/Screens/Commuity/Screens/CommentsScreen.dart';
import 'package:des/Screens/Commuity/Screens/NewpostScreen.dart';
import 'package:des/Screens/Commuity/cubit/posts_commuity_cubit.dart';
import 'package:des/Screens/Commuity/cubit/posts_commuity_state.dart';
import 'package:des/Components/CustomAlertDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart' as constants;
import 'EditPostScreen.dart';

class PostsCommunityScreen extends StatelessWidget {
  Future<void> _refresh(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    print("refresh is here");
    context.read<PostsCommunityCubit>().getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCommunityCubit()..getAllPosts(),
      child: BlocBuilder<PostsCommunityCubit, PostsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: constants.pageColor,
            body: Padding(
              padding: EdgeInsets.only(top: 0, left: 10, right: 10),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  CreatePost(),
                  if (state.postsState == RequestState.loading)
                    Center(child: CircularProgressIndicator()),
                  if (state.postsState == RequestState.error)
                    Container(
                      color: Colors.red,
                      child: Center(child: Text('Error loading posts')),
                    ),
                  if (state.postsState == RequestState.loaded)
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => _refresh(context),
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                           shrinkWrap: true,
                          primary: false,
                          itemCount:
                              state.posts!.length, // Total number of items
                          itemBuilder: (context, index) {
                            return PostCard(
                                post: state.posts![index],
                                postcontext: context);
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  PostModel post;
  BuildContext postcontext;
  PostCard({required this.post, required this.postcontext});
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
          padding: const EdgeInsets.only(top: 20.0, left: 12, right: 12),
          child: Column(
            children: [
              HeaderPost(post),
              ContentPost(
                post: post,
              ),
              CommitsAndLikes(
                post: post,
                postcontext: postcontext,
              )
            ],
          ),
        ));
  }
}

class HeaderPost extends StatelessWidget {
  PostModel post;

  HeaderPost(this.post);

  @override
  Widget build(BuildContext context) {
   
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          
            children: [
              Container(
                width: 40,
                height: 40,
                child:CachedImage(imageUrl: context.read<PostsCommunityCubit>().getImage(post.user),),
                ),

             ],
        ),
              
         
              
              SizedBox(width: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${post.user.firstName} ${post.user.lastName}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    post.postDate,
                    style: GoogleFonts.comfortaa(
                        fontSize: 14, color: Color(0xffB0B0B0)),
                  ),
                ],
              ),
              SizedBox(
                width: 70,
              ),
              post.is_created!
              ? Update_delete(post.id, post.content, post.img)
                  : SizedBox.shrink()
            ]);
    

  
        
    

  }
}

class ContentPost extends StatelessWidget {
  PostModel post;
  ContentPost({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(post.content,
              
                softWrap: true,
                style: GoogleFonts.abhayaLibre(

                  fontSize: 22,    
                )),
            post.img==null?SizedBox.shrink(): CachedImage(imageUrl: post.img!,)  
          ]


        ));
  }
}

class CommitsAndLikes extends StatefulWidget {
  final PostModel post;
  final BuildContext postcontext;

  CommitsAndLikes({required this.post, required this.postcontext});

  @override
  _CommitsAndLikesState createState() => _CommitsAndLikesState();
}

class _CommitsAndLikesState extends State<CommitsAndLikes> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () 
              {
                context.read<PostsCommunityCubit>().likePost(widget.post.id);
                setState(()
                 {
                  if(widget.post.is_liked ==true)
                  widget.post.likesnums=widget.post.likesnums!-1;
                  else
                  {
                    widget.post.likesnums = widget.post.likesnums!+1;
                  }
                   widget.post.is_liked = !widget.post.is_liked!;
                });
              },
              icon: Icon(

                 widget.post.is_liked!  ? Icons.favorite : Icons.favorite_border_outlined,
                color: widget.post.is_liked! ? Colors.red : Colors.black,

              ),
            ),
            Text(
              widget.post.likesnums.toString(),
              style: GoogleFonts.comfortaa(color: Color(0xffB0B0B0)),
            )
          ],
        ),
        SizedBox(width: 16), // Adjust spacing between sections if needed
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(slideBottomRoute(
                  page: CommentsScreen(
                    Post_id: widget.post.id,
                    postcontext: widget.postcontext,
                  ),
                ));
              },
              icon: Icon(Icons.comment),
            ),
            Text(
              widget.post.Commentnums.toString(),
              style: GoogleFonts.comfortaa(color: Color(0xffB0B0B0)),
            )
          ],
        )
      ],
    );
  }
}


class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreatePostPage()));
      },
      child: Row(
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
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(child: Text("Share your postivity today!")),
            ),
          )
        ],
      ),
    );
  }
}

class Update_delete extends StatelessWidget {
  int Post_id;
  final String initialContent;
  final String? initialImageUrl;
  Update_delete(this.Post_id, this.initialContent, this.initialImageUrl);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.only(right: 4),
            minimumSize: Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          onPressed: () {
            print("delete");
            {
              CustomAlertDialog(
                  context: context,
                  title: 'Do you Want to Delete this Post',
                  message:
                      "Are You Sure that you want to delete this post? This action cannot be undone.",
                  actionText: 'Delete',
                  icon: Icons.delete,
                  onPressed: () async {
                    context.read<PostsCommunityCubit>().DeletePost(Post_id);
                    Navigator.pop(context);
                   
                    print("delete");
                  }).show();
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
            padding: EdgeInsets.only(left: 4),
            minimumSize: Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditPostPage(
                postId: Post_id,
                initialContent: initialContent,
                initialImageUrl: initialImageUrl,
              ),
            ));
          },
          child: Text(
            "Edit",
            style: GoogleFonts.abhayaLibre(
              fontSize: 18,
              color: Color(0xff8B4CFC),
            ),
          ),
        ),
      ],
    );
  }
}



PageRouteBuilder slideBottomRoute({required Widget page}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

