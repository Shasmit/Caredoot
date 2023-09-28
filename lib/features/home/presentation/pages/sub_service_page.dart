import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/core/helpers/shopping_cart_helper.dart';
import 'package:caredoot/core/helpers/user_helpers.dart';
import 'package:caredoot/features/home/data/models/cart_model.dart';
import 'package:caredoot/features/home/domain/entities/addtocart_entity.dart';
import 'package:caredoot/main.dart';
import 'package:caredoot/route/app_pages.dart';
import 'package:caredoot/route/custom_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helpers/ui_helpers.dart';
import '../../../../ui/injection_container.dart';
import '../../data/models/sub_services_response_model.dart';
import '../../domain/entities/subservice_entity.dart';
import '../bloc/subservices/subservice_bloc.dart';
import '../bloc/subservices/subservice_event.dart';
import '../bloc/subservices/subservice_state.dart';
import '../widgets/subservice_list_tile.dart';

class SubServicePage extends StatefulWidget {
  Map<String, dynamic> arguements;
  SubServicePage({super.key, required this.arguements});

  @override
  State<SubServicePage> createState() => _SubServicePageState();
}

class _SubServicePageState extends State<SubServicePage> {
  late bool _isSubServiceLoading;
  late final SubServiceBloc _subServiceBloc;
  final List<CartItemModel> _cartItems = [];
  bool userStatus = false;
  var user;
  SubServiceResponseModel? _subServiceList;
  void refreshServices(String slug) {
    _subServiceBloc = sl<SubServiceBloc>()
      ..add(
        GetSubServiceEvent(
          SubServiceEntity(slug),
        ),
      );

    _subServiceBloc.add(GetCartEvent());
  }

  _getUserStatus() async {
    userStatus = await UserHelpers.getUserDetails() != false;
    if (userStatus) {
      user = await UserHelpers.getUserDetails();
    }
  }

  @override
  void initState() {
    refreshServices(widget.arguements['slug']);
    _isSubServiceLoading = true;
    _getUserStatus();

    super.initState();
  }

  int getCartCount(SubServiceModel item) {
    CartItemModel cartItem = cart.firstWhere((cart) => cart.name == item.name,
        orElse: () =>
            CartItemModel(itemId: '', name: '', amount: 0, qty: 0, image: ''));
    return cartItem.qty;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _subServiceBloc,
      child: BlocListener<SubServiceBloc, SubServiceState>(
        bloc: _subServiceBloc,
        listener: (context, state) {
          if (state is SubServiceLoadingState) {
            _isSubServiceLoading = true;
          }
          if (state is SubServiceSuccessState) {
            _isSubServiceLoading = false;
            _subServiceList = state.subServiceResponseModel;
          }
          if (state is SubServiceFailureState) {
            _isSubServiceLoading = false;
            UIHelper.showToast(msg: state.errorMessage, type: ToastType.Alert);
          }
          if (state is GetCartState) {
            cart = state.cart.items;
          }
          if (state is AddedToCartState) {
            CustomNavigator.pushTo(context, AppPages.cartPage);
          }
        },
        child: BlocBuilder<SubServiceBloc, SubServiceState>(
          builder: (context, state) {
            return WillPopScope(
              onWillPop: () async {
                await _handleOnlineAddToCart(true);
                return true;
              },
              child: Scaffold(
                // floatingActionButton: InkWell(
                //   onTap: () {
                //     CustomNavigator.pushTo(context, AppPages.cartPage);
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(20),
                //         color: AppColors.primary),
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 16.0, vertical: 16),
                //       child: Text("🛒 Go to Cart ",
                //           style: AppTextStyles.buttonTextStyle
                //               .copyWith(fontSize: 18)),
                //     ),
                //   ),
                // ),
                appBar: AppBar(
                  centerTitle: false,
                  actions: [
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {
                              if (userStatus) {
                                _handleOnlineAddToCart(false);
                              } else {
                                CustomNavigator.pushTo(
                                    context, AppPages.cartPage);
                              }
                            },
                            child: const Icon(Icons.shopping_bag)),
                      ),
                    ),
                  ],
                  title: Text(widget.arguements['title'],
                      style: AppTextStyles.textStyleHeebo16w500Secondary
                          .copyWith(fontSize: 20)),
                ),
                body: !_isSubServiceLoading
                    ? _buildSubServices()
                    : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: _buildServicePlaceholder(),
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  _handleOnlineAddToCart(bool isBackTap) {
    _subServiceBloc.add(AddToCartEvent(
        entity: AddToCartEntity(
            cartData: _cartItems,
            userKey: user.userKey,
            isFromBackTap: isBackTap)));
  }

  _handleOfflineAddToCart(SubServiceModel item) async {
    ShoppingCartHelper.addToCart(CartItem(
        itemId: item.id,
        name: item.name,
        image: item.slider_1,
        amount: int.parse(item.amount ?? " 0"),
        qty: 1));
  }

  _buildSubServices() => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _subServiceList != null
                      ? _subServiceList!.subservices.length
                      : 0,
                  itemBuilder: (context, index) {
                    SubServiceModel item = _subServiceList!.subservices[index];
                    int cartItemCount = getCartCount(item);

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: SubServiceListTile(
                        subServiceModel: _subServiceList!.subservices[index],
                        onAddTap: () async {
                          if (!userStatus) {
                            _handleOfflineAddToCart(item);
                          } else {
                            _cartItems.add(CartItemModel(
                                itemId: item.id,
                                name: item.name,
                                amount: int.parse(item.amount),
                                qty: 1,
                                image: item.slider_1));
                          }

                          // _subServiceBloc.add(
                          //   GetCartEvent(),
                          // );
                        },
                        onQtyUpdate: (qty) {
                          print("this is $qty");
                          try {
                            if (!userStatus) {
                              ShoppingCartHelper.updateItem(item.id, qty);
                            } else {
                              if (qty == 0) {
                                _cartItems.remove(_cartItems[index]);
                              } else {
                                _cartItems[index].qty = qty;
                                print(_cartItems.toString());
                              }
                            }
                            // _subServiceBloc.add(
                            //   GetCartEvent(),
                            // );
                          } catch (e) {
                            print(e);
                          }
                        },
                        qty: cartItemCount,
                      ),
                    );
                  }),
            ),
          ],
        ),
      );

  Widget _buildServicePlaceholder() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 396.w,
            height: 125.h, // Re
            margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
