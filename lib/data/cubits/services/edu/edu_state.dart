import 'package:freezed_annotation/freezed_annotation.dart';

part 'edu_state.freezed.dart';

@freezed
abstract class EduState with _$EduState {
  const factory EduState({
    required Map<String, dynamic> examsTypes,
    required String exam,
    required String quantity,
    required String price,
    required String number,
    required bool trnxInProcess,
    required bool trnxSuccess,
    required bool trnxFailure

  }) = _EduState;

  factory EduState.initial(){
    return EduState(
      examsTypes: {},
      exam: '',
      quantity: '',
      price: '',
      number: '',
      trnxFailure: false,
      trnxInProcess: false,
      trnxSuccess: false);
  }
}