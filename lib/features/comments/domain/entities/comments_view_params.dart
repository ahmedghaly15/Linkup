import 'package:equatable/equatable.dart';

class CommentsViewParams extends Equatable {
  final String? postId;
  final String? postUserId;

  const CommentsViewParams({
    required this.postId,
    required this.postUserId,
  });

  @override
  List<Object?> get props => [postId, postUserId];
}
