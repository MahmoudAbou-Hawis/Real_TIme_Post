import 'package:posts/posts/data/models/post_model.dart';

abstract class Abstreactremoterealtimestorage {
  Future<List<PostModel>> getAllRemotePosts();
  Stream<List<PostModel>> getRealTimeUpdates();
}
