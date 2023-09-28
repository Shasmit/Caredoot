import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/features/cart/domain/entities/address_entity.dart';
import 'package:caredoot/route/app_pages.dart';
import 'package:caredoot/route/custom_navigator.dart';
import 'package:caredoot/ui/molecules/custom_button.dart';

class AddressSelector extends StatefulWidget {
  final List<Address> addresses;
  final Function(String)? onAddressSelected;
  final String? cartId;
  const AddressSelector(
      {super.key,
      required this.addresses,
      this.onAddressSelected,
      this.cartId});

  @override
  State<AddressSelector> createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
  Address? selectedAddress;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopSection(context),
              _buildAddressList(context),
              CustomSpacers.height20
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                    strButtonText: "Proceed to slots",
                    buttonAction: () {
                      if (selectedAddress != null) {
                        CustomNavigator.pushTo(context, AppPages.selectSlotPage,
                            arguments: {
                              "selectedAddress": selectedAddress!.toJson(),
                              'cartId': widget.cartId
                            });
                      }
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildTopSection(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSpacers.height12,
                const Text("Saved Addresses",
                    style: AppTextStyles.fs18Fw500Lh20),
                CustomSpacers.height10,
                InkWell(
                  onTap: () {
                    CustomNavigator.pushTo(context, AppPages.addAddressPage);
                  },
                  child: const Text(
                    "+ Add another address",
                    style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                )
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    CustomNavigator.pop(context);
                  },
                  child:
                      const Icon(Icons.close, size: 30, color: AppColors.grey)),
            )
          ],
        ),
      ),
    );
  }

  _buildAddressList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) => RadioListTile<Address>(
        groupValue: selectedAddress,
        onChanged: (changed) {
          setState(() {
            selectedAddress = changed;
          });
        },
        value: widget.addresses[index],
        title: Text(widget.addresses[index].address.toString()),
      ),
      itemCount: widget.addresses.length,
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
