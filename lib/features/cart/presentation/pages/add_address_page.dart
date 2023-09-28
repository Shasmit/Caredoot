import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/core/helpers/user_helpers.dart';
import 'package:caredoot/core/helpers/utils.dart';
import 'package:caredoot/features/cart/domain/entities/address_entity.dart';
import 'package:caredoot/features/cart/presentation/bloc/bloc/cart_bloc.dart';
import 'package:caredoot/features/onboarding/data/models/user_details_model.dart';
import 'package:caredoot/route/app_pages.dart';
import 'package:caredoot/route/custom_navigator.dart';
import 'package:caredoot/ui/injection_container.dart';
import 'package:caredoot/ui/molecules/custom_button.dart';
import 'package:caredoot/ui/molecules/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  late TextEditingController _nameController;
  late TextEditingController _homeFlatController;
  late TextEditingController _landmarkController;
  late TextEditingController _addressController;
  late TextEditingController _pincodeController;
  late TextEditingController _choosePlaceController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  final CartBloc _blocReference = sl<CartBloc>();
  bool _isDefaultAddress = true;
  final _addressFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _homeFlatController = TextEditingController();
    _landmarkController = TextEditingController();
    _choosePlaceController = TextEditingController();
    _addressController = TextEditingController();
    _pincodeController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
  }

  _validateAndAddInfo() async {
    bool isFormValid = _addressFormKey.currentState!.validate();
    if (isFormValid) {
      UserDetails user = await UserHelpers.getUserDetails();
      var entity = Address(
          address: _addressController.text,
          email: _emailController.text,
          isDefault: _isDefaultAddress,
          mobile: _phoneNumberController.text,
          name: _nameController.text,
          pincode: _pincodeController.text,
          userKey: user.userKey ?? '');
      _blocReference.add(SaveAddressEvent(addressEntity: entity));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.dismissKeypad(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text('Add Address',
              style: AppTextStyles.textStyleHeebo14w500Secondary
                  .copyWith(fontSize: 20)),
          centerTitle: false,
          elevation: 0.1,
          shadowColor: Colors.grey,
        ),
        body: BlocProvider(
          create: (context) => _blocReference,
          child: BlocListener<CartBloc, CartState>(
            bloc: _blocReference,
            listener: (context, state) {
              if (state is UpdateDefaultAddressCheckBoxState) {
                _isDefaultAddress = state.value;
              }
              if (state is AddressSavedState) {
                CustomNavigator.pushTo(context, AppPages.selectSlotPage);
              }
            },
            child: BlocBuilder<CartBloc, CartState>(
                bloc: _blocReference,
                builder: (context, snapshot) {
                  return Form(
                    key: _addressFormKey,
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(children: [
                              CustomTextField(
                                controller: _nameController,
                                hint: 'Name',
                                isRequired: true,
                                validator: (name) {
                                  return (name != null && name.isNotEmpty)
                                      ? null
                                      : "Name is required";
                                },
                              ),
                              CustomSpacers.height10,
                              CustomTextField(
                                controller: _phoneNumberController,
                                hint: "Phone Number",
                                isRequired: true,
                                validator: Validators.phoneNumber,
                              ),
                              CustomSpacers.height10,
                              CustomTextField(
                                controller: _emailController,
                                hint: "Email ID",
                                validator: Validators.email,
                              ),
                              CustomSpacers.height10,
                              Row(
                                children: [
                                  Flexible(
                                    child: CustomTextField(
                                      controller: _homeFlatController,
                                      hint: 'House/Flat No.',
                                      isRequired: true,
                                    ),
                                  ),
                                  CustomSpacers.width10,
                                  Flexible(
                                    child: CustomTextField(
                                      controller: _landmarkController,
                                      hint: 'Landmark',
                                    ),
                                  ),
                                ],
                              ),
                              CustomSpacers.height10,
                              CustomTextField(
                                controller: _pincodeController,
                                hint: 'Pincode',
                                isRequired: true,
                                validator: Validators.pinCode,
                              ),
                              CustomSpacers.height10,
                              CustomTextField(
                                maxLines: 3,
                                minLines: 1,
                                controller: _addressController,
                                hint: 'Address',
                                isRequired: true,
                                validator: Validators.address,
                              ),
                              CustomSpacers.height10,
                              CheckboxListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 8),
                                  value: _isDefaultAddress,
                                  title: const Text(
                                      "Mark this address as default address for future orders?",
                                      style:
                                          AppTextStyles.defaultTextStyle14_400),
                                  onChanged: (a) {
                                    print(a!);
                                    _blocReference.add(
                                        UpdateDefaultAddressCheckBoxEvent(
                                            value: a));
                                  }),
                              CustomSpacers.height160
                              // SelectPlaceWidget(onSelected: (a) {
                              //   _choosePlaceController.text = a;
                              // }),
                            ]),
                          ),
                        ),
                        Column(
                          children: [
                            const Spacer(),
                            Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: CustomButton(
                                    strButtonText: 'Save and Proceed to slots',
                                    buttonAction: () {
                                      _validateAndAddInfo();
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class SelectPlaceWidget extends StatefulWidget {
  Function(String) onSelected;
  SelectPlaceWidget({super.key, required this.onSelected});

  @override
  State<SelectPlaceWidget> createState() => _SelectPlaceWidgetState();
}

class _SelectPlaceWidgetState extends State<SelectPlaceWidget> {
  final ValueNotifier<bool> isHomeSelected = ValueNotifier(false);
  final ValueNotifier<bool> isOtherSelected = ValueNotifier(false);

  void _selectHome() {
    isHomeSelected.value = true;
    isOtherSelected.value = false;
    widget.onSelected('Home');
  }

  void _selectOther() {
    isHomeSelected.value = false;
    isOtherSelected.value = true;
    widget.onSelected('Other');
  }

  @override
  void dispose() {
    isHomeSelected.dispose();
    isOtherSelected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSpacers.height24,
        Text(
          'Choose Place',
          style: AppTextStyles.textStyleHeebo14w500Secondary
              .copyWith(fontSize: 16),
        ),
        CustomSpacers.height12,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _selectHome,
              child: ValueListenableBuilder(
                valueListenable: isHomeSelected,
                builder: (context, value, _) {
                  return Container(
                    width: 85.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: value ? Colors.black : Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Home',
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: _selectOther,
              child: ValueListenableBuilder(
                valueListenable: isOtherSelected,
                builder: (context, value, _) {
                  return Container(
                    width: 85.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: value ? Colors.black : Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Other',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
