import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/features/home/data/models/categories_response_model.dart';

import 'package:flutter/material.dart';

import '../../../../route/app_pages.dart';
import '../../../../route/custom_navigator.dart';

// ignore: must_be_immutable
class SeviceSliderListItems extends StatefulWidget {
  List<CategoryModel> categoryPosts;

  SeviceSliderListItems({super.key, required this.categoryPosts});

  @override
  State<SeviceSliderListItems> createState() => _SeviceSliderListItemsState();
}

class _SeviceSliderListItemsState extends State<SeviceSliderListItems> {
  List<CategoryModel> categoryitem = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var itemname in widget.categoryPosts) {
      categoryitem.add(itemname);
    }
    print(categoryitem);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.categoryPosts.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () async {
            CustomNavigator.pushTo(context, AppPages.servicesPage, arguments: {
              'isAllServices': false,
              'categoryList': categoryitem,
              'slug': widget.categoryPosts[index]
            });
          },
          child: CategoryListItem(
            category: widget.categoryPosts[index],
          ),
        );
      },
    );
  }
}

class CategoryListItem extends StatelessWidget {
  final CategoryModel category;
  const CategoryListItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14.h),
      child: Container(
        width: 164.w,
        height: 143.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color.fromARGB(250, 220, 240, 255),
          boxShadow: const [
            BoxShadow(
              color: AppColors.primary,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 60.h,
              width: 60.w,
              child: Image.network(
                category.icon,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              category.name,
              style: AppTextStyles.textStyleHeebo14w500Secondary,
            )
          ],
        ),
      ),
    );
  }
}
