library set;

import 'package:built_value/built_value.dart';
import 'package:instagram_app/src/actions/actions.dart';

part 'set.g.dart';

abstract class SetSelectedPost //
    implements
        Built<SetSelectedPost, SetSelectedPostBuilder>,
        AppAction //
{
  factory SetSelectedPost(String postId) {
    return _$SetSelectedPost((SetSelectedPostBuilder b) => b.postId = postId);
  }

  SetSelectedPost._();

  String get postId;
}
