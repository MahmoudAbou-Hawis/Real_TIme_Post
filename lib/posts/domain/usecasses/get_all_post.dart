import 'package:posts/core/error/failure.dart';
import 'package:posts/posts/domain/entites/post.dart';
import 'package:posts/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllPostUsecase {
  final PostRepository repository;

  GetAllPostUsecase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
