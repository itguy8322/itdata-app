import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/services/airtime/airtime_state.dart';
import 'package:itdata/services/service_plans.dart';
import 'package:itdata/services/purchase_service.dart';


class AirtimeCubit extends Cubit<AirtimeState>{
  final PurchaseService _purchaseService;
  AirtimeCubit(this._purchaseService): super(AirtimeState.initial());

  

  void reset() {
    emit(AirtimeState.initial());
  }
  loadAirtimeTypes() async {
    final airtimeTypes = await ServicePlans().loadAirtimeTypes();
    emit(state.copyWith(airtimeTypes: airtimeTypes));
  }
  onProviderSelected(int provider){
    emit(state.copyWith(provider: provider));
    //print(state.provider);
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

  purchaseAirtime() async {
    emit(state.copyWith(trnxInProcess: true,
    trnxFailure: false,
    trnxSuccess: false));
    try{
      final response = await _purchaseService.purchaseAirtime(
        state.provider,
        int.parse(state.amount),
        state.number,
        state.type
      );
      emit(state.copyWith(trnxInProcess: false,
      trnxFailure: false,
      trnxSuccess: true));
      //print("====== SUCCESS =======");
    }catch(e){
      emit(state.copyWith(trnxInProcess: false,
    trnxFailure: true,
    trnxSuccess: false));
    }
  }
}