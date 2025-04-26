import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts/posts/presentation/widget/loadingWidget.dart';
import 'package:posts/posts/presentation/widget/msg_display_widget.dart';
import 'package:posts/posts/presentation/widget/post_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppbar(), body: _buildBody());
  }

  AppBar _buildAppbar() => AppBar(title: Text('Posts'));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocConsumer<PostsBloc, PostsState>(
        listener: (context, state) {
          if (state is LoadedPostsState) {
            context.read<PostsBloc>().add(MakePostsWakeUp());
          }
        },
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return LoadingWidget();
          } else if (state is UpdatedPostsState) {
            return PostListWidget(posts: state.posts);
          } else if (state is LoadedPostsState) {
            return PostListWidget(posts: state.posts);
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(message: state.message);
          }
          return LoadingWidget();
        },
      ),
    );
  }
}
