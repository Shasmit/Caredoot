import 'package:flutter/material.dart';

import '../../../../core/constants/app_text_styles.dart';

class BookingDetailsWidget extends StatelessWidget {
  final String details;
  const BookingDetailsWidget({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_back_rounded),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                child: Text(
                  details,
                  style: AppTextStyles.textStyle18w500Secondary.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 0.75,
          color: Colors.grey,
        ),
      ],
    );
  }
}
