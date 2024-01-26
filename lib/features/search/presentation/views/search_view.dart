import 'package:flutter/material.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/core/widgets/custom_search_field.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFillingContainer(
      child: CustomContentContainer(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomSearchField(
                autofocus: false,
                hintText: 'Name or Email',
                onChanged: (String value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
