import 'dart:core';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String author;
  final String title;
  final String content;

  Post(this.author, this.title, this.content);


  @override
  List<Object?> get props => [author, title, content];
}
