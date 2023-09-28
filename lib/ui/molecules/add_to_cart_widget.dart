import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class AddToCartButton extends StatefulWidget {
  final VoidCallback onTap;
  final Function(int qty) onQtyUpdate;
  final int initialQuantity;

  const AddToCartButton(
      {super.key,
      required this.onTap,
      required this.onQtyUpdate,
      this.initialQuantity = 0});

  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  int quantity = 0;

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
    widget.onQtyUpdate(quantity);
  }

  void _decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      } else {
        quantity = 0;
      }
    });
    widget.onQtyUpdate(quantity);
  }

  @override
  void initState() {
    quantity = widget.initialQuantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return quantity > 0
        ? Container(
            height: 29.h,
            width: 70.w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: AppColors.primary)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: _decrementQuantity,
                    child: const Icon(Icons.remove,
                        size: 15, color: AppColors.primary)),
                Text(quantity.toString(),
                    style: AppTextStyles.textStyleHeebo14w500Primary
                        .copyWith(fontSize: 14, color: AppColors.primary)),
                GestureDetector(
                    onTap: _incrementQuantity,
                    child: const Icon(Icons.add,
                        size: 15, color: AppColors.primary)),
              ],
            ))
        : InkWell(
            onTap: () {
              setState(() {
                quantity = 1;
              });
              widget.onTap();
            },
            child: Container(
              height: 29.h,
              width: 67.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: Center(
                child: Text(
                  "Add",
                  style: AppTextStyles.textStyleHeebo14w500Primary
                      .copyWith(fontSize: 12),
                ),
              ),
            ),
          );
  }
}
