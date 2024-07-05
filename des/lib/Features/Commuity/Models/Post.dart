import 'package:des/Models/user.dart';

class PostModel {
  int id;
  String content;
  String? img;
  String postDate;
  int? Commentnums;
  int? likesnums;
  bool? is_liked;
  bool ?is_created;
  User user;
 
  PostModel({
    required this.id,
    required this.content,
     this.img,
       required this.postDate,
      this.Commentnums,
      this.likesnums,
      this.is_liked,
      this.is_created,
    required this.user,
  
  });

  factory PostModel.fromJson(Map<String, dynamic> json)
   {

    dynamic userdata=json["user"];
    User user=User.fromJson(userdata);
    return PostModel(
      id: json['id'] ,
      content: json['content'] ,
      img: json['img'],
      postDate: json['created_at'] ,
      Commentnums: json['comment_count'],
      likesnums: json['like_count'],
      is_liked:json["is_liked"],
      is_created:json["created_by_current_user"],
      user:user,

    );
  }
}
