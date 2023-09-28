import 'package:caredoot/features/home/data/models/service_response_model.dart';
import 'package:caredoot/route/app_pages.dart';
import 'package:caredoot/route/custom_navigator.dart';
import 'package:flutter/material.dart';

import 'package:caredoot/core/app_imports.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../data/models/subcategory_response_model.dart';

class ServiceListTile extends StatelessWidget {
  SubCategoryModel? subCategoryModel;
  ServiceModel? serviceModel;
  ServiceListTile({Key? key, this.subCategoryModel, this.serviceModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomNavigator.pushTo(context, AppPages.subServicePage, arguments: {
          'title': serviceModel == null
              ? subCategoryModel!.name
              : serviceModel!.name,
          'slug':
              serviceModel == null ? subCategoryModel!.slug : serviceModel!.slug
        });
      },
      child: Container(
        height: 236.h,
        // width: 382.w,
        // color: Colors.grey,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color.fromARGB(255, 245, 245, 245),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 197.h,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6)),
                  image: DecorationImage(
                      image: serviceModel == null
                          ? NetworkImage(subCategoryModel!.icon)
                          : NetworkImage(serviceModel!.icon),
                      fit: BoxFit.fitWidth)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13.0, top: 4),
              child: serviceModel == null
                  ? Text(
                      subCategoryModel!.name,
                      style: AppTextStyles.textStyleHeebo14w500Secondary,
                    )
                  : Text(
                      serviceModel!.name,
                      style: AppTextStyles.textStyleHeebo14w500Secondary,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SubCategoryListItem extends StatelessWidget {
//   final SubCategoryModel subCategory;
//   const SubCategoryListItem({super.key, required this.subCategory});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 195.h,
//           decoration: BoxDecoration(
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(6), topRight: Radius.circular(6)),
//               image: DecorationImage(
//                   image: NetworkImage(subCategory.icon), fit: BoxFit.fitWidth)),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 8.0),
//           child: Text(
//             subCategory.name,
//             style: AppTextStyles.textStyleHeebo16w500Secondary,
//           ),
//         ),
//       ],
//     );
//   }
// }
