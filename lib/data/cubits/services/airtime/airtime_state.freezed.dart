// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'airtime_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AirtimeState {

 List<String> get airtimeTypes; int get provider; String get type; String get number; String get amount; bool get trnxInProcess; bool get trnxSuccess; bool get trnxFailure;
/// Create a copy of AirtimeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AirtimeStateCopyWith<AirtimeState> get copyWith => _$AirtimeStateCopyWithImpl<AirtimeState>(this as AirtimeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AirtimeState&&const DeepCollectionEquality().equals(other.airtimeTypes, airtimeTypes)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.type, type) || other.type == type)&&(identical(other.number, number) || other.number == number)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.trnxInProcess, trnxInProcess) || other.trnxInProcess == trnxInProcess)&&(identical(other.trnxSuccess, trnxSuccess) || other.trnxSuccess == trnxSuccess)&&(identical(other.trnxFailure, trnxFailure) || other.trnxFailure == trnxFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(airtimeTypes),provider,type,number,amount,trnxInProcess,trnxSuccess,trnxFailure);

@override
String toString() {
  return 'AirtimeState(airtimeTypes: $airtimeTypes, provider: $provider, type: $type, number: $number, amount: $amount, trnxInProcess: $trnxInProcess, trnxSuccess: $trnxSuccess, trnxFailure: $trnxFailure)';
}


}

/// @nodoc
abstract mixin class $AirtimeStateCopyWith<$Res>  {
  factory $AirtimeStateCopyWith(AirtimeState value, $Res Function(AirtimeState) _then) = _$AirtimeStateCopyWithImpl;
@useResult
$Res call({
 List<String> airtimeTypes, int provider, String type, String number, String amount, bool trnxInProcess, bool trnxSuccess, bool trnxFailure
});




}
/// @nodoc
class _$AirtimeStateCopyWithImpl<$Res>
    implements $AirtimeStateCopyWith<$Res> {
  _$AirtimeStateCopyWithImpl(this._self, this._then);

  final AirtimeState _self;
  final $Res Function(AirtimeState) _then;

/// Create a copy of AirtimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? airtimeTypes = null,Object? provider = null,Object? type = null,Object? number = null,Object? amount = null,Object? trnxInProcess = null,Object? trnxSuccess = null,Object? trnxFailure = null,}) {
  return _then(_self.copyWith(
airtimeTypes: null == airtimeTypes ? _self.airtimeTypes : airtimeTypes // ignore: cast_nullable_to_non_nullable
as List<String>,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,trnxInProcess: null == trnxInProcess ? _self.trnxInProcess : trnxInProcess // ignore: cast_nullable_to_non_nullable
as bool,trnxSuccess: null == trnxSuccess ? _self.trnxSuccess : trnxSuccess // ignore: cast_nullable_to_non_nullable
as bool,trnxFailure: null == trnxFailure ? _self.trnxFailure : trnxFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _AirtimeState implements AirtimeState {
  const _AirtimeState({required final  List<String> airtimeTypes, required this.provider, required this.type, required this.number, required this.amount, required this.trnxInProcess, required this.trnxSuccess, required this.trnxFailure}): _airtimeTypes = airtimeTypes;
  

 final  List<String> _airtimeTypes;
@override List<String> get airtimeTypes {
  if (_airtimeTypes is EqualUnmodifiableListView) return _airtimeTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_airtimeTypes);
}

@override final  int provider;
@override final  String type;
@override final  String number;
@override final  String amount;
@override final  bool trnxInProcess;
@override final  bool trnxSuccess;
@override final  bool trnxFailure;

/// Create a copy of AirtimeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AirtimeStateCopyWith<_AirtimeState> get copyWith => __$AirtimeStateCopyWithImpl<_AirtimeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AirtimeState&&const DeepCollectionEquality().equals(other._airtimeTypes, _airtimeTypes)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.type, type) || other.type == type)&&(identical(other.number, number) || other.number == number)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.trnxInProcess, trnxInProcess) || other.trnxInProcess == trnxInProcess)&&(identical(other.trnxSuccess, trnxSuccess) || other.trnxSuccess == trnxSuccess)&&(identical(other.trnxFailure, trnxFailure) || other.trnxFailure == trnxFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_airtimeTypes),provider,type,number,amount,trnxInProcess,trnxSuccess,trnxFailure);

@override
String toString() {
  return 'AirtimeState(airtimeTypes: $airtimeTypes, provider: $provider, type: $type, number: $number, amount: $amount, trnxInProcess: $trnxInProcess, trnxSuccess: $trnxSuccess, trnxFailure: $trnxFailure)';
}


}

/// @nodoc
abstract mixin class _$AirtimeStateCopyWith<$Res> implements $AirtimeStateCopyWith<$Res> {
  factory _$AirtimeStateCopyWith(_AirtimeState value, $Res Function(_AirtimeState) _then) = __$AirtimeStateCopyWithImpl;
@override @useResult
$Res call({
 List<String> airtimeTypes, int provider, String type, String number, String amount, bool trnxInProcess, bool trnxSuccess, bool trnxFailure
});




}
/// @nodoc
class __$AirtimeStateCopyWithImpl<$Res>
    implements _$AirtimeStateCopyWith<$Res> {
  __$AirtimeStateCopyWithImpl(this._self, this._then);

  final _AirtimeState _self;
  final $Res Function(_AirtimeState) _then;

/// Create a copy of AirtimeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? airtimeTypes = null,Object? provider = null,Object? type = null,Object? number = null,Object? amount = null,Object? trnxInProcess = null,Object? trnxSuccess = null,Object? trnxFailure = null,}) {
  return _then(_AirtimeState(
airtimeTypes: null == airtimeTypes ? _self._airtimeTypes : airtimeTypes // ignore: cast_nullable_to_non_nullable
as List<String>,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,trnxInProcess: null == trnxInProcess ? _self.trnxInProcess : trnxInProcess // ignore: cast_nullable_to_non_nullable
as bool,trnxSuccess: null == trnxSuccess ? _self.trnxSuccess : trnxSuccess // ignore: cast_nullable_to_non_nullable
as bool,trnxFailure: null == trnxFailure ? _self.trnxFailure : trnxFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
