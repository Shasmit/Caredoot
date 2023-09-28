import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/usecase/usecase_interface.dart';
import '../../../../../core/error/failure.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardTabChangeEvent>((event, emit) {
      emit(DashboardTabChangeState(index: event.index));
      emit(const DashboardUpdatedState());
    });
  }
}
