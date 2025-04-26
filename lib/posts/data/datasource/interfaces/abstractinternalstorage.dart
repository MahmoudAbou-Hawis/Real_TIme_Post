import 'package:posts/posts/data/models/post_model.dart';
import 'package:posts/posts/domain/entites/post.dart';

abstract class Abstractinternalstorage {
  List<Post> getCashedPost();
  Future<void> cashPosts(List<PostModel> postModels); 
}

