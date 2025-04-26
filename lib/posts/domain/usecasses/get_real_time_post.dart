import 'package:posts/posts/domain/entites/post.dart';
import 'package:posts/posts/domain/repositories/post_repository.dart';

class GetRealTimeUpdatesUsecase {
  final PostRepository repository;

  GetRealTimeUpdatesUsecase(this.repository);

 Stream<List<Post>> call()  {
    return repository.getRealUpdates();
  }
}
