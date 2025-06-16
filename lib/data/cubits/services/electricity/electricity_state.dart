import 'package:freezed_annotation/freezed_annotation.dart';

part 'electricity_state.freezed.dart';

@freezed
abstract class ElectricityState with _$ElectricityState {
  const factory ElectricityState({
    required List<dynamic> elecPlans,
    required String discoName,
    required String type,
    required String meterNumber,
    required String amount,
    required String number,
    required bool trnxInProcess,
    required bool trnxSuccess,
    required bool trnxFailure

  }) = _ElectricityState;

  factory ElectricityState.initial(){
    return ElectricityState(
      elecPlans: [],
      discoName: '',
      type: '',
      meterNumber: '',
      amount: '',
      number: '',
      trnxFailure: false,
      trnxInProcess: false,
      trnxSuccess: false);
  }
}