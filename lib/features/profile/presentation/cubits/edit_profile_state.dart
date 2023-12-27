part of 'edit_profile_cubit.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {
  const EditProfileInitial();
}

class UpdateUserLoading extends EditProfileState {
  const UpdateUserLoading();
}

class UpdateUserSuccess extends EditProfileState {
  const UpdateUserSuccess();
}

class UpdateUserError extends EditProfileState {
  final String error;

  const UpdateUserError({required this.error});

  @override
  List<Object?> get props => [error];
}
