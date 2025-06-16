import 'package:freezed_annotation/freezed_annotation.dart';

part 'cable_state.freezed.dart';

@freezed
abstract class CableState with _$CableState {
  const factory CableState({
    required Map<String, dynamic> cableplans,
    required String cable,
    required String type,
    required String iucNumber,
    required String planId,
    required String price,
    required String number,
    required bool trnxInProcess,
    required bool trnxSuccess,
    required bool trnxFailure

  }) = _CableState;

  factory CableState.initial(){
    return CableState(
      cableplans: {},
      cable: '',
      type: '',
      iucNumber: '',
      planId: '',
      price: '',
      number: '',
      trnxFailure: false,
      trnxInProcess: false,
      trnxSuccess: false);
  }
}