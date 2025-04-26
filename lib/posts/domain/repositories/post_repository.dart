import 'package:posts/core/error/failure.dart';
import 'package:posts/posts/domain/entites/post.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Stream<List<Post>> getRealUpdates();
}
