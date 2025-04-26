part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostsEvent extends PostsEvent {}

class MakePostsWakeUp extends PostsEvent {}

class update extends PostsEvent {
  List<Post> posts;
  update(this.posts);
}
