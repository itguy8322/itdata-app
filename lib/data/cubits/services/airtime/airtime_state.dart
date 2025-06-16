// ignore_for_file: depend_on_referenced_packages

import 'package:freezed_annotation/freezed_annotation.dart';

part 'airtime_state.freezed.dart';

@freezed
abstract class AirtimeState with _$AirtimeState {
  const factory AirtimeState({
    required List<String> airtimeTypes,
    required String provider,
    required String type,
    required String number,
    required String amount,  
    required bool trnxInProcess,
    required bool trnxSuccess,
    required bool trnxFailure

  }) = _AirtimeState;

  factory AirtimeState.initial(){
    return AirtimeState(
      airtimeTypes: [],
      provider: '',
      type: '',
      number: '',
      amount: '',
      trnxFailure: false,
      trnxInProcess: false,
      trnxSuccess: false);
  }
}