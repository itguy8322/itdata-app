// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edu_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EduState {

 Map<String, dynamic> get examsTypes; String get exam; String get quantity; String get price; String get number; bool get trnxInProcess; bool get trnxSuccess; bool get trnxFailure;
/// Create a copy of EduState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EduStateCopyWith<EduState> get copyWith => _$EduStateCopyWithImpl<EduState>(this as EduState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EduState&&const DeepCollectionEquality().equals(other.examsTypes, examsTypes)&&(identical(other.exam, exam) || other.exam == exam)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.price, price) || other.price == price)&&(identical(other.number, number) || other.number == number)&&(identical(other.trnxInProcess, trnxInProcess) || other.trnxInProcess == trnxInProcess)&&(identical(other.trnxSuccess, trnxSuccess) || other.trnxSuccess == trnxSuccess)&&(identical(other.trnxFailure, trnxFailure) || other.trnxFailure == trnxFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(examsTypes),exam,quantity,price,number,trnxInProcess,trnxSuccess,trnxFailure);

@override
String toString() {
  return 'EduState(examsTypes: $examsTypes, exam: $exam, quantity: $quantity, price: $price, number: $number, trnxInProcess: $trnxInProcess, trnxSuccess: $trnxSuccess, trnxFailure: $trnxFailure)';
}


}

/// @nodoc
abstract mixin class $EduStateCopyWith<$Res>  {
  factory $EduStateCopyWith(EduState value, $Res Function(EduState) _then) = _$EduStateCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> examsTypes, String exam, String quantity, String price, String number, bool trnxInProcess, bool trnxSuccess, bool trnxFailure
});




}
/// @nodoc
class _$EduStateCopyWithImpl<$Res>
    implements $EduStateCopyWith<$Res> {
  _$EduStateCopyWithImpl(this._self, this._then);

  final EduState _self;
  final $Res Function(EduState) _then;

/// Create a copy of EduState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? examsTypes = null,Object? exam = null,Object? quantity = null,Object? price = null,Object? number = null,Object? trnxInProcess = null,Object? trnxSuccess = null,Object? trnxFailure = null,}) {
  return _then(_self.copyWith(
examsTypes: null == examsTypes ? _self.examsTypes : examsTypes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,exam: null == exam ? _self.exam : exam // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,trnxInProcess: null == trnxInProcess ? _self.trnxInProcess : trnxInProcess // ignore: cast_nullable_to_non_nullable
as bool,trnxSuccess: null == trnxSuccess ? _self.trnxSuccess : trnxSuccess // ignore: cast_nullable_to_non_nullable
as bool,trnxFailure: null == trnxFailure ? _self.trnxFailure : trnxFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _EduState implements EduState {
  const _EduState({required final  Map<String, dynamic> examsTypes, required this.exam, required this.quantity, required this.price, required this.number, required this.trnxInProcess, required this.trnxSuccess, required this.trnxFailure}): _examsTypes = examsTypes;
  

 final  Map<String, dynamic> _examsTypes;
@override Map<String, dynamic> get examsTypes {
  if (_examsTypes is EqualUnmodifiableMapView) return _examsTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_examsTypes);
}

@override final  String exam;
@override final  String quantity;
@override final  String price;
@override final  String number;
@override final  bool trnxInProcess;
@override final  bool trnxSuccess;
@override final  bool trnxFailure;

/// Create a copy of EduState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EduStateCopyWith<_EduState> get copyWith => __$EduStateCopyWithImpl<_EduState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EduState&&const DeepCollectionEquality().equals(other._examsTypes, _examsTypes)&&(identical(other.exam, exam) || other.exam == exam)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.price, price) || other.price == price)&&(identical(other.number, number) || other.number == number)&&(identical(other.trnxInProcess, trnxInProcess) || other.trnxInProcess == trnxInProcess)&&(identical(other.trnxSuccess, trnxSuccess) || other.trnxSuccess == trnxSuccess)&&(identical(other.trnxFailure, trnxFailure) || other.trnxFailure == trnxFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_examsTypes),exam,quantity,price,number,trnxInProcess,trnxSuccess,trnxFailure);

@override
String toString() {
  return 'EduState(examsTypes: $examsTypes, exam: $exam, quantity: $quantity, price: $price, number: $number, trnxInProcess: $trnxInProcess, trnxSuccess: $trnxSuccess, trnxFailure: $trnxFailure)';
}


}

/// @nodoc
abstract mixin class _$EduStateCopyWith<$Res> implements $EduStateCopyWith<$Res> {
  factory _$EduStateCopyWith(_EduState value, $Res Function(_EduState) _then) = __$EduStateCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> examsTypes, String exam, String quantity, String price, String number, bool trnxInProcess, bool trnxSuccess, bool trnxFailure
});




}
/// @nodoc
class __$EduStateCopyWithImpl<$Res>
    implements _$EduStateCopyWith<$Res> {
  __$EduStateCopyWithImpl(this._self, this._then);

  final _EduState _self;
  final $Res Function(_EduState) _then;

/// Create a copy of EduState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? examsTypes = null,Object? exam = null,Object? quantity = null,Object? price = null,Object? number = null,Object? trnxInProcess = null,Object? trnxSuccess = null,Object? trnxFailure = null,}) {
  return _then(_EduState(
examsTypes: null == examsTypes ? _self._examsTypes : examsTypes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,exam: null == exam ? _self.exam : exam // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,trnxInProcess: null == trnxInProcess ? _self.trnxInProcess : trnxInProcess // ignore: cast_nullable_to_non_nullable
as bool,trnxSuccess: null == trnxSuccess ? _self.trnxSuccess : trnxSuccess // ignore: cast_nullable_to_non_nullable
as bool,trnxFailure: null == trnxFailure ? _self.trnxFailure : trnxFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
