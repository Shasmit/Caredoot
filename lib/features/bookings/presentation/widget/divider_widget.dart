import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.lightBackground,
      thickness: 5,
    );
  }
}
