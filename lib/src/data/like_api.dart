import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_app/src/models/likes/like.dart';
import 'package:instagram_app/src/models/likes/like_type.dart';
import 'package:meta/meta.dart';

class LikeApi {
  const LikeApi({@required Firestore firestore})
      : assert(firestore != null),
        _firestore = firestore;

  final Firestore _firestore;

  Future<Like> create({
    @required String uid,
    @required String parentId,
    @required LikeType type,
  }) async {
    //Create like Object.
    final DocumentReference documentReference =
        _firestore.collection('likes').document();
    final Like like = Like(
      id: documentReference.documentID,
      parentId: parentId,
      uid: uid,
      type: type,
    );

    //Save the like object.
    await documentReference.setData(like.json);

    //Update like count.
    String parent;
    if (type == LikeType.comment) {
      parent = 'comments';
    } else if (type == LikeType.post) {
      parent = 'posts';
    } else {
      throw ArgumentError('This parent does not exists.');
    }
    final DocumentReference parentRef =
        _firestore.document('$parent/$parentId');
    await parentRef
        .updateData(<String, dynamic>{'likes': FieldValue.increment(1)});
  }
}
