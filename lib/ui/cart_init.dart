import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:caredoot/features/cart/data/models/cart_response_model.dart';
import 'package:caredoot/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:caredoot/main.dart';
import 'package:get_it/get_it.dart';

Future<void> init() async {
  final getIt = GetIt.instance;
  final useCase = getIt<GetCartUseCase>();
  await useCase.call(NoParams()).then((entity) {
    CartResponseModel cartResponseModel =
        entity.getOrElse(() => CartResponseModel(userKey: '', items: []));
    if (entity.isRight()) {
      cart = cartResponseModel.items;
    } else if (entity.isLeft()) {
      // Failure failure = entity.fold((failure) => failure);
      // if (failure != null) {

      // }
    }
  }).catchError((error) {
    print(error);
  });
}
