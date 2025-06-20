import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/services/electricity/electricity_state.dart';
import 'package:itdata/services/service_plans.dart';

class ElectricityCubit extends Cubit<ElectricityState>{
  ElectricityCubit(): super(ElectricityState.initial());
  void reset() {
    emit(ElectricityState.initial());
  }
  loadDiscos() async {
    final discos = await ServicePlans().loadDiscos();
    emit(state.copyWith(elecPlans: discos));
  }

  onDiscNameSelected(String name){
    emit(state.copyWith(discoName: name));
  }

  onTypeSelected(String type){
    emit(state.copyWith(type: type));
  }

  onNumberEntered(String number){
    emit(state.copyWith(number: number));
  }

  onMeterNumber(String meterNumber){
    emit(state.copyWith(meterNumber: meterNumber));
  }

  onAmountChanged(String amount){
    emit(state.copyWith(amount: amount));
  }

  purchaseElectricityBill(){
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