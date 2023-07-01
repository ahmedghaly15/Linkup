import 'package:flutter/material.dart';

import '../../../../core/global/app_styles.dart';

class MeData extends StatelessWidget {
  const MeData({
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
            style: AppStyles.bodyLarge,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: AppStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}
