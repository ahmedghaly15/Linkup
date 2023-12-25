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
