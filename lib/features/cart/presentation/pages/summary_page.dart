import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/core/helpers/scaffold_helpers.dart';
import 'package:caredoot/core/helpers/ui_helpers.dart';
import 'package:caredoot/core/helpers/user_helpers.dart';
import 'package:caredoot/core/helpers/utils.dart';
import 'package:caredoot/features/cart/domain/entities/address_entity.dart';
import 'package:caredoot/features/cart/domain/entities/coupon_entity.dart';
import 'package:caredoot/features/cart/domain/entities/delete_entity.dart';
import 'package:caredoot/features/cart/domain/entities/order_entity.dart';
import 'package:caredoot/features/cart/domain/entities/quantity_update_entity.dart';
import 'package:caredoot/features/cart/presentation/bloc/bloc/cart_bloc.dart';
import 'package:caredoot/features/cart/presentation/widgets/payment_option_selection_sheet.dart';
import 'package:caredoot/features/home/data/models/cart_model.dart';
import 'package:caredoot/route/custom_navigator.dart';
import 'package:caredoot/ui/injection_container.dart';
import 'package:caredoot/ui/molecules/custom_button.dart';
import 'package:caredoot/ui/molecules/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../widgets/cart_list_item.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({
    super.key,
  });

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final Box<CartItem> item = Hive.box<CartItem>('cartItem');
  List<CartItemModel> _items = [];
  String _couponDiscount = "";
  final blocReference = sl<CartBloc>();
  final TextEditingController _couponController = TextEditingController();
  int _subTotal = 0;
  double _gst = 0;
  double _total = 0;
  double _itemDiscount = 0;
  String _selectedDateTime = DateTime.now().toString();
  Address? _selectedAddress;
  String? cartId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _selectedDateTime = args["dateTimeString"];
    _selectedAddress = Address.fromJson(args["selectedAddress"]);
    cartId = args['cartId'];

    super.didChangeDependencies();
  }

  _handlePayment(PaymentOption paymentOption) {
    OrderEntity entity = OrderEntity(
        addressId: _selectedAddress?.id,
        total: _total.toString(),
        gst: _gst.toString(),
        workdate: _selectedDateTime,
        discount: _itemDiscount.toString(),
        totalPayment: (_total - _itemDiscount).toString(),
        discountCoupon: _couponDiscount,
        paymentMode: paymentOption.key,
        userKey: UserHelpers.userDetails?.userKey);
    if (paymentOption.key == "COD") {
      print(entity);
      blocReference.add(ProcessCODPaymentEvent(entity: entity));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary',
            style: AppTextStyles.textStyleHeebo14w500Secondary
                .copyWith(fontSize: 20)),
        centerTitle: false,
        elevation: 0.1,
        shadowColor: Colors.grey,
      ),
      body: BlocProvider(
        create: (context) => blocReference..add(CartInit()),
        child: BlocConsumer<CartBloc, CartState>(listener: (context, state) {
          if (state is CartLoadedState) {
            print('Cart loaded');

            _items = state.cart.items;
            for (var data in _items) {
              _subTotal += data.amount * data.qty;
            }
            _gst = (_subTotal * 18) / 100;
            _total = (_subTotal + _gst);
          }
          if (state is CartLoadingState) {
            print('Cart loading');

            UIHelper.showLoader();
          }
          if (state is CartFailureState) {
            print('Cart failure');

            UIHelper.showToast(msg: state.errorMessage, type: ToastType.Error);
          }
          if (state is CartRefereshedState) {
            _items = state.cartResponseModel.items;
            for (var data in _items) {
              _subTotal += data.amount * data.qty;
            }
            _gst = (_subTotal * 18) / 100;
            _total = (_subTotal + _gst);

            print('Cart refereshed');
          }
          if (state is OrderPlacedSuccessState) {}
          if (state is CouponLoadingState) {
            UIHelper.showLoader();
          }
          if (state is CouponSuccessState) {
            print('Coupon Success');

            _couponDiscount = state.couponResponseModel.data.discount;
            _itemDiscount = (_subTotal * double.parse(_couponDiscount)) / 100;
            _total = _subTotal + _gst - _itemDiscount;
            UIHelper.hideLoader();
          }
          if (state is CouponFailureState) {
            print('Coupon Failure');
            UIHelper.showToast(msg: state.errorMessage, type: ToastType.Error);
          }
          if (state is RemoveCouponState) {
            UIHelper.hideLoader();
            print('RemoveCoupon');
            _couponDiscount = '';
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildItemsList(),
                          CustomSpacers.height16,
                          const SizedBox(
                            child: Divider(
                              thickness: 4,
                              color: AppColors.lightBackground,
                            ),
                          ),

                          _buildRewardCoins(),
                          const SizedBox(
                            child: Divider(
                              thickness: 4,
                              color: AppColors.lightBackground,
                            ),
                          ),

                          _buildApplyCoupon(),
                          const SizedBox(
                            child: Divider(
                              thickness: 4,
                              color: AppColors.lightBackground,
                            ),
                          ),
                          _buildPriceDetails(),
                          // CustomSpacers.height160,
                        ],
                      ),
                    ),
                  ),
                  CustomSpacers.height20,
                  Container(
                    child: _buildFooter(),
                  ),
                ]),
          );
        }),
      ),
    );
  }

  _buildItemsList() {
    return SizedBox(
      child: Column(
        children: List.generate(_items.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: CartItemListTile(
                withOptions: false,
                item: _items[index],
                onQtyUpdate: (qty) {
                  // _onQtyUpdateTap(
                  //     QtyUpdateEntity(itemId: _items[index].itemId, qty: qty));
                },
                onTileDeleteTap: () {
                  // _onItemDeleteTap(_items[index].itemId);
                }),
          );
        }),
      ),
    );
  }

  _onItemDeleteTap(String itemId) async {
    if (await Utils.isUserLoggedIn()) {
      blocReference.add(UpdateCartEvent());
    } else {
      blocReference.add(
          DeleteItemFromCartEvent(entity: DeleteItemEntity(itemId: itemId)));
    }
  }

  DateTime _parseDateTimeString(String dateTimeString) {
    DateFormat format = DateFormat("yyyy-MM-dd H:mm");
    var a = format.parse(dateTimeString);
    return a;
  }

  _onQtyUpdateTap(QtyUpdateEntity entity) async* {
    if (await Utils.isUserLoggedIn()) {
      blocReference.add(UpdateCartEvent());
    } else {
      blocReference.add(QuantityUpdateEvent(entity: entity));
    }
  }

  bool isCheckboxChecked = false;
  var coinBalance = 480;

  _buildRewardCoins() => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    fillColor: MaterialStatePropertyAll(
                      isCheckboxChecked ? const Color(0xff0048C4) : Colors.grey,
                    ),
                    value: isCheckboxChecked,
                    onChanged: (newValue) {
                      setState(() {
                        isCheckboxChecked = newValue!;
                        if (isCheckboxChecked) {
                          _total -= (coinBalance ~/ 10);
                        } else {
                          _total += (coinBalance ~/ 10);
                        }
                      });
                    },
                  ),
                  Text(
                    'Pay using Reward Coins',
                    style: AppTextStyles.textStyleHeebo14w500Primary.copyWith(
                      fontSize: 20,
                      color: isCheckboxChecked
                          ? const Color(0xff0048C4)
                          : AppColors.grey,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomSpacers.width50,
                  SvgPicture.asset(
                    AppIcons.rewardCoins,
                    height: 20,
                    width: 20,
                  ),
                  CustomSpacers.width10,
                  Text(
                    'Available Coin Balance : $coinBalance (₹${coinBalance ~/ 10})',
                    style: AppTextStyles.textStyleHeebo16w400Secondary.copyWith(
                      fontSize: 14,
                      color: AppColors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  _buildPriceDetails() => SizedBox(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height * 0.74,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text('Payment Summary',
                            style: AppTextStyles.textStyleHeebo14w500Secondary
                                .copyWith(fontSize: 20)),
                      ),
                      CustomSpacers.height16,
                      _buildPaymentDetailsRowWidget(
                        title: 'Sub Total',
                        price: _subTotal.toString(),
                        color: Colors.black,
                      ),
                      CustomSpacers.height16,
                      _buildPaymentDetailsRowWidget(
                        title: 'GST(18%)',
                        price: _gst.toString(),
                        color: Colors.black,
                      ),
                      CustomSpacers.height16,
                      _couponDiscount != ''
                          ? _buildPaymentDetailsRowWidget(
                              title: 'Item Discount',
                              price: '-${_itemDiscount.toStringAsFixed(2)}',
                              color: Colors.green,
                            )
                          : Container(),
                      CustomSpacers.height16,
                      const SizedBox(
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      CustomSpacers.height16,
                      isCheckboxChecked
                          ? TotalPaymentRowWidget(
                              title: 'Total',
                              price: isCheckboxChecked
                                  ? '${_total.toStringAsFixed(2)} + ₹${coinBalance ~/ 10}'
                                  : _total.toStringAsFixed(2),
                              color: Colors.black,
                            )
                          : _buildPaymentDetailsRowWidget(
                              title: 'Total',
                              price: isCheckboxChecked
                                  ? '${_total.toStringAsFixed(2)} + ₹${coinBalance ~/ 10}'
                                  : _total.toStringAsFixed(2),
                              color: Colors.black,
                            )
                    ]),
              ),
            ],
          ),
        ),
      );

  _buildApplyCoupon() => GestureDetector(
        onTap: () {
          ScaffoldHelpers.showBottomSheet(
              context: context,
              child: CouponWidget(
                ontap: (a) {
                  _couponController.text = a.toString();
                  blocReference.add(GetCouponDiscountEvent(
                      CouponEntity(_couponController.text.toString())));
                },
              ));
        },
        child: _couponDiscount == ''
            ? SizedBox(
                height: 76.h,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // CustomSpacers.width14,
                      SizedBox(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppIcons.discount),
                          CustomSpacers.width16,
                          Text(
                            'Apply Coupon',
                            style: AppTextStyles.textStyleHeebo14w400Tertiary
                                .copyWith(fontSize: 16, color: AppColors.black),
                          ),
                        ],
                      )),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      )
                    ],
                  ),
                ),
              )
            : SizedBox(
                height: 86.h,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CustomSpacers.width14,
                      SizedBox(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 25,
                          ),
                          CustomSpacers.width16,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'You saved $_couponDiscount% with this code 🎉',
                                style: AppTextStyles
                                    .textStyleHeebo14w400Tertiary
                                    .copyWith(
                                        fontSize: 16,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500),
                              ),
                              CustomSpacers.height6,
                              Text(
                                'Coupon Applied',
                                style: AppTextStyles
                                    .textStyleHeebo14w500Secondary
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                              )
                            ],
                          ),
                        ],
                      )),
                      GestureDetector(
                          onTap: (() {
                            blocReference.add(CouponRemoveEvent());
                          }),
                          child: Text(
                            'Remove',
                            style: AppTextStyles.textStyleHeebo14w500Secondary
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red),
                          ))
                    ],
                  ),
                ),
              ),
      );

  _buildFooter() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                // SvgPicture.asset(AppIcons.home , color: AppColors.black,),
                const Icon(
                  Icons.home,
                  size: 25,
                ),
                CustomSpacers.width10,
                Expanded(
                  child: Text(
                    "${_selectedAddress!.address}",
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.textStyleHeebo14w500Secondary
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          CustomSpacers.height16,
          const SizedBox(
              child: Divider(
            thickness: 2,
          )),
          CustomSpacers.height16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                const Icon(
                  Icons.timer,
                  size: 25,
                ),
                CustomSpacers.width10,

                // Image.asset(AppIcons.clockTime , height: 20,width: 20,fit: BoxFit.cover,),
                Text(
                  DateFormat("HH:MM   dd MMM, yyyy")
                      // ${(DateTime.parse(_selectedDateTime).hour > 12)}
                      .format(_parseDateTimeString(_selectedDateTime)),
                  style: AppTextStyles.textStyleHeebo14w500Secondary
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          CustomSpacers.height16,
          const SizedBox(
              child: Divider(
            thickness: 2,
          )),
          CustomSpacers.height16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27.0),
            child: CustomButton(
                strButtonText: 'Proceed to Pay',
                buttonAction: () async {
                  ScaffoldHelpers.showBottomSheet(
                      context: context,
                      child: PaymentOptionSelectionSheet(
                        onPaymentOptionSelected: (paymentOption) {
                          _handlePayment(paymentOption);
                        },
                      ));
                  // await showModalBottomSheet(
                  //   context: context,
                  //   isScrollControlled: true,
                  //   builder: (BuildContext ctx) {
                  //     return Padding(
                  //         padding: EdgeInsets.only(
                  //             bottom: MediaQuery.of(context).viewInsets.bottom),
                  //         child: Payme());
                  //   },
                  // );
                }),
          ),
          CustomSpacers.height14,
          Text(
            'By proceeding, you agree to our T&C, Privacy and Cancellation Policy',
            textAlign: TextAlign.center,
            style: AppTextStyles.textStyleHeebo14w500Secondary
                .copyWith(fontSize: 10),
          )
        ],
      );
}

// ignore: camel_case_types, must_be_immutable
class _buildPaymentDetailsRowWidget extends StatelessWidget {
  String? title;
  String? price;
  Color? color;
  _buildPaymentDetailsRowWidget({this.price, this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title!,
            style: AppTextStyles.textStyleHeebo16w400Secondary
                .copyWith(color: color)),
        Text("₹ ${price!}",
            style: AppTextStyles.textStyleHeebo16w400Secondary
                .copyWith(color: color)),
      ],
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class TotalPaymentRowWidget extends StatelessWidget {
  String? title;
  String? price;
  Color? color;
  TotalPaymentRowWidget(
      {super.key, required this.color, this.price, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title!,
            style: AppTextStyles.textStyleHeebo16w400Secondary
                .copyWith(color: color)),
        Row(
          children: [
            Text(
              "₹ ${price!}",
              style: AppTextStyles.textStyleHeebo16w400Secondary
                  .copyWith(color: color),
            ),
            CustomSpacers.width4,
            SvgPicture.asset(
              'assets/icons/reward_coins.svg',
              height: 17,
              width: 17,
            ),
          ],
        )
      ],
    );
  }
}

class CouponWidget extends StatefulWidget {
  Function(String) ontap;
  CouponWidget({super.key, required this.ontap});

  @override
  State<CouponWidget> createState() => _CouponWidgetState();
}

class _CouponWidgetState extends State<CouponWidget> {
  late TextEditingController _couponController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _couponController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
          height: 200.h,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Apply Coupon',
                    style: AppTextStyles.textStyleHeebo14w500Secondary
                        .copyWith(fontSize: 18),
                  ),
                  CustomSpacers.height16,
                  CustomTextField(
                    controller: _couponController,
                    autoFocus: true,
                    hint: 'Coupon',
                    suffix: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 12),
                      child: GestureDetector(
                        onTap: () {
                          widget.ontap(_couponController.text.toString());
                          CustomNavigator.pop(context);
                        },
                        child: const Text(
                          'Apply',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.textStyleHeebo14w500Primary,
                        ),
                      ),
                    ),
                  )
                ]),
          ),
        ));
  }
}
