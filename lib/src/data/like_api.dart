import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_app/src/models/likes/like.dart';
import 'package:instagram_app/src/models/likes/like_type.dart';
import 'package:meta/meta.dart';

class LikeApi {
  const LikeApi({@required Firestore firestore})
      : assert(firestore != null),
        _firestore = firestore;

  final Firestore _firestore;

  Future<List<Like>> getLikes(String parentId) async {
    final QuerySnapshot snapshot = await _firestore //
        .collection('likes')
        .where('parentId', isEqualTo: parentId)
        .getDocuments();

    return snapshot //
        .documents
        .map((DocumentSnapshot snapshot) => Like.fromJson(snapshot.data))
        .toList();
  }

  Future<Like> create({
    @required String uid,
    @required String parentId,
    @required LikeType type,
  }) async {
    //Create like Object.
    final DocumentReference documentReference = _firestore.collection('likes').document();
    final Like like = Like(
      id: documentReference.documentID,
      parentId: parentId,
      uid: uid,
      type: type,
    );

    //Save the like object.
    await documentReference.setData(like.json);
    return like;
  }

  Future<void> delete(String likeId) async {
    final DocumentReference documentRef = _firestore.document('likes/${likeId}');
    await documentRef.delete();
  }
}
