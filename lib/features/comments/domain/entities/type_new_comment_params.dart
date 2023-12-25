import 'package:equatable/equatable.dart';
import 'package:social_app/features/comments/data/models/comment_model.dart';

class TypeNewCommentParams extends Equatable {
  final CommentModel? comment;
  final String? commentText;
  final String? postId;
  final String? time;
  final String? date;
  final Map<String, dynamic>? commentImage;

  const TypeNewCommentParams({
    this.comment,
    this.postId,
    this.commentText,
    this.commentImage,
    this.date,
    this.time,
  });

  @override
  List<Object?> get props => [
        comment,
        postId,
        commentText,
        commentImage,
        time,
        date,
      ];
}
