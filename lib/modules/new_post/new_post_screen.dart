import 'package:flutter/material.dart';
import 'package:social_app/shared/constants.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBuilder(
        context: context,
        title: "New Post",
      ),
    );
  }
}
