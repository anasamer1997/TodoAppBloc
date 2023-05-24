import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/bloc/bloc_export.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends HydratedBloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(SwitchInitial(switchValue: false)) {
    on<switchToDark>((event, emit) {
      emit(const SwitchState(switchValue: true));
    });
    on<switchToLight>((event, emit) {
      emit(const SwitchState(switchValue: false));
    });
  }

  @override
  SwitchState? fromJson(Map<String, dynamic> json) {
    return SwitchState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SwitchState state) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
