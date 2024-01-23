import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/body_loading_indicator.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/following_and_followers_cubit.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/get_followers/get_followers_cubit.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/get_following/get_following_cubit.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';
import 'package:social_app/features/users/presentation/widgets/empty_user_view.dart';
import 'package:social_app/features/users/presentation/widgets/user_item.dart';

class FollowingAndFollowersView extends StatefulWidget {
  const FollowingAndFollowersView({super.key});

  @override
  State<FollowingAndFollowersView> createState() =>
      _FollowingAndFollowersViewState();
}

class _FollowingAndFollowersViewState extends State<FollowingAndFollowersView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFillingContainer(
      child: CustomContentContainer(
        bottomPadding: 16,
        child: Scaffold(
          backgroundColor: Helper.isDark(context)
              ? AppColors.darkPrimaryColor
              : AppColors.lightWhiteBlue,
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Helper.isDark(context)
                ? AppColors.darkPrimaryColor
                : AppColors.lightWhiteBlue,
            elevation: 0,
            bottom: TabBar(
              onTap: (int index) {
                if (index == 0) {
                  BlocProvider.of<GetFollowersCubit>(context).getFollowers();
                }

                if (index == 1) {
                  BlocProvider.of<GetFollowingCubit>(context).getFollowing();
                }
              },
              padding: EdgeInsets.zero,
              controller: _tabController,
              indicatorColor: AppColors.primaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4.h,
              indicatorPadding: EdgeInsets.only(bottom: 8.h),
              dividerHeight: 0,
              isScrollable: true,
              labelStyle: AppTextStyles.textStyle16SemiBold.copyWith(
                color: Helper.isDark(context) ? Colors.white : Colors.black,
              ),
              unselectedLabelColor:
                  Helper.isDark(context) ? Colors.white : Colors.black,
              labelPadding: EdgeInsets.symmetric(
                horizontal: 48.0.w,
              ),
              tabAlignment: TabAlignment.center,
              tabs: const [
                Tab(text: 'Followers'),
                Tab(text: 'Following'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              FollowersTab(),
              FollowingTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class FollowersTab extends StatelessWidget {
  const FollowersTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: CustomScrollView(
        physics: AppConstants.physics,
        slivers: [
          BlocBuilder<GetFollowersCubit, GetFollowersState>(
            builder: (context, state) {
              final GetFollowersCubit cubit =
                  BlocProvider.of<GetFollowersCubit>(context);

              if (state is GetFollowersSuccess) {
                return state.followers.isNotEmpty
                    ? SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 210.w,
                            mainAxisExtent: 210.h,
                            mainAxisSpacing: 10.h,
                            crossAxisSpacing: 16.w,
                            childAspectRatio: 3 / 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 650),
                                columnCount: state.followers.length,
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    child: FollowerUserItem(
                                      user: state.followers[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: state.followers.length,
                          ),
                        ),
                      )
                    : const EmptyUsersView();
              } else if (state is GetFollowersError) {
                return SliverFillRemaining(
                  child: CustomErrorWidget(
                    onPressed: () => cubit.getFollowers(),
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
    );
  }
}

class FollowingTab extends StatelessWidget {
  const FollowingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFollowingCubit, GetFollowingState>(
      builder: (context, state) {
        final GetFollowingCubit cubit =
            BlocProvider.of<GetFollowingCubit>(context);

        if (state is GetFollowingSuccess) {
          return state.following.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: ListView.builder(
                    itemCount: state.following.length,
                    physics: AppConstants.physics,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 650),
                        child: SlideAnimation(
                          horizontalOffset: 150,
                          child: FollowingUserItem(
                            user: state.following[index],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox();
        } else if (state is GetFollowingError) {
          return CustomErrorWidget(
            onPressed: () => cubit.getFollowing(),
            error: state.error,
          );
        } else {
          return const Center(
            child: BodyLoadingIndicator(),
          );
        }
      },
    );
  }
}

class FollowingUserItem extends StatelessWidget {
  const FollowingUserItem({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 0),
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Helper.isDark(context)
            ? AppColors.darkPrimaryColor
            : AppColors.lightWhiteBlue,
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          if (user.uId! != Helper.currentUser!.uId) {
            BlocProvider.of<UserCubit>(context)
                .getUserPosts(uId: user.uId!)
                .then((value) {
              context.navigateTo(
                routeName: Routes.userProfileRoute,
                arguments: user,
              );
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CachedNetworkImage(
                errorWidget: (context, error, _) =>
                    const CachedImageErrorIcon(),
                imageUrl: user.image!,
                imageBuilder: (_, image) {
                  return CircleAvatar(
                    backgroundImage: image,
                    radius: 25.r,
                    backgroundColor: AppColors.primaryColor,
                  );
                },
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.name!,
                      style: AppTextStyles.textStyle16SemiBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      user.bio!,
                      style: AppTextStyles.textStyle13.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<bool>(
                  stream: BlocProvider.of<FollowingAndFollowersCubit>(context)
                      .userIsFollowed(user: user),
                  builder: (context, snapshot) {
                    bool isFollowed = snapshot.data ?? false;
                    String buttonText = isFollowed ? 'Unfollow' : 'Follow';

                    return OutlinedButton(
                      onPressed: () => isFollowed
                          ? BlocProvider.of<FollowingAndFollowersCubit>(context)
                              .unfollow(user: user)
                          : BlocProvider.of<FollowingAndFollowersCubit>(context)
                              .follow(user: user),
                      style: ButtonStyle(
                        side: MaterialStatePropertyAll(
                          BorderSide(
                            color: AppColors.primaryColor,
                            width: 1.w,
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll(
                          isFollowed
                              ? AppColors.lightWhiteBlue
                              : AppColors.primaryColor,
                        ),
                        textStyle: MaterialStatePropertyAll(
                          AppTextStyles.textStyle13
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        foregroundColor: MaterialStatePropertyAll(
                          isFollowed ? AppColors.primaryColor : Colors.white,
                        ),
                      ),
                      child: Text(buttonText),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
