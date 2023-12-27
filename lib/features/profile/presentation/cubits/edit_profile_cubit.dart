import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/profile/domain/entities/update_user_params.dart';
import 'package:social_app/features/profile/domain/usecases/update_user.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UpdateUserUseCase updateUserUseCase;

  EditProfileCubit({
    required this.updateUserUseCase,
  }) : super(const EditProfileInitial());

  void updateUser({required UpdateUserParams params}) {
    emit(const UpdateUserLoading());

    updateUserUseCase(params).then((value) {
      value.fold(
        (failure) => emit(
          UpdateUserError(error: failure.failureMsg.toString()),
        ),
        (success) => emit(const UpdateUserSuccess()),
      );
    });
  }
}
