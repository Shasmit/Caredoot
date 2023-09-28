part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardTabChangeEvent extends DashboardEvent {
  final int index;
  const DashboardTabChangeEvent({required this.index});
}

class DashboardGetAgentDetailsEvent extends DashboardEvent {
  const DashboardGetAgentDetailsEvent();
}
