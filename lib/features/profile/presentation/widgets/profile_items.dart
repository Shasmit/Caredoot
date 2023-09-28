import 'package:flutter/material.dart';

import '../../../../core/constants/app_text_styles.dart';

class ProfileItems extends StatefulWidget {
  final String itemName;
  final Icon itemIcon;

  const ProfileItems({
    super.key,
    required this.itemName,
    required this.itemIcon,
  });

  @override
  State<ProfileItems> createState() => _ProfileItemsState();
}

class _ProfileItemsState extends State<ProfileItems> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          leading: widget.itemIcon,
          title: Text(
            widget.itemName,
            style: AppTextStyles.textStyleLato14w500Secondary.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color(0xff0048C4),
            size: 20,
          ),
        ),
        const Divider(
          color: Colors.black,
          thickness: 0.5,
        ),
      ],
    );
  }
}
