library message;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:instagram_app/src/models/serializers.dart';
import 'package:meta/meta.dart';

part 'message.g.dart';

abstract class Message implements Built<Message, MessageBuilder>, Comparable<Message> {
  factory Message({
    @required String id,
    @required String chatId,
    @required String uid,
    @required String message,
    @required DateTime createdAt,
  }) {
    return _$Message((MessageBuilder b) {
      b
        ..id = id
        ..chatId = chatId
        ..uid = uid
        ..message = message
        ..createdAt = createdAt;
    });
  }

  factory Message.fromJson(Map<dynamic, dynamic> json) => serializers.deserializeWith(serializer, json);

  Message._();

  String get id;

  String get chatId;

  String get uid;

  String get message;

  DateTime get createdAt;

  @override
  int compareTo(Message other) {
    return other.createdAt.compareTo(createdAt);
  }

  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<Message> get serializer => _$messageSerializer;
}
