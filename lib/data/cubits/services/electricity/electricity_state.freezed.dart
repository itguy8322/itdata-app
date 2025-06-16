// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'electricity_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ElectricityState {

 List<dynamic> get elecPlans; String get discoName; String get type; String get meterNumber; String get amount; String get number; bool get trnxInProcess; bool get trnxSuccess; bool get trnxFailure;
/// Create a copy of ElectricityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElectricityStateCopyWith<ElectricityState> get copyWith => _$ElectricityStateCopyWithImpl<ElectricityState>(this as ElectricityState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElectricityState&&const DeepCollectionEquality().equals(other.elecPlans, elecPlans)&&(identical(other.discoName, discoName) || other.discoName == discoName)&&(identical(other.type, type) || other.type == type)&&(identical(other.meterNumber, meterNumber) || other.meterNumber == meterNumber)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.number, number) || other.number == number)&&(identical(other.trnxInProcess, trnxInProcess) || other.trnxInProcess == trnxInProcess)&&(identical(other.trnxSuccess, trnxSuccess) || other.trnxSuccess == trnxSuccess)&&(identical(other.trnxFailure, trnxFailure) || other.trnxFailure == trnxFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(elecPlans),discoName,type,meterNumber,amount,number,trnxInProcess,trnxSuccess,trnxFailure);

@override
String toString() {
  return 'ElectricityState(elecPlans: $elecPlans, discoName: $discoName, type: $type, meterNumber: $meterNumber, amount: $amount, number: $number, trnxInProcess: $trnxInProcess, trnxSuccess: $trnxSuccess, trnxFailure: $trnxFailure)';
}


}

/// @nodoc
abstract mixin class $ElectricityStateCopyWith<$Res>  {
  factory $ElectricityStateCopyWith(ElectricityState value, $Res Function(ElectricityState) _then) = _$ElectricityStateCopyWithImpl;
@useResult
$Res call({
 List<dynamic> elecPlans, String discoName, String type, String meterNumber, String amount, String number, bool trnxInProcess, bool trnxSuccess, bool trnxFailure
});




}
/// @nodoc
class _$ElectricityStateCopyWithImpl<$Res>
    implements $ElectricityStateCopyWith<$Res> {
  _$ElectricityStateCopyWithImpl(this._self, this._then);

  final ElectricityState _self;
  final $Res Function(ElectricityState) _then;

/// Create a copy of ElectricityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? elecPlans = null,Object? discoName = null,Object? type = null,Object? meterNumber = null,Object? amount = null,Object? number = null,Object? trnxInProcess = null,Object? trnxSuccess = null,Object? trnxFailure = null,}) {
  return _then(_self.copyWith(
elecPlans: null == elecPlans ? _self.elecPlans : elecPlans // ignore: cast_nullable_to_non_nullable
as List<dynamic>,discoName: null == discoName ? _self.discoName : discoName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,meterNumber: null == meterNumber ? _self.meterNumber : meterNumber // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,trnxInProcess: null == trnxInProcess ? _self.trnxInProcess : trnxInProcess // ignore: cast_nullable_to_non_nullable
as bool,trnxSuccess: null == trnxSuccess ? _self.trnxSuccess : trnxSuccess // ignore: cast_nullable_to_non_nullable
as bool,trnxFailure: null == trnxFailure ? _self.trnxFailure : trnxFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _ElectricityState implements ElectricityState {
  const _ElectricityState({required final  List<dynamic> elecPlans, required this.discoName, required this.type, required this.meterNumber, required this.amount, required this.number, required this.trnxInProcess, required this.trnxSuccess, required this.trnxFailure}): _elecPlans = elecPlans;
  

 final  List<dynamic> _elecPlans;
@override List<dynamic> get elecPlans {
  if (_elecPlans is EqualUnmodifiableListView) return _elecPlans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_elecPlans);
}

@override final  String discoName;
@override final  String type;
@override final  String meterNumber;
@override final  String amount;
@override final  String number;
@override final  bool trnxInProcess;
@override final  bool trnxSuccess;
@override final  bool trnxFailure;

/// Create a copy of ElectricityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElectricityStateCopyWith<_ElectricityState> get copyWith => __$ElectricityStateCopyWithImpl<_ElectricityState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElectricityState&&const DeepCollectionEquality().equals(other._elecPlans, _elecPlans)&&(identical(other.discoName, discoName) || other.discoName == discoName)&&(identical(other.type, type) || other.type == type)&&(identical(other.meterNumber, meterNumber) || other.meterNumber == meterNumber)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.number, number) || other.number == number)&&(identical(other.trnxInProcess, trnxInProcess) || other.trnxInProcess == trnxInProcess)&&(identical(other.trnxSuccess, trnxSuccess) || other.trnxSuccess == trnxSuccess)&&(identical(other.trnxFailure, trnxFailure) || other.trnxFailure == trnxFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_elecPlans),discoName,type,meterNumber,amount,number,trnxInProcess,trnxSuccess,trnxFailure);

@override
String toString() {
  return 'ElectricityState(elecPlans: $elecPlans, discoName: $discoName, type: $type, meterNumber: $meterNumber, amount: $amount, number: $number, trnxInProcess: $trnxInProcess, trnxSuccess: $trnxSuccess, trnxFailure: $trnxFailure)';
}


}

/// @nodoc
abstract mixin class _$ElectricityStateCopyWith<$Res> implements $ElectricityStateCopyWith<$Res> {
  factory _$ElectricityStateCopyWith(_ElectricityState value, $Res Function(_ElectricityState) _then) = __$ElectricityStateCopyWithImpl;
@override @useResult
$Res call({
 List<dynamic> elecPlans, String discoName, String type, String meterNumber, String amount, String number, bool trnxInProcess, bool trnxSuccess, bool trnxFailure
});




}
/// @nodoc
class __$ElectricityStateCopyWithImpl<$Res>
    implements _$ElectricityStateCopyWith<$Res> {
  __$ElectricityStateCopyWithImpl(this._self, this._then);

  final _ElectricityState _self;
  final $Res Function(_ElectricityState) _then;

/// Create a copy of ElectricityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? elecPlans = null,Object? discoName = null,Object? type = null,Object? meterNumber = null,Object? amount = null,Object? number = null,Object? trnxInProcess = null,Object? trnxSuccess = null,Object? trnxFailure = null,}) {
  return _then(_ElectricityState(
elecPlans: null == elecPlans ? _self._elecPlans : elecPlans // ignore: cast_nullable_to_non_nullable
as List<dynamic>,discoName: null == discoName ? _self.discoName : discoName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,meterNumber: null == meterNumber ? _self.meterNumber : meterNumber // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,trnxInProcess: null == trnxInProcess ? _self.trnxInProcess : trnxInProcess // ignore: cast_nullable_to_non_nullable
as bool,trnxSuccess: null == trnxSuccess ? _self.trnxSuccess : trnxSuccess // ignore: cast_nullable_to_non_nullable
as bool,trnxFailure: null == trnxFailure ? _self.trnxFailure : trnxFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
