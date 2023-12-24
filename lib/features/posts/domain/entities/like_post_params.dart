import 'package:equatable/equatable.dart';
import 'package:social_app/features/posts/data/models/like_model.dart';

class LikePostParams extends Equatable {
  final LikeModel likesModel;
  final String postId;

  const LikePostParams({required this.likesModel, required this.postId});

  @override
  List<Object?> get props => [likesModel, postId];
}
