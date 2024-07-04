import 'package:des/Components/CachedNetworl.dart';
import 'package:des/Components/ProfilePhoto.dart';
import 'package:des/Screens/Commuity/Models/CommentModel.dart';
import 'package:des/Screens/Commuity/Models/Post.dart';
import 'package:des/Screens/Commuity/cubit/comments_cubit.dart';
import 'package:des/Screens/Commuity/cubit/posts_commuity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart' as constants;

class CommentsScreen extends StatelessWidget {
  int Post_id;
  BuildContext postcontext;
  CommentsScreen({required this.Post_id, required this.postcontext});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentsCubit()..GetAllcomments(Post_id),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () async {
              await postcontext.read<PostsCommunityCubit>().getAllPosts();

              Navigator.pop(context);
            },
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Comments",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: constants.pageColor,
        body: BlocBuilder<CommentsCubit, CommentsState>(
            builder: (context, state) {
          if (state is CommentsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Commentserror) {
            return Container(
              color: Colors.red,
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    shrinkWrap: true,
                    itemCount: context.read<CommentsCubit>().comments.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CommentCard(
                          commentModel:
                              context.read<CommentsCubit>().comments[index],
                          postcontext: postcontext);
                    },
                  ),
                ),
                CreateComment(
                  Post_id: Post_id,
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  PostModel commentModel;
  BuildContext postcontext;
  CommentCard({required this.commentModel, required this.postcontext});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10, right: 20),
        child: Row(children: [
          Container(
            width: 40,
            height: 40,
            child: CachedImage(
              imageUrl: postcontext
                  .read<PostsCommunityCubit>()
                  .getImage(commentModel.user),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.withOpacity(.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${commentModel.user.firstName} ${commentModel.user.lastName}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    commentModel.content,
                    softWrap: true,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}

class CreateComment extends StatelessWidget {
  int Post_id;
  TextEditingController createCommentController = TextEditingController();
  CreateComment({required this.Post_id});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: createCommentController,
              decoration: const InputDecoration(
                hintText: 'Write Comment',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              context
                  .read<CommentsCubit>()
                  .CreateComment(Post_id, createCommentController.text);
            },
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
