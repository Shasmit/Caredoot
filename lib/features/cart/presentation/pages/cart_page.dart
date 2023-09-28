import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/core/helpers/scaffold_helpers.dart';
import 'package:caredoot/core/helpers/ui_helpers.dart';
import 'package:caredoot/core/helpers/user_helpers.dart';
import 'package:caredoot/core/helpers/utils.dart';
import 'package:caredoot/features/cart/domain/entities/delete_entity.dart';
import 'package:caredoot/features/cart/domain/entities/quantity_update_entity.dart';
import 'package:caredoot/features/cart/presentation/bloc/bloc/cart_bloc.dart';
import 'package:caredoot/features/cart/presentation/widgets/address_selector.dart';
import 'package:caredoot/features/home/data/models/cart_model.dart';
import 'package:caredoot/features/onboarding/presentation/pages/login_sheet_widget.dart';
import 'package:caredoot/ui/injection_container.dart';
import 'package:caredoot/ui/molecules/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widgets/cart_list_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Box<CartItem> item = Hive.box<CartItem>('cartItem');
  List<CartItemModel> _items = [];
  final _blocReference = sl<CartBloc>();
  int _subTotal = 0;
  double _gst = 0;
  double _total = 0;
  bool isSignedIn = false;

  @override
  void initState() {
    _checkUserStatus();
    super.initState();
  }

  Future<void> _checkUserStatus() async {
    bool userStatus = await UserHelpers.getUserDetails() != false;
    var a = await UserHelpers.getUserDetails();
    isSignedIn = userStatus;
    setState(() {});
  }

  _refreshPage() {
    _blocReference.add(RefreshCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart',
            style: AppTextStyles.textStyleHeebo14w500Secondary
                .copyWith(fontSize: 20)),
        centerTitle: false,
        elevation: 0.1,
        shadowColor: Colors.grey,
      ),
      body: BlocProvider<CartBloc>(
        create: (context) => _blocReference..add(CartInit()),
        child: BlocListener<CartBloc, CartState>(
          bloc: _blocReference,
          listener: (context, state) {
            if (state is CartLoadedState) {
              print('Cart loaded');
              _items = state.cart.items;
              for (var data in _items) {
                _subTotal += data.amount * data.qty;
              }
              _gst = (_subTotal * 18) / 100;
              _total = (_subTotal + _gst);
            }

            if (state is CartFailureState) {
              print('Cart failure');

              UIHelper.showToast(
                  msg: state.errorMessage, type: ToastType.Error);
            }
            if (state is CartRefereshedState) {
              _subTotal = 0;
              _gst = 0;
              _total = 0;
              _items = state.cartResponseModel.items;
              for (var data in _items) {
                _subTotal += data.amount * data.qty;
              }
              _gst = (_subTotal * 18) / 100;
              _total = (_subTotal + _gst);
              print('Cart refereshed');
            }
            if (state is AddressesLoadedState) {
              if (state.addresses.isNotEmpty) {
                ScaffoldHelpers.showBottomSheet(
                    context: context,
                    child: AddressSelector(
                      addresses: state.addresses,
                      cartId: "1",
                    ));
              }
            }
          },
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: _items.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: const Center(child: Text("No Items added yet!")),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.65,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    _buildItemsList(),
                                    const SizedBox(
                                      child: Divider(
                                        thickness: 8,
                                        color:
                                            Color.fromARGB(217, 217, 217, 217),
                                      ),
                                    ),

                                    const SizedBox(
                                      child: Divider(
                                        thickness: 8,
                                        color:
                                            Color.fromARGB(217, 217, 217, 217),
                                      ),
                                    ),
                                    _buildPriceDetails(),
                                    // CustomSpacers.height160,
                                  ],
                                ),
                              ),
                            ),
                            CustomSpacers.height35,
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 27.0, vertical: 35),
                                child: CustomButton(
                                    strButtonText: isSignedIn
                                        ? 'Continue'
                                        : 'Login/Signup to proceed',
                                    buttonAction: () async {
                                      if (isSignedIn) {
                                        _blocReference
                                            .add(GetMyAddressesEvent());
                                        return;
                                      }
                                      ScaffoldHelpers.showBottomSheet(
                                          context: context,
                                          child: LoginSheetWidget(
                                            onSuccess: () async {
                                              _checkUserStatus().then((value) {
                                                Navigator.pop(context);
                                              });
                                            },
                                            onFailure: () {
                                              UIHelper.showToast(
                                                  msg: "Login Failure",
                                                  type: ToastType.Error);
                                            },
                                          ));
                                    }),
                              ),
                            ),
                          ]),
              );
            },
          ),
        ),
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
                item: _items[index],
                onQtyUpdate: (qty) {
                  _onQtyUpdateTap(
                      QtyUpdateEntity(itemId: _items[index].itemId, qty: qty));
                },
                onTileDeleteTap: () {
                  _onItemDeleteTap(_items[index].itemId);
                }),
          );
        }),
      ),
    );
  }

  _onItemDeleteTap(String itemId) async {
    if (await Utils.isUserLoggedIn()) {
      _blocReference.add(UpdateCartEvent());
    } else {
      _blocReference.add(
          DeleteItemFromCartEvent(entity: DeleteItemEntity(itemId: itemId)));
    }
  }

  _onQtyUpdateTap(QtyUpdateEntity entity) async {
    if (await Utils.isUserLoggedIn()) {
      _blocReference.add(UpdateCartEvent());
    } else {
      _blocReference.add(QuantityUpdateEvent(entity: entity));
    }
  }

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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10),
                        child: Text('Payment Summary',
                            style: AppTextStyles.textStyleHeebo14w500Secondary
                                .copyWith(fontSize: 20)),
                      ),
                      CustomSpacers.height16,
                      _buildPaymentDetailsRowWidget(
                          title: 'Sub Total',
                          price: _subTotal.toStringAsFixed(0)),
                      CustomSpacers.height16,
                      _buildPaymentDetailsRowWidget(
                          title: 'GST(18%)', price: _gst.toStringAsFixed(0)),
                      CustomSpacers.height16,
                      // _buildPaymentDetailsRowWidget(
                      //     title: 'Taxes and fee', price: '83'),

                      const SizedBox(
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      CustomSpacers.height16,
                      _buildPaymentDetailsRowWidget(
                          title: 'Total', price: _total.toStringAsFixed(0)),
                    ]),
              ),
            ],
          ),
        ),
      );
}

// ignore: camel_case_types, must_be_immutable
class _buildPaymentDetailsRowWidget extends StatelessWidget {
  String? title;
  String? price;
  _buildPaymentDetailsRowWidget({this.price, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title!, style: AppTextStyles.textStyleHeebo16w400Secondary),
        Text("₹ ${price!}", style: AppTextStyles.textStyleHeebo16w400Secondary),
      ],
    );
  }
}
