import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/setpin-buttons/setpin_buttons_state.dart';

class SetpinButtonsCubit extends Cubit<SetpinButtonsState>{
  SetpinButtonsCubit(): super(SetpinButtonsState.initial());
  clearPin(){
    emit(SetpinButtonsState.initial());
  }
  setPin1(String pin){
    print(pin);
    emit(state.copyWith(pin1: pin));
  }

  setPin2(String pin){
    emit(state.copyWith(pin2: pin));
  }

  setPin3(String pin){
    emit(state.copyWith(pin3: pin));
  }

  setPin4(String pin){
    emit(state.copyWith(pin4: pin));
  }
}