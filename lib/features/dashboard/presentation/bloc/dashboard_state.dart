part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardTabChangeState extends DashboardState {
  final int index;
  const DashboardTabChangeState({required this.index});
}

class DashboardUpdatedState extends DashboardState {
  const DashboardUpdatedState();
}

class DashboardErrorState extends DashboardState {
  final String errorMessage;

  const DashboardErrorState({required this.errorMessage});
}
