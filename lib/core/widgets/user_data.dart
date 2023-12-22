import 'package:flutter/material.dart';

import '../utils/app_text_styles.dart';

class UserData extends StatelessWidget {
  const UserData({
    Key? key,
    required this.count,
    required this.label,
  }) : super(key: key);

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            "$count",
            style: AppTextStyles.textStyle18,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: AppTextStyles.textStyle16,
          ),
        ],
      ),
    );
  }
}
