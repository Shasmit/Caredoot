import 'package:bloc/bloc.dart';
import 'package:caredoot/features/home/presentation/bloc/service/service_event.dart';
import 'package:caredoot/features/home/presentation/bloc/service/service_state.dart';

import '../../../../../core/constants/value_constants.dart';
import '../../../../../core/helpers/ui_helpers.dart';
import '../../../domain/usecases/subcategory_usecase.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final SubCategoryUseCase subCategoryUseCase;

  ServiceBloc({required this.subCategoryUseCase})
      : super(SubCategoryInitial()) {
    on<GetSubCategoryEvent>(
      (event, emit) async {
        UIHelper.showLoader();
        emit(const SubCategoryLoadingState());
        final result = await subCategoryUseCase(event.entity);
        UIHelper.hideLoader();
        result.fold((failure) {
          UIHelper.showToast(msg: failure.toString(), type: ToastType.Error);
          emit(SubCategoryFailureState(failure.toString()));
        }, (loaded) {
          emit(SubCategorySuccessState(loaded));
        });
      },
    );
  }
}
