import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/services/edu/edu_state.dart';
import 'package:itdata/services/service_plans.dart';

class EduCubit extends Cubit<EduState>{
  EduCubit(): super(EduState.initial());
  void reset() {
    emit(EduState.initial());
  }
  loadExamTypes() async {
    final examsTypes = await ServicePlans().loadExamTypes();
    emit(state.copyWith(examsTypes: examsTypes));
  }
  onQuantitySelected(String quantity){
    emit(state.copyWith(quantity: quantity));
    //print(state.quantity);
  }
  onTypeSelected(String exam){
    emit(state.copyWith(exam: exam));
  }

  onNumberEntered(String number){
    emit(state.copyWith(number: number));
  }

  purchasExamPin(){
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