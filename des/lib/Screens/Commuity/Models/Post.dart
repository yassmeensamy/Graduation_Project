class PostModel {
  int id;
  String content;
  String? img;
  String postDate;
  int Commentnums;
  int likesnums;
  PostModel({
    required this.id,
    required this.content,
    required this.img,
    required this.postDate,
    required this.Commentnums,
    required this.likesnums,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ,
      content: json['content'] ,
      img: json['img'],
      postDate: json['created_at'] ,
      Commentnums: json['comment_count'],
      likesnums: json['like_count'],
    );
  }
}
