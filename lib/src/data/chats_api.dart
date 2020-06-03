import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_app/src/models/chats/chat.dart';
import 'package:instagram_app/src/models/chats/message.dart';
import 'package:meta/meta.dart';

class ChatsApi {
  const ChatsApi({@required Firestore firestore})
      : assert(firestore != null),
        _firestore = firestore;

  final Firestore _firestore;

  /// Create chat and add it to firestore.
  Future<Chat> createChat(List<String> users) async {
    final DocumentReference chatRef = _firestore.collection('chats').document();
    final Chat chat = Chat(id: chatRef.documentID, users: users);
    await chatRef.setData(chat.json);
    return chat;
  }

  /// Listen for chats or/and new ones.
  Stream<List<Chat>> listenForChats(String uid) {
    return _firestore
        .collection('chats')
        .where('users', arrayContains: uid)
        .snapshots()
        .map((QuerySnapshot snapshot) => snapshot.documents //
            .map((DocumentSnapshot document) => Chat.fromJson(document.data))
            .toList());
  }

  /// Create a message and add it to firestore.
  Future<Message> createMessage({
    @required String chatId,
    @required String uid,
    @required String text,
  }) async {
    final DocumentReference messagesRef = _firestore.collection('messages').document();
    final Message message = Message(
      id: messagesRef.documentID,
      chatId: chatId,
      uid: uid,
      message: text,
      createdAt: DateTime.now().toUtc(),
    );
    await messagesRef.setData(message.json);
    return message;
  }

  Stream<List<Message>> listenForMessages(String chatId) {
    return _firestore
        .collection('messages')
        .where('chatId', isEqualTo: chatId)
        .snapshots()
        .map((QuerySnapshot snapshot) => snapshot.documents //
            .map((DocumentSnapshot document) => Message.fromJson(document.data))
            .toList());
  }
}
