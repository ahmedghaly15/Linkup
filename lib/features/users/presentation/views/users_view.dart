import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/widgets/body_loading_indicator.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';
import 'package:social_app/features/users/presentation/widgets/empty_user_view.dart';
import 'package:social_app/features/users/presentation/widgets/user_item.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFillingContainer(
      child: CustomContentContainer(
        bottomPadding: 16,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(bottom: 16.h),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    'Following',
                    style: AppTextStyles.textStyle20Bold,
                  ),
                ),
              ),
            ),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                final UserCubit cubit = BlocProvider.of<UserCubit>(context);

                if (state is GetAllUserSuccess) {
                  return state.followingList.isNotEmpty
                      ? SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300.w,
                            mainAxisExtent: 220.h,
                            mainAxisSpacing: 10.h,
                            crossAxisSpacing: 10.w,
                            childAspectRatio: 3 / 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 650),
                                columnCount: state.followingList.length,
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    child: UserItem(
                                        user: state.followingList[index]),
                                  ),
                                ),
                              );
                            },
                            childCount: state.followingList.length,
                          ),
                        )
                      : const EmptyUsersView();
                } else if (state is GetAllUserError) {
                  return SliverFillRemaining(
                    child: CustomErrorWidget(
                      onPressed: () => cubit.getAllUsers(),
                      error: state.error,
                    ),
                  );
                } else {
                  return const SliverFillRemaining(
                    child: BodyLoadingIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
