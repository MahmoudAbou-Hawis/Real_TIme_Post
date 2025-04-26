import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts/core/network/network_info.dart';
import 'package:posts/posts/data/datasource/fire_base_storage.dart';
import 'package:posts/posts/data/datasource/hive_local_storage.dart';
import 'package:posts/posts/data/models/pos_adapter.dart';
import 'package:posts/posts/data/repositories/post_repository_impl.dart';
import 'package:posts/posts/domain/entites/post.dart';
import 'package:posts/posts/domain/usecasses/get_all_post.dart';
import 'package:posts/posts/domain/usecasses/get_real_time_post.dart';
import 'package:posts/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts/posts/presentation/pages/posts_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(); // Initialize Firebase
  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  Box<Post> box = await Hive.openBox<Post>('Posts');

  runApp(MyApp(box: box));
}

class MyApp extends StatelessWidget {
  Box<Post> box;
  MyApp({super.key, required this.box});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => PostsBloc(
            GetRealTimeUpdatesUsecase(
              PostRepositoryImpl(
                HiveLocalStorage(box),
                FireBaseStorage(),
                NetworkInfoImpl(InternetConnectionChecker()),
              ),
            ),
            GetAllPostUsecase(
              PostRepositoryImpl(
                HiveLocalStorage(box),
                FireBaseStorage(),
                NetworkInfoImpl(InternetConnectionChecker()),
              ),
            ),
          )..add(GetAllPostsEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firestore Posts',
        home: const PostsPage(),
      ),
    );
  }
}
