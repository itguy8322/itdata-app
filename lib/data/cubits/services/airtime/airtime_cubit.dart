import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/services/airtime/airtime_state.dart';
import 'package:itdata/services/service_plans.dart';


class AirtimeCubit extends Cubit<AirtimeState>{
  AirtimeCubit(): super(AirtimeState.initial());

  loadAirtimeTypes() async {
    final airtimeTypes = await ServicePlans().loadAirtimeTypes();
    emit(state.copyWith(airtimeTypes: airtimeTypes));
  }
  onProviderSelected(String provider){
    emit(state.copyWith(provider: provider));
    print(state.provider);
  }
  onTypeSelected(String type){
    emit(state.copyWith(type: type));
  }

  onNumberEntered(String number){
    emit(state.copyWith(number: number));
  }

  onAmountChanged(String amount){
    emit(state.copyWith(amount: amount));
  }

  setData(){}

  purchaseAirtime(){
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