import 'package:caredoot/core/constants/app_text_styles.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/constants/app_colors.dart';

class AllRightReserved extends StatelessWidget {
  const AllRightReserved({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: "All rights reserved by",
              style: AppTextStyles.textStyleHeebo14w500Secondary
                  .copyWith(color: AppColors.secondaryText)),
          const TextSpan(
              text: " Caredoot",
              style: TextStyle(
                fontFamily: 'Heebo',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ))
        ]),
      ),
    );
  }
}
