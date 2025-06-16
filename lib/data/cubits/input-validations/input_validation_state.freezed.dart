// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input_validation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InputValidationState {

 NameInput get nameInput; EmailInput get emailInput; TextInput get textInput; NumberInput get numberInput; PasswordInput get passwordInput; bool get isValid;
/// Create a copy of InputValidationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InputValidationStateCopyWith<InputValidationState> get copyWith => _$InputValidationStateCopyWithImpl<InputValidationState>(this as InputValidationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputValidationState&&(identical(other.nameInput, nameInput) || other.nameInput == nameInput)&&(identical(other.emailInput, emailInput) || other.emailInput == emailInput)&&(identical(other.textInput, textInput) || other.textInput == textInput)&&(identical(other.numberInput, numberInput) || other.numberInput == numberInput)&&(identical(other.passwordInput, passwordInput) || other.passwordInput == passwordInput)&&(identical(other.isValid, isValid) || other.isValid == isValid));
}


@override
int get hashCode => Object.hash(runtimeType,nameInput,emailInput,textInput,numberInput,passwordInput,isValid);

@override
String toString() {
  return 'InputValidationState(nameInput: $nameInput, emailInput: $emailInput, textInput: $textInput, numberInput: $numberInput, passwordInput: $passwordInput, isValid: $isValid)';
}


}

/// @nodoc
abstract mixin class $InputValidationStateCopyWith<$Res>  {
  factory $InputValidationStateCopyWith(InputValidationState value, $Res Function(InputValidationState) _then) = _$InputValidationStateCopyWithImpl;
@useResult
$Res call({
 NameInput nameInput, EmailInput emailInput, TextInput textInput, NumberInput numberInput, PasswordInput passwordInput, bool isValid
});




}
/// @nodoc
class _$InputValidationStateCopyWithImpl<$Res>
    implements $InputValidationStateCopyWith<$Res> {
  _$InputValidationStateCopyWithImpl(this._self, this._then);

  final InputValidationState _self;
  final $Res Function(InputValidationState) _then;

/// Create a copy of InputValidationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nameInput = null,Object? emailInput = null,Object? textInput = null,Object? numberInput = null,Object? passwordInput = null,Object? isValid = null,}) {
  return _then(_self.copyWith(
nameInput: null == nameInput ? _self.nameInput : nameInput // ignore: cast_nullable_to_non_nullable
as NameInput,emailInput: null == emailInput ? _self.emailInput : emailInput // ignore: cast_nullable_to_non_nullable
as EmailInput,textInput: null == textInput ? _self.textInput : textInput // ignore: cast_nullable_to_non_nullable
as TextInput,numberInput: null == numberInput ? _self.numberInput : numberInput // ignore: cast_nullable_to_non_nullable
as NumberInput,passwordInput: null == passwordInput ? _self.passwordInput : passwordInput // ignore: cast_nullable_to_non_nullable
as PasswordInput,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _InputValidationState implements InputValidationState {
  const _InputValidationState({required this.nameInput, required this.emailInput, required this.textInput, required this.numberInput, required this.passwordInput, required this.isValid});
  

@override final  NameInput nameInput;
@override final  EmailInput emailInput;
@override final  TextInput textInput;
@override final  NumberInput numberInput;
@override final  PasswordInput passwordInput;
@override final  bool isValid;

/// Create a copy of InputValidationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InputValidationStateCopyWith<_InputValidationState> get copyWith => __$InputValidationStateCopyWithImpl<_InputValidationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InputValidationState&&(identical(other.nameInput, nameInput) || other.nameInput == nameInput)&&(identical(other.emailInput, emailInput) || other.emailInput == emailInput)&&(identical(other.textInput, textInput) || other.textInput == textInput)&&(identical(other.numberInput, numberInput) || other.numberInput == numberInput)&&(identical(other.passwordInput, passwordInput) || other.passwordInput == passwordInput)&&(identical(other.isValid, isValid) || other.isValid == isValid));
}


@override
int get hashCode => Object.hash(runtimeType,nameInput,emailInput,textInput,numberInput,passwordInput,isValid);

@override
String toString() {
  return 'InputValidationState(nameInput: $nameInput, emailInput: $emailInput, textInput: $textInput, numberInput: $numberInput, passwordInput: $passwordInput, isValid: $isValid)';
}


}

/// @nodoc
abstract mixin class _$InputValidationStateCopyWith<$Res> implements $InputValidationStateCopyWith<$Res> {
  factory _$InputValidationStateCopyWith(_InputValidationState value, $Res Function(_InputValidationState) _then) = __$InputValidationStateCopyWithImpl;
@override @useResult
$Res call({
 NameInput nameInput, EmailInput emailInput, TextInput textInput, NumberInput numberInput, PasswordInput passwordInput, bool isValid
});




}
/// @nodoc
class __$InputValidationStateCopyWithImpl<$Res>
    implements _$InputValidationStateCopyWith<$Res> {
  __$InputValidationStateCopyWithImpl(this._self, this._then);

  final _InputValidationState _self;
  final $Res Function(_InputValidationState) _then;

/// Create a copy of InputValidationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameInput = null,Object? emailInput = null,Object? textInput = null,Object? numberInput = null,Object? passwordInput = null,Object? isValid = null,}) {
  return _then(_InputValidationState(
nameInput: null == nameInput ? _self.nameInput : nameInput // ignore: cast_nullable_to_non_nullable
as NameInput,emailInput: null == emailInput ? _self.emailInput : emailInput // ignore: cast_nullable_to_non_nullable
as EmailInput,textInput: null == textInput ? _self.textInput : textInput // ignore: cast_nullable_to_non_nullable
as TextInput,numberInput: null == numberInput ? _self.numberInput : numberInput // ignore: cast_nullable_to_non_nullable
as NumberInput,passwordInput: null == passwordInput ? _self.passwordInput : passwordInput // ignore: cast_nullable_to_non_nullable
as PasswordInput,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
