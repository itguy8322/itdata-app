import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/services/cable/cable_state.dart';
import 'package:itdata/services/service_plans.dart';

class CableCubit extends Cubit<CableState>{
  CableCubit(): super(CableState.initial());
  reInitialize(){
    emit(state.copyWith(
      number: '',
      cable: '',
      planId: '',
      price: '',
      iucNumber: '',
      type: ''
    ));
  }
  void reset() {
    emit(CableState.initial());
  }
  loadCablePlans() async {
    final cableplans = await ServicePlans().loadCablePlans();
    emit(state.copyWith(cableplans: cableplans));
  }
  onCableSelected(String cable){
    emit(state.copyWith(cable: cable, planId: '', price: '', iucNumber: '', type: ''));
    //print(state.cable);
  }
  onCablePlanSelected(String plan){
    emit(state.copyWith(planId: plan));
  }

  onNumberEntered(String number){
    emit(state.copyWith(number: number));
  }

  onIUCNumber(String iucNumber){
    emit(state.copyWith(iucNumber: iucNumber));
    //print("========= IUC Number ==========");
    //print(state.iucNumber);
    //print("========= IUC Number ==========");
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