part of 'comments_cubit.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

class CommentsInitial extends CommentsState {
  const CommentsInitial();
}

class TypeNewCommentLoading extends CommentsState {
  const TypeNewCommentLoading();
}

class TypeNewCommentSuccess extends CommentsState {
  const TypeNewCommentSuccess();
}

class TypeNewCommentError extends CommentsState {
  final String error;

  const TypeNewCommentError({required this.error});

  @override
  List<Object> get props => [error];
}

class CommentImagePickedSuccess extends CommentsState {
  final File commentImage;

  const CommentImagePickedSuccess({required this.commentImage});

  @override
  List<Object> get props => [commentImage];
}

class CommentImagePickedError extends CommentsState {
  final String error;

  const CommentImagePickedError({required this.error});

  @override
  List<Object> get props => [error];
}

class UploadCommentImageLoading extends CommentsState {
  const UploadCommentImageLoading();
}

class UploadCommentImageSuccess extends CommentsState {
  final String imageUrl;

  const UploadCommentImageSuccess({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}

class UploadCommentImageError extends CommentsState {
  final String error;

  const UploadCommentImageError({required this.error});

  @override
  List<Object> get props => [error];
}

class GetCommentsSuccess extends CommentsState {
  final List<CommentModel> comments;

  const GetCommentsSuccess({required this.comments});

  @override
  List<Object> get props => [comments];
}

class GetCommentsError extends CommentsState {
  final String error;

  const GetCommentsError({required this.error});

  @override
  List<Object> get props => [error];
}

class CommentImageRemovedSuccess extends CommentsState {
  const CommentImageRemovedSuccess();
}
