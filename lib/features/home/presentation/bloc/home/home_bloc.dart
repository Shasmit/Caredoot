import 'package:bloc/bloc.dart';
import 'package:caredoot/features/home/domain/usecases/service_usecase.dart';
import 'package:caredoot/features/home/presentation/bloc/home/home_event.dart';

import '../../../../../core/constants/usecase/usecase_interface.dart';

import '../../../domain/usecases/get_Categories_UseCase.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CategoryUsecase categoryUsecase;
  final ServiceUsecase serviceUsecase;

  HomeBloc({required this.categoryUsecase, required this.serviceUsecase})
      : super(CategoryInitial()) {
    on<GetAllCategoriesEvent>((event, emit) async {
      emit(CategoryLoadingState());
      final result = await categoryUsecase(NoParams());
      result.fold((failure) {
        emit(CategoryLoadedFailureState(failure.toString()));
      }, (loaded) {
        emit(CategoryLoadedSuccessfullState(loaded));
      });
    });

    on<GetAllServicesEvent>((event, emit) async {
      emit(ServiceLoadingState());
      final result = await serviceUsecase(NoParams());

      result.fold((failure) {
        emit(ServiceLoadedFailureState(failure.toString()));
      }, (loaded) {
        emit(ServiceLoadedSuccessfullState(loaded));
      });
    });
  }
}
