// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setpin_buttons_state.freezed.dart';

@freezed
abstract class SetpinButtonsState with _$SetpinButtonsState {
  const factory SetpinButtonsState({
    required String pin1,
    required String pin2,
    required String pin3,
    required String pin4,
    required bool isPincorrect,
  }) = _SetpinButtonsState;

  factory SetpinButtonsState.initial() {
    return SetpinButtonsState(
      pin1: '',
      pin2: '',
      pin3: '',
      pin4: '',
      isPincorrect: false
    );
  }
}
