import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/core/error/failure.dart';
import 'package:posts/posts/domain/entites/post.dart';
import 'package:posts/posts/domain/usecasses/get_all_post.dart';
import 'package:posts/posts/domain/usecasses/get_real_time_post.dart';

part 'post_event.dart';
part 'posts_states.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetRealTimeUpdatesUsecase getRealTimeUpdatesUsecase;
  final GetAllPostUsecase getAllPostUsecase;
  StreamSubscription<List<Post>>? subscription;
  PostsBloc(this.getRealTimeUpdatesUsecase, this.getAllPostUsecase)
    : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final result = await getAllPostUsecase.call();
        emit(_mapFailureOrPostsToState(result));
      } else if (event is MakePostsWakeUp) {
        subscription?.cancel();

        final stream = getRealTimeUpdatesUsecase.call();
        subscription = stream.listen((posts) {
          add(update(posts));
        }, cancelOnError: false);
      } else if (event is update) {
        emit(UpdatedPostsState(posts: event.posts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
      (posts) => LoadedPostsState(posts: posts),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Please Try To Open The App Later, we face A problem in our servers";
      case EmptyCacheFailure:
        return "Please Reconnect To the internet";
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
