library chat;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:instagram_app/src/models/chats/message.dart';
import 'package:instagram_app/src/models/serializers.dart';
import 'package:meta/meta.dart';

part 'chat.g.dart';

abstract class Chat implements Built<Chat, ChatBuilder> {
  factory Chat({
    @required String id,
    @required List<String> users,
    Message lastMessage,
  }){
    return _$Chat((ChatBuilder b) {
      b
        ..id = id
        ..users = ListBuilder<String>(users)
        ..lastMessage = lastMessage.toBuilder();
    });
  }

  factory Chat.fromJson(Map<dynamic, dynamic> json) => serializers.deserializeWith(serializer, json);

  Chat._();

  String get id;

  BuiltList<String> get users;

  Message get lastMessage;

  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<Chat> get serializer => _$chatSerializer;
}
