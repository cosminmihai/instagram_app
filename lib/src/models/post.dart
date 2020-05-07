library post;

import 'package:meta/meta.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:instagram_app/src/models/serializers.dart';

part 'post.g.dart';

abstract class Post implements Built<Post, PostBuilder> {
  factory Post({
    @required String id,
    @required String uid,
    @required String description,
    @required List<String> pictures,
  }) {
    return _$Post((PostBuilder b) {
      b
        ..id = id
        ..uid = uid
        ..description = description
        ..createdAt = DateTime.now().toUtc()
        ..likes = 0
        ..pictures = ListBuilder<String>(pictures);
    });
  }

  factory Post.fromJson(Map<dynamic, dynamic> json) => serializers.deserializeWith(serializer, json);

  Post._();

  String get id;

  String get uid;

  String get description;

  DateTime get createdAt;

  int get likes;

  BuiltList<String> get pictures;

  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<Post> get serializer => _$postSerializer;
}
