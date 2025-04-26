import 'package:hive/hive.dart';
import 'package:posts/posts/domain/entites/post.dart';

class PostAdapter extends TypeAdapter<Post> {
  @override
  int get typeId => 0;

  @override
  Post read(BinaryReader reader) {
    return Post(reader.readString(), reader.readString(), reader.readString());
  }

  @override
  void write(BinaryWriter writer, Post obj) {
    writer.writeString(obj.author);
    writer.writeString(obj.title);
    writer.writeString(obj.content);
  }
}
