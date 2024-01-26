import 'package:flutter/material.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/features/chat/presentation/widgets/custom_search_field.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomFillingContainer(
      child: CustomContentContainer(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomSearchField(hintText: 'Name or Email'),
            ),
          ],
        ),
      ),
    );
  }
}
