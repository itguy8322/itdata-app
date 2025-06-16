import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/services/cable/cable_state.dart';
import 'package:itdata/services/service_plans.dart';

class CableCubit extends Cubit<CableState>{
  CableCubit(): super(CableState.initial());
  loadCablePlans() async {
    final cableplans = await ServicePlans().loadCablePlans();
    emit(state.copyWith(cableplans: cableplans));
  }
  onCableSelected(String cable){
    emit(state.copyWith(cable: cable));
    print(state.cable);
  }
  onCablePlanSelected(String plan){
    emit(state.copyWith(planId: plan));
  }

  onNumberEntered(String number){
    emit(state.copyWith(number: number));
  }

  onIUCNumber(String planId){
    emit(state.copyWith(planId: planId));
  }

  purchaseTVSubscription(){
    emit(state.copyWith(trnxInProcess: true,
    trnxFailure: false,
    trnxSuccess: false));
    try{
      emit(state.copyWith(trnxInProcess: false,
      trnxFailure: false,
      trnxSuccess: true));
    }catch(e){
      emit(state.copyWith(trnxInProcess: false,
    trnxFailure: true,
    trnxSuccess: false));
    }
  }
}