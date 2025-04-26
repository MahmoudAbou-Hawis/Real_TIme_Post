import 'package:dartz/dartz.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/core/error/failure.dart';
import 'package:posts/core/network/network_info.dart';
import 'package:posts/posts/data/datasource/interfaces/abstractinternalstorage.dart';
import 'package:posts/posts/data/datasource/interfaces/abstreactRemoteRealTimeStorage.dart';
import 'package:posts/posts/domain/entites/post.dart';
import 'package:posts/posts/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final Abstractinternalstorage localDataSource;
  final Abstreactremoterealtimestorage remoteDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(
    this.localDataSource,
    this.remoteDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final posts = await remoteDataSource.getAllRemotePosts();
        localDataSource.cashPosts(posts);
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final list = localDataSource.getCashedPost();
        return Right(list);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
 Stream<List<Post>> getRealUpdates() {
    return remoteDataSource.getRealTimeUpdates();
  }
}
