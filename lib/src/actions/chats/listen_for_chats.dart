library listen_for_chats;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/models/chats/chat.dart';

part 'listen_for_chats.g.dart';

abstract class ListenForChats //
    implements
        Built<ListenForChats, ListenForChatsBuilder>,
        AppAction //
{
  factory ListenForChats([void Function(ListenForChatsBuilder b) updates]) = _$ListenForChats;

  ListenForChats._();
}

abstract class StopListenForChats //
    implements
        Built<StopListenForChats, StopListenForChatsBuilder>,
        AppAction //
{
  factory StopListenForChats([void Function(StopListenForChatsBuilder b) updates]) = _$StopListenForChats;

  StopListenForChats._();
}

abstract class OnChatEvent //
    implements
        Built<OnChatEvent, OnChatEventBuilder>,
        AppAction //
{
  factory OnChatEvent(List<Chat> chats) {
    return _$OnChatEvent((OnChatEventBuilder b) {
      b.chats = ListBuilder<Chat>(chats);
    });
  }

  OnChatEvent._();

  BuiltList<Chat> get chats;
}

abstract class ListenForChatsError //
    implements
        Built<ListenForChatsError, ListenForChatsErrorBuilder>,
        ErrorAction //
{
  factory ListenForChatsError(Object error) {
    return _$ListenForChatsError((ListenForChatsErrorBuilder b) => b.error = error);
  }

  ListenForChatsError._();

  @override
  Object get error;
}
