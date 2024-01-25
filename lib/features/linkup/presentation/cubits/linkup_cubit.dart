import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/linkup/domain/entities/change_index_params.dart';
import 'package:social_app/features/linkup/domain/usecases/change_bottom_nav_index.dart';
import 'package:social_app/features/linkup/domain/usecases/change_nav_to_home.dart';
import 'package:social_app/features/linkup/domain/usecases/get_body.dart';
import 'package:social_app/features/linkup/domain/usecases/get_bottom_nav_items.dart';
import 'package:social_app/features/users/presentation/cubits/user_profile/user_profile_cubit.dart';

part 'linkup_state.dart';

class LinkupCubit extends Cubit<LinkupState> {
  final GetBodyUseCse getBodyUseCse;
  final GetBottomNavItemsUseCase getBottomNavItemsUseCase;
  final ChangeBottomNavIndexUseCase changeBottomNavIndexUseCase;
  final ChangeNavToHomeUseCase changeNavToHomeUseCase;

  LinkupCubit({
    required this.getBodyUseCse,
    required this.getBottomNavItemsUseCase,
    required this.changeBottomNavIndexUseCase,
    required this.changeNavToHomeUseCase,
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

    // if (currentIndex == 0) BlocProvider.of<UserCubit>(context).getPosts();

    if (currentIndex == 3) {
      BlocProvider.of<UserProfileCubit>(context).getUserPosts(uId: Helper.uId!);
    }

    emit(ChangeBottomNavIndex(index: currentIndex));
  }

  void changeBottomNavToHome(BuildContext context) {
    changeNavToHomeUseCase(context);

    emit(ChangeBottomNavIndex(index: currentIndex));
  }
}
