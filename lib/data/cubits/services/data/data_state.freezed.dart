// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DataState {

 Map<String, dynamic> get dataplans; String get provider; String get type; String get planId; String get price; String get number; bool get trnxInProcess; bool get trnxSuccess; bool get trnxFailure;
/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataStateCopyWith<DataState> get copyWith => _$DataStateCopyWithImpl<DataState>(this as DataState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DataState&&const DeepCollectionEquality().equals(other.dataplans, dataplans)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.type, type) || other.type == type)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.price, price) || other.price == price)&&(identical(other.number, number) || other.number == number)&&(identical(other.trnxInProcess, trnxInProcess) || other.trnxInProcess == trnxInProcess)&&(identical(other.trnxSuccess, trnxSuccess) || other.trnxSuccess == trnxSuccess)&&(identical(other.trnxFailure, trnxFailure) || other.trnxFailure == trnxFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(dataplans),provider,type,planId,price,number,trnxInProcess,trnxSuccess,trnxFailure);

@override
String toString() {
  return 'DataState(dataplans: $dataplans, provider: $provider, type: $type, planId: $planId, price: $price, number: $number, trnxInProcess: $trnxInProcess, trnxSuccess: $trnxSuccess, trnxFailure: $trnxFailure)';
}


}

/// @nodoc
abstract mixin class $DataStateCopyWith<$Res>  {
  factory $DataStateCopyWith(DataState value, $Res Function(DataState) _then) = _$DataStateCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> dataplans, String provider, String type, String planId, String price, String number, bool trnxInProcess, bool trnxSuccess, bool trnxFailure
});




}
/// @nodoc
class _$DataStateCopyWithImpl<$Res>
    implements $DataStateCopyWith<$Res> {
  _$DataStateCopyWithImpl(this._self, this._then);

  final DataState _self;
  final $Res Function(DataState) _then;

/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dataplans = null,Object? provider = null,Object? type = null,Object? planId = null,Object? price = null,Object? number = null,Object? trnxInProcess = null,Object? trnxSuccess = null,Object? trnxFailure = null,}) {
  return _then(_self.copyWith(
dataplans: null == dataplans ? _self.dataplans : dataplans // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
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


class _DataState implements DataState {
  const _DataState({required final  Map<String, dynamic> dataplans, required this.provider, required this.type, required this.planId, required this.price, required this.number, required this.trnxInProcess, required this.trnxSuccess, required this.trnxFailure}): _dataplans = dataplans;
  

 final  Map<String, dynamic> _dataplans;
@override Map<String, dynamic> get dataplans {
  if (_dataplans is EqualUnmodifiableMapView) return _dataplans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_dataplans);
}

@override final  String provider;
@override final  String type;
@override final  String planId;
@override final  String price;
@override final  String number;
@override final  bool trnxInProcess;
@override final  bool trnxSuccess;
@override final  bool trnxFailure;

/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DataStateCopyWith<_DataState> get copyWith => __$DataStateCopyWithImpl<_DataState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DataState&&const DeepCollectionEquality().equals(other._dataplans, _dataplans)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.type, type) || other.type == type)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.price, price) || other.price == price)&&(identical(other.number, number) || other.number == number)&&(identical(other.trnxInProcess, trnxInProcess) || other.trnxInProcess == trnxInProcess)&&(identical(other.trnxSuccess, trnxSuccess) || other.trnxSuccess == trnxSuccess)&&(identical(other.trnxFailure, trnxFailure) || other.trnxFailure == trnxFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_dataplans),provider,type,planId,price,number,trnxInProcess,trnxSuccess,trnxFailure);

@override
String toString() {
  return 'DataState(dataplans: $dataplans, provider: $provider, type: $type, planId: $planId, price: $price, number: $number, trnxInProcess: $trnxInProcess, trnxSuccess: $trnxSuccess, trnxFailure: $trnxFailure)';
}


}

/// @nodoc
abstract mixin class _$DataStateCopyWith<$Res> implements $DataStateCopyWith<$Res> {
  factory _$DataStateCopyWith(_DataState value, $Res Function(_DataState) _then) = __$DataStateCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> dataplans, String provider, String type, String planId, String price, String number, bool trnxInProcess, bool trnxSuccess, bool trnxFailure
});




}
/// @nodoc
class __$DataStateCopyWithImpl<$Res>
    implements _$DataStateCopyWith<$Res> {
  __$DataStateCopyWithImpl(this._self, this._then);

  final _DataState _self;
  final $Res Function(_DataState) _then;

/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dataplans = null,Object? provider = null,Object? type = null,Object? planId = null,Object? price = null,Object? number = null,Object? trnxInProcess = null,Object? trnxSuccess = null,Object? trnxFailure = null,}) {
  return _then(_DataState(
dataplans: null == dataplans ? _self._dataplans : dataplans // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
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
