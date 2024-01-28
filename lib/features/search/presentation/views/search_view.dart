import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/core/widgets/custom_search_field.dart';
import 'package:social_app/core/widgets/person.dart';
import 'package:social_app/features/search/presentation/cubit/search_cubit.dart';
import 'package:social_app/features/search/presentation/widgets/shimmer_search_view.dart';
import 'package:social_app/service_locator.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<SearchCubit>(),
      child: CustomFillingContainer(
        child: CustomContentContainer(
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return CustomScrollView(
                physics: AppConstants.physics,
                slivers: [
                  SliverToBoxAdapter(
                    child: CustomSearchField(
                      autofocus: false,
                      hintText: 'Name or Email',
                      onChanged: (String value) {
                        BlocProvider.of<SearchCubit>(context)
                            .search(nameOrEmail: value);
                      },
                    ),
                  ),
                  if (state is SearchLoading) const ShimmerSearchView(),
                  if (state is SearchSuccess)
                    SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 16.w),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Person(
                              user: state.searchResult[index],
                            );
                          },
                          childCount: state.searchResult.length,
                        ),
                      ),
                    ),
                  if (state is SearchError)
                    SliverFillRemaining(
                      child: CustomErrorWidget(
                        hasTryAgainButton: false,
                        onPressed: () {},
                        error: state.error,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
