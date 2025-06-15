import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/services/data/data_state.dart';
import 'package:itdata/services/service_plans.dart';

class DataCubit extends Cubit<DataState>{
  DataCubit(): super(DataState.initial());
  reInitialize(){
    emit(state.copyWith(
      number: '',
      planId: '',
      price: '',
      provider: '',
      type: ''
    ));
  }
  loadDataPlans() async {
    final dataplans = await ServicePlans().loadDataPlans();
    emit(state.copyWith(dataplans: dataplans));
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

  onPlanIdSelected(String planId){
    emit(state.copyWith(planId: planId));
  }

  purchaseData(){
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