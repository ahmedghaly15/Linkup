import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/people_who_liked/domain/usecases/people_who_liked.dart';

part 'people_who_liked_state.dart';

class PeopleWhoLikedCubit extends Cubit<PeopleWhoLikedState> {
  final PeopleWhoLikedUseCase peopleWhoLikedUseCase;

  PeopleWhoLikedCubit({
    required this.peopleWhoLikedUseCase,
  }) : super(const PeopleWhoLikedInitial());

  final List<UserModel> peopleWhoLiked = <UserModel>[];

  void peopleLikeThePost({required String postId}) {
    peopleWhoLikedUseCase(postId).listen((event) {
      peopleWhoLiked.clear();

      for (var element in event.docs) {
        peopleWhoLiked.add(UserModel.fromJson(element.data()['user']));
      }

      emit(GetPeopleWhoLikedSuccess(peopleWhoLiked: peopleWhoLiked));
    }).onError((error) {
      emit(GetPeopleWhoLikedError(error: error.toString()));
    });
  }
}
