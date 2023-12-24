import 'package:flutter/material.dart';
import 'package:social_app/features/new_post/presentation/widgets/new_post_view_body.dart';

class NewPostView extends StatelessWidget {
  const NewPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: NewPostViewBody());
  }
}
