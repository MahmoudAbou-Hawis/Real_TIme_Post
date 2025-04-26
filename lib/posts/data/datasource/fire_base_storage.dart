import 'package:posts/core/error/exceptions.dart';
import 'package:posts/posts/data/datasource/interfaces/abstreactRemoteRealTimeStorage.dart';
import 'package:posts/posts/data/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseStorage extends Abstreactremoterealtimestorage {
  @override
  Stream<List<PostModel>> getRealTimeUpdates() {
    return FirebaseFirestore.instance
        .collection('Post')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) =>
                        PostModel.fromJson(doc.data() as Map<String, dynamic>),
                  )
                  .toList(),
        );
  }

  @override
  Future<List<PostModel>> getAllRemotePosts() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('Post').get();
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      List<PostModel> list = [];
      for (final post in allData) {
        list.add(PostModel(post['author'], post['title'], post['description']));
      }
      return list;
    } catch (e) {
      print("Exception : ");
      print(e);
      throw ServerException();
    }
  }
}
