import 'package:bloc/bloc.dart';
import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:caredoot/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:caredoot/features/home/domain/usecases/addtocart_usecase.dart';

import 'package:caredoot/features/home/presentation/bloc/subservices/subservice_event.dart';
import 'package:caredoot/features/home/presentation/bloc/subservices/subservice_state.dart';

import '../../../../../core/constants/value_constants.dart';
import '../../../../../core/helpers/ui_helpers.dart';

import '../../../domain/usecases/subservice_usecase.dart';

class SubServiceBloc extends Bloc<SubServiceEvent, SubServiceState> {
  final SubServiceUseCase subServiceUseCase;
  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;

  SubServiceBloc(
      {required this.subServiceUseCase,
      required this.getCartUseCase,
      required this.addToCartUseCase})
      : super(SubServiceInitial()) {
    on<GetSubServiceEvent>(
      (event, emit) async {
        UIHelper.showLoader();
        emit(const SubServiceLoadingState());
        final result = await subServiceUseCase(event.entity);
        UIHelper.hideLoader();
        result.fold((failure) {
          UIHelper.showToast(
              msg: failure.message.toString(), type: ToastType.Error);
          emit(SubServiceFailureState(failure.message.toString()));
        }, (loaded) {
          emit(SubServiceSuccessState(loaded));
        });
      },
    );
    on<GetCartEvent>(
      (event, emit) async {
        UIHelper.showLoader();
        emit(const GetCartLoadingState());
        final result = await getCartUseCase(NoParams());
        UIHelper.hideLoader();
        result.fold((failure) {
          UIHelper.showToast(msg: failure.toString(), type: ToastType.Error);
          emit(GetCartFailureState(failure.toString()));
        }, (loaded) {
          emit(GetCartState(loaded));
        });
      },
    );
    on<AddToCartEvent>((event, emit) async {
      UIHelper.showLoader();
      final result = await addToCartUseCase(event.entity);
      UIHelper.hideLoader();
      result.fold((failure) {
        UIHelper.showToast(msg: failure.toString(), type: ToastType.Error);
      }, (loaded) {
        if (event.entity.isFromBackTap) {
          emit(FlushState());
        } else {
          emit(FlushState());
          print("Cart loaded");
          emit(AddedToCartState(response: loaded));
        }
      });
    });
  }
}
