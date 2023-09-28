import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/route/app_pages.dart';
import 'package:caredoot/route/custom_navigator.dart';
import 'package:caredoot/ui/molecules/custom_button.dart';

class PaymentOptionSelectionSheet extends StatefulWidget {
  final Function(PaymentOption) onPaymentOptionSelected;
  const PaymentOptionSelectionSheet(
      {super.key, required this.onPaymentOptionSelected});

  @override
  State<PaymentOptionSelectionSheet> createState() =>
      _PaymentOptionSelectionSheetState();
}

class _PaymentOptionSelectionSheetState
    extends State<PaymentOptionSelectionSheet> {
  PaymentOption selectedPaymentOption = paymentOptions[0];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Choose your Payment option",
                  style: AppTextStyles.textStyle18w600Primary),
              IconButton(
                  onPressed: () {
                    CustomNavigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          Container(
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => RadioListTile(
                      groupValue: selectedPaymentOption,
                      value: paymentOptions[index],
                      onChanged: (s) {
                        setState(() {
                          selectedPaymentOption = s!;
                        });
                      },
                      title: Text(paymentOptions[index].title),
                    ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: paymentOptions.length),
          ),
          CustomButton(
              strButtonText: "Proceed to payment",
              buttonAction: () {
                widget.onPaymentOptionSelected(selectedPaymentOption);
                Navigator.popAndPushNamed(context, AppPages.bookingDetails);
                // if (selectedPaymentOption.key == "COD") {}
              })
        ],
      ),
    );
  }
}
