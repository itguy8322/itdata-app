import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

@freezed
abstract class DataState with _$DataState {
  const factory DataState({
    required Map<String, dynamic> dataplans,
    required String provider,
    required String type,
    required String planId,
    required String price,
    required String number,
    required bool trnxInProcess,
    required bool trnxSuccess,
    required bool trnxFailure

  }) = _DataState;

  factory DataState.initial(){
    return DataState(
      dataplans: {},
      provider: '',
      type: '',
      planId: '',
      price: '',
      number: '',
      trnxFailure: false,
      trnxInProcess: false,
      trnxSuccess: false);
  }
}