import 'package:bloc/bloc.dart';
import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:caredoot/core/helpers/shopping_cart_helper.dart';
import 'package:caredoot/core/helpers/ui_helpers.dart';
import 'package:caredoot/core/helpers/utils.dart';
import 'package:caredoot/features/cart/data/models/address_response_model.dart';
import 'package:caredoot/features/cart/data/models/cart_response_model.dart';
import 'package:caredoot/features/cart/data/models/coupon_response_model.dart';
import 'package:caredoot/features/cart/data/models/order_response_model.dart';
import 'package:caredoot/features/cart/domain/entities/address_entity.dart';
import 'package:caredoot/features/cart/domain/entities/coupon_entity.dart';
import 'package:caredoot/features/cart/domain/entities/delete_entity.dart';
import 'package:caredoot/features/cart/domain/entities/order_entity.dart';
import 'package:caredoot/features/cart/domain/entities/quantity_update_entity.dart';
import 'package:caredoot/features/cart/domain/usecases/add_address_usecase.dart';
import 'package:caredoot/features/cart/domain/usecases/coupon_usecase.dart';
import 'package:caredoot/features/cart/domain/usecases/create_order_usecase.dart';
import 'package:caredoot/features/cart/domain/usecases/get_addresses_usecase.dart';
import 'package:caredoot/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:caredoot/features/home/data/models/cart_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/value_constants.dart';
import '../../../domain/usecases/deleteItem_usecase.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUseCase getCartUseCase;
  final DeleteItemFromCartUseCase deleteItemFromCartUseCase;
  final CouponUseCase couponUseCase;
  final AddAddressUseCase addAddressUseCase;
  final GetAddressesUseCase getAddressUsecase;
  final CreateOrderUsecase createOrderUsecase;

  _refreshCart(Emitter emit) {
    List<CartItem> cartItems = ShoppingCartHelper.getCart();
    var items = cartItems.map((e) => CartItemModel.fromMap(e.toMap())).toList();
    emit(CartRefereshedState(
        cartResponseModel: CartResponseModel(userKey: 'key', items: items)));
  }

  CartBloc(
      {required this.getCartUseCase,
      required this.deleteItemFromCartUseCase,
      required this.couponUseCase,
      required this.getAddressUsecase,
      required this.createOrderUsecase,
      required this.addAddressUseCase})
      : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CartInit>(
      (event, emit) async {
        final result = await getCartUseCase(NoParams());
        result.fold((failure) {
          emit(CartFailureState(failure.toString()));
        }, (loaded) {
          emit(CartLoadedState(loaded));
        });
      },
    );
    on<SaveAddressEvent>(_onSaveAddress);
    on<GetMyAddressesEvent>(_getAllAddresses);
    on<ProcessCODPaymentEvent>(_processCodePayment);
    on<QuantityUpdateEvent>(
      (event, emit) async {
        await ShoppingCartHelper.updateItem(
            event.entity.itemId, event.entity.qty);
        _refreshCart(emit);
      },
    );
    on<DeleteItemFromCartEvent>(
      (event, emit) async {
        if (await Utils.isUserLoggedIn()) {
          // Use usecase
        } else {
          deleteItemFromCartUseCase(event.entity);
          _refreshCart(emit);
        }
      },
    );
    on<RefreshCartEvent>((event, emit) {});

    on<GetCouponDiscountEvent>(
      (event, emit) async {
        emit(const CouponLoadingState());

        final result = await couponUseCase(event.entity);

        result.fold((failure) {
          UIHelper.showToast(
              msg: failure.message.toString(), type: ToastType.Error);
          emit(CouponFailureState(failure.message.toString()));
        }, (loaded) {
          emit(CouponSuccessState(loaded));
        });
      },
    );

    on<CouponRemoveEvent>(
      (event, emit) async {
        emit(RemoveCouponState());
      },
    );
    on<UpdateDefaultAddressCheckBoxEvent>((event, emit) {
      emit(UpdateDefaultAddressCheckBoxState(event.value));
    });
  }
  _onSaveAddress(SaveAddressEvent event, Emitter<CartState> emit) async {
    final result = await addAddressUseCase(event.addressEntity);
    result.fold((failure) {
      emit(CartFailureState(failure.toString()));
    }, (loaded) {
      emit(AddressSavedState(loaded));
    });
  }

  _getAllAddresses(GetMyAddressesEvent event, Emitter<CartState> emit) async {
    final result = await getAddressUsecase(NoParams());
    result.fold((failure) {
      emit(CartFailureState(failure.toString()));
    }, (loaded) {
      emit(AddressesLoadedState(loaded));
    });
  }

  _processCodePayment(
      ProcessCODPaymentEvent event, Emitter<CartState> emit) async {
    final result = await createOrderUsecase(event.entity);
    result.fold((failure) {
      emit(CartFailureState(failure.toString()));
    }, (loaded) {
      emit(OrderPlacedSuccessState(loaded));
    });
  }

  _createOrder() {}
}
