import 'package:caredoot/features/home/data/models/cart_model.dart';

import '../../../../core/app_imports.dart';
import '../../../../ui/molecules/add_to_cart_widget.dart';

class CartItemListTile extends StatelessWidget {
  final CartItemModel item;
  final Function onTileDeleteTap;
  final Function(int qty) onQtyUpdate;
  final bool withOptions;
  const CartItemListTile(
      {super.key,
      required this.item,
      required this.onQtyUpdate,
      this.withOptions = true,
      required this.onTileDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Stack(
        children: [
          Row(
            children: [
              _buildCartItemImage(),
              _buildCartContent(context),
            ],
          ),
          Visibility(
            visible: withOptions,
            child: Positioned(
                left: 364.w,
                top: 14.h,
                child: InkWell(
                    onTap: () {
                      onTileDeleteTap();
                    },
                    child: Image.asset(AppIcons.cross))),
          )
        ],
      ),
    );
  }

  _buildCartItemImage() => Container(
        height: 80.h,
        width: 80.w,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitHeight, image: NetworkImage(item.image)),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      );
  _buildCartContent(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.67,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: AppTextStyles.textStyleHeebo14w500Secondary,
                  ),
                  // Row(
                  //   children: [
                  //     Image.asset(AppIcons.clockTime),
                  //     CustomSpacers.width8,
                  //     Text(
                  //       '23 June, 6 PM, Wednesday',
                  //       style: AppTextStyles.textStyleHeebo14w400Tertiary
                  //           .copyWith(fontSize: 10, color: Colors.black),
                  //     )
                  //   ],
                  // ),
                  CustomSpacers.height6,
                  Row(
                    children: [
                      withOptions
                          ? AddToCartButton(
                              onTap: () {},
                              onQtyUpdate: (a) {
                                onQtyUpdate(a);
                              },
                              initialQuantity: item.qty)
                          : Text("${item.qty} x ",
                              style: AppTextStyles.fs14Fw500FfLato),
                      withOptions ? const Spacer() : const SizedBox(),
                      Text("₹${item.amount}",
                          style: AppTextStyles.textStyleHeebo14w500Secondary)
                    ],
                  ),
                ]),
          ),
        ),
      );
}
