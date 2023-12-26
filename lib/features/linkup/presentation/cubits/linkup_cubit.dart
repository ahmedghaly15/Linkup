import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/linkup/domain/entities/change_index_params.dart';
import 'package:social_app/features/linkup/domain/usecases/change_bottom_nav_index.dart';
import 'package:social_app/features/linkup/domain/usecases/change_nav_to_home.dart';
import 'package:social_app/features/linkup/domain/usecases/get_all_users.dart';
import 'package:social_app/features/linkup/domain/usecases/get_body.dart';
import 'package:social_app/features/linkup/domain/usecases/get_bottom_nav_items.dart';
import 'package:social_app/features/linkup/domain/usecases/get_user_data.dart';

part 'linkup_state.dart';

class LinkupCubit extends Cubit<LinkupState> {
  final GetBodyUseCse getBodyUseCse;
  final GetBottomNavItemsUseCase getBottomNavItemsUseCase;
  final ChangeBottomNavIndexUseCase changeBottomNavIndexUseCase;
  final ChangeNavToHomeUseCase changeNavToHomeUseCase;
  final GetUserDataUseCase getUserDataUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;

  LinkupCubit({
    required this.getBodyUseCse,
    required this.getBottomNavItemsUseCase,
    required this.changeBottomNavIndexUseCase,
    required this.changeNavToHomeUseCase,
    required this.getAllUsersUseCase,
    required this.getUserDataUseCase,
  }) : super(const LinkupInitial());

  int currentIndex = 0;

  List<Widget> getBody() => getBodyUseCse(const NoParams());

  List<BottomNavigationBarItem> getBottomNavItems() =>
      getBottomNavItemsUseCase(const NoParams());

  void changeBottomNavIndex(int index, BuildContext context) {
    currentIndex = index;

    changeBottomNavIndexUseCase(ChangeIndexParams(
      context: context,
      index: index,
    ));

    if (currentIndex == 1 || currentIndex == 2) getAllUsers();

    emit(ChangeBottomNavIndex(index: index));
  }

  void changeBottomNavToHome(BuildContext context) {
    changeNavToHomeUseCase(context);

    emit(const ChangeBottomNavToHome());
  }

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
