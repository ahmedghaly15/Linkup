import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/users/domain/usecases/get_all_users.dart';
import 'package:social_app/features/users/domain/usecases/get_user_data.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserDataUseCase getUserDataUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;

  UserCubit({
    required this.getUserDataUseCase,
    required this.getAllUsersUseCase,
  }) : super(const UserInitial());

  List<UserModel> users = <UserModel>[];

  void getAllUsers() {
    emit(const GetAllUsersLoading());

    getAllUsersUseCase(const NoParams()).then((value) {
      value.fold(
        (failure) =>
            emit(GetAllUserError(error: failure.failureMsg.toString())),
        (result) {
          users.clear();
          for (var element in result.docs) {
            if (element.data()['uId'] != Helper.currentUser!.uId)
              users.add(UserModel.fromJson(element.data()));
          }
          emit(GetAllUserSuccess(users: users));
        },
      );
    });
  }

  void getUserData() {
    emit(const GetUserDataLoading());

    getUserDataUseCase(const NoParams()).then((value) {
      value.fold(
        (failure) =>
            emit(GetUserDataError(error: failure.failureMsg.toString())),
        (success) {
          Helper.currentUser = UserModel.fromJson(success.data()!);
          emit(GetUserDataSuccess(user: Helper.currentUser!));
        },
      );
    });
  }

  List<UserModel> searchList = <UserModel>[];
  bool isSearching = false;

  void invertIsSearching() {
    isSearching = !isSearching;
    emit(InvertIsSearchingSuccess(isSearching: isSearching));
    emit(GetAllUserSuccess(users: users));
  }

  void search({required String value}) {
    if (value.isEmpty) {
      isSearching = false;
      emit(GetAllUserSuccess(users: users));
      // return; => I can use return here, so when isSearching is false, the searching stops
    }

    isSearching = true;

    searchList = users
        .where((user) => user.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();

    emit(GetAllUserSuccess(users: searchList));
  }
}