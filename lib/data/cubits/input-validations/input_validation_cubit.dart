import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/email-input.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/name_input.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/number_input.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/password_input.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/text_input.dart';
import 'package:itdata/data/cubits/input-validations/input_validation_state.dart';

class InputValidationCubit extends Cubit<InputValidationState> {
  InputValidationCubit() : super(InputValidationState.initial());

  void reInitialize() {
    emit(InputValidationState.initial());
  }

  void onNameInputChanged(String value) {
    final name = NameInput(value: value);
    name.validate();
    emit(state.copyWith(nameInput: name));
  }

  void onEamilInputChanged(String value) {
    final email = EmailInput(value: value);
    email.validate();
    emit(state.copyWith(emailInput: email));
    //print(state.emailInput.isValid);
  }

  void onTextInputChanged(String value) {
    final text = TextInput(value: value);
    text.validate();
    emit(state.copyWith(textInput: text));
  }

  void onNumberInputChanged(String value) {
    final number = NumberInput(value: value);
    number.validate();
    emit(state.copyWith(numberInput: number));
  }

  void onPasswordInputChanged(String value) {
    final password = PasswordInput(value: value);
    password.validate();
    emit(state.copyWith(passwordInput: password));
    //print(state.passwordInput.isValid);
  }
}
