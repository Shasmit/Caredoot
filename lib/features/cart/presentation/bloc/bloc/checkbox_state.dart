import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CheckboxEvent {}

class ToggleCheckboxEvent extends CheckboxEvent {
  final bool isChecked;

  ToggleCheckboxEvent(this.isChecked);
}

// State
abstract class CheckboxState {}

class CheckboxInitialState extends CheckboxState {}

class CheckboxUpdatedState extends CheckboxState {
  final bool isChecked;

  CheckboxUpdatedState(this.isChecked);
}

class CheckboxBloc extends Bloc<CheckboxEvent, CheckboxState> {
  CheckboxBloc() : super(CheckboxInitialState());

  @override
  Stream<CheckboxState> mapEventToState(CheckboxEvent event) async* {
    if (event is ToggleCheckboxEvent) {
      yield CheckboxUpdatedState(event.isChecked);
    }
  }
}
