import 'package:posts/posts/domain/entites/post.dart';

class PostModel extends Post {
  PostModel(super.author, super.title, super.content);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(json['author'], json['title'], json['description']);
  }
  Map<String, dynamic> toJson() {
    return {'author': author, 'title': title, 'content': content};
  }
}
