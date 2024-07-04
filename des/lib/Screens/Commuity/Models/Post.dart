import 'package:des/Models/user.dart';

class PostModel {
  int id;
  String content;
  String? img;
  String postDate;
  int Commentnums;
  int likesnums;
  bool is_liked;
  bool is_created;
  
 
  PostModel({
    required this.id,
    required this.content,
    required this.img,
    required this.postDate,
    required this.Commentnums,
    required this.likesnums,
    required this.is_liked,
    required this.is_created,
  
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ,
      content: json['content'] ,
      img: json['img'],
      postDate: json['created_at'] ,
      Commentnums: json['comment_count'],
      likesnums: json['like_count'],
      is_liked:json["is_liked"],
      is_created:json["created_by_current_user"],
    );
  }
}
