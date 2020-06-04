library chats_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:instagram_app/src/models/chats/chat.dart';
import 'package:instagram_app/src/models/chats/message.dart';
import 'package:instagram_app/src/models/serializers.dart';

part 'chats_state.g.dart';

abstract class ChatsState implements Built<ChatsState, ChatsStateBuilder> {
  factory ChatsState([void Function(ChatsStateBuilder b) updates]) = _$ChatsState;

  factory ChatsState.fromJson(Map<dynamic, dynamic> json) => serializers.deserializeWith(serializer, json);

  ChatsState._();

  BuiltMap<String, Chat> get chats;

  BuiltMap<String, Message> get messages;

  @nullable
  String get selectedChatId;

  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<ChatsState> get serializer => _$chatsStateSerializer;
}
