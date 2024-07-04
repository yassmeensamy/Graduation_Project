/*
class CommentModel {
  int id;
  String content;
  String? userName;
  DateTime timeComment;

  CommentModel
  ({
    required this.id,
    required this.content,
     this.userName,
    required this.timeComment,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as int,
      content: json['content'] as String,
      //userName: json['userName'] as String,
      timeComment: DateTime.parse(json['created_at'] as String),
    );
  }
}
*/
