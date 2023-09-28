import 'package:caredoot/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_text_styles.dart';

class ProfileOptionListTile extends StatefulWidget {
  final ProfileItem profileItem;

  const ProfileOptionListTile({
    super.key,
    required this.profileItem,
  });

  @override
  State<ProfileOptionListTile> createState() => _ProfileOptionListTileState();
}

class _ProfileOptionListTileState extends State<ProfileOptionListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ListTile(
        onTap: () {
          widget.profileItem.onTap!();
        },
        leading: SizedBox(
          height: 22,
          width: 22,
          child: SvgPicture.asset(
            widget.profileItem.iconName,
            height: 20,
            width: 20,
          ),
        ),
        title: Text(
          widget.profileItem.itemName,
          style: AppTextStyles.textStyleHeebo16w400Secondary.copyWith(
            fontSize: 20,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Color(0xff0048C4),
          size: 18,
        ),
      ),
    );
  }
}
