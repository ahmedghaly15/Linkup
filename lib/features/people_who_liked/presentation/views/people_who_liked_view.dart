import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/core/widgets/custom_get_back_button.dart';
import 'package:social_app/features/people_who_liked/presentation/cubit/people_who_liked_cubit.dart';
import 'package:social_app/features/people_who_liked/presentation/widgets/person_who_liked.dart';

class PeopleWhoLikedView extends StatelessWidget {
  const PeopleWhoLikedView({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomFillingContainer(
        child: CustomContentContainer(
          child: CustomScrollView(
            physics: AppConstants.physics,
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  children: <Widget>[
                    const CustomGetBackButton(hasShadow: true),
                    const Spacer(),
                    Text(
                      'People who liked',
                      style: AppTextStyles.textStyle20Bold,
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
              BlocBuilder<PeopleWhoLikedCubit, PeopleWhoLikedState>(
                builder: (context, state) {
                  final PeopleWhoLikedCubit cubit =
                      BlocProvider.of<PeopleWhoLikedCubit>(context);

                  return cubit.peopleWhoLiked.isNotEmpty
                      ? SliverPadding(
                          padding: EdgeInsets.symmetric(vertical: 16.w),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 650),
                                  child: SlideAnimation(
                                    horizontalOffset: -150.w,
                                    child: PersonWhoLiked(
                                      user: cubit.peopleWhoLiked[index],
                                    ),
                                  ),
                                );
                              },
                              childCount: cubit.peopleWhoLiked.length,
                            ),
                          ),
                        )
                      : const SliverFillRemaining(child: SizedBox());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
