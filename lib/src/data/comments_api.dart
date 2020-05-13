import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_app/src/models/comments/comment.dart';
import 'package:meta/meta.dart';

class CommentsApi {
  const CommentsApi({@required Firestore firestore})
      : assert(firestore != null),
        _firestore = firestore;

  final Firestore _firestore;

  Future<Comment> create({@required String uid, @required String postId, @required String text}) async {
    final DocumentReference reference = _firestore.collection('comments').document();
    final Comment comment = Comment(id: reference.documentID, postId: postId, uid: uid, text: text);
    await reference.setData(comment.json);
    return comment;
  }
}
