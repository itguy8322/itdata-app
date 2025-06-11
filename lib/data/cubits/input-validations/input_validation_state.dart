import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/email-input.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/name_input.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/number_input.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/password_input.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/text_input.dart';

part 'input_validation_state.freezed.dart';

@freezed
abstract class InputValidationState with _$InputValidationState {
  const factory InputValidationState({
    required NameInput nameInput,
    required EmailInput emailInput,
    required TextInput textInput,
    required NumberInput numberInput,
    required PasswordInput passwordInput,
    required bool isValid,
  }) = _InputValidationState;

  factory InputValidationState.initial() {
    return InputValidationState(
      nameInput: NameInput(value: '', error: null, isValid: false),
      emailInput: EmailInput(value: '', error: null, isValid: false),
      textInput: TextInput(value: '', error: null, isValid: false),
      numberInput: NumberInput(value: '', error: null, isValid: false),
      passwordInput: PasswordInput(value: '', error: null, isValid: false),
      isValid: false,
    );
  }
}
