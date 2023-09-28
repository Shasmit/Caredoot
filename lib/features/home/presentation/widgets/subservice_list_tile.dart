import 'dart:ffi';

import 'package:caredoot/features/home/data/models/cart_model.dart';
import 'package:caredoot/ui/molecules/add_to_cart_widget.dart';
import 'package:flutter/material.dart';

import 'package:caredoot/core/app_imports.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';

import '../../data/models/sub_services_response_model.dart';

class SubServiceListTile extends StatelessWidget {
  final SubServiceModel subServiceModel;
  final Function onAddTap;
  final Function(int qty) onQtyUpdate;
  int qty;

  SubServiceListTile(
      {Key? key,
      required this.subServiceModel,
      required this.onAddTap,
      required this.onQtyUpdate,
      this.qty = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 396.w,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromARGB(144, 216, 210, 210),
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 2, right: 2, bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 300.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subServiceModel.name,
                      style: AppTextStyles.textStyleHeebo16w500Secondary,
                    ),
                    Row(
                      children: [
                        Text(
                          '₹${subServiceModel.amount}',
                          style: AppTextStyles.textStyleHeebo16w500Secondary,
                        ),
                        CustomSpacers.width12,
                        const Icon(
                          Icons.timer_outlined,
                          color: Colors.grey,
                          size: 13,
                        ),
                        CustomSpacers.width4,
                        _buildEstimateTime(),
                      ],
                    ),
                    CustomSpacers.height8,
                    const SizedBox(
                      child: Center(
                        child: Divider(),
                      ),
                    ),
                    _buildExpandedTextInfo(),
                  ],
                ),
              ),
              SizedBox(
                height: 100.h,
                child: Stack(
                  children: [
                    Container(
                      height: 80.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: NetworkImage(subServiceModel.slider_1)),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                    _buildAddToCart(),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  _buildEstimateTime() => Text(
        subServiceModel.estimate_time,
        style: const TextStyle(
            fontSize: 13,
            fontFamily: 'Heebo',
            fontWeight: FontWeight.w400,
            color: Colors.grey),
      );

  _buildExpandedTextInfo() => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 8),
        child: ExpandableText(
          subServiceModel.details,
          readMoreText: 'See More',
          readLessText: 'See Less',
          trim: 50,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Heebo',
            wordSpacing: 5,
          ),
          trimType: TrimType.characters,
        ),
      );
  _buildAddToCart() => Positioned(
      top: 67.h,
      left: 9.5.w,
      child: AddToCartButton(
        onTap: () {
          onAddTap();
        },
        onQtyUpdate: (qty) {
          onQtyUpdate(qty);
        },
        initialQuantity: qty,
      ));
}
