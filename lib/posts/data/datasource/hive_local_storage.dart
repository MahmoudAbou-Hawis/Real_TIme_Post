import 'package:posts/core/error/exceptions.dart';
import 'package:posts/posts/data/datasource/interfaces/abstractinternalstorage.dart';
import 'package:posts/posts/data/models/post_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:posts/posts/domain/entites/post.dart';

class HiveLocalStorage implements Abstractinternalstorage {
  final Box<Post> _box;

  HiveLocalStorage(this._box);

  @override
  Future<void> cashPosts(List<PostModel> postModels) async {
    for (final post in postModels) {
      await _box.put(post.hashCode.toString(), post);
    }
  }

  @override
  List<Post> getCashedPost() {
    List<Post> cashedPosts = _box.values.toList();
    if (!cashedPosts.isEmpty) {
      return cashedPosts;
    } else {
      throw EmptyCacheException();
    }
  }
}
