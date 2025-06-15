// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cable_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CableState {

 Map<String, dynamic> get cableplans; String get cable; String get type; String get iucNumber; String get planId; String get price; String get number; bool get trnxInProcess; bool get trnxSuccess; bool get trnxFailure;
/// Create a copy of CableState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CableStateCopyWith<CableState> get copyWith => _$CableStateCopyWithImpl<CableState>(this as CableState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CableState&&const DeepCollectionEquality().equals(other.cableplans, cableplans)&&(identical(other.cable, cable) || other.cable == cable)&&(identical(other.type, type) || other.type == type)&&(identical(other.iucNumber, iucNumber) || other.iucNumber == iucNumber)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.price, price) || other.price == price)&&(identical(other.number, number) || other.number == number)&&(identical(other.trnxInProcess, trnxInProcess) || other.trnxInProcess == trnxInProcess)&&(identical(other.trnxSuccess, trnxSuccess) || other.trnxSuccess == trnxSuccess)&&(identical(other.trnxFailure, trnxFailure) || other.trnxFailure == trnxFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cableplans),cable,type,iucNumber,planId,price,number,trnxInProcess,trnxSuccess,trnxFailure);

@override
String toString() {
  return 'CableState(cableplans: $cableplans, cable: $cable, type: $type, iucNumber: $iucNumber, planId: $planId, price: $price, number: $number, trnxInProcess: $trnxInProcess, trnxSuccess: $trnxSuccess, trnxFailure: $trnxFailure)';
}


}

/// @nodoc
abstract mixin class $CableStateCopyWith<$Res>  {
  factory $CableStateCopyWith(CableState value, $Res Function(CableState) _then) = _$CableStateCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> cableplans, String cable, String type, String iucNumber, String planId, String price, String number, bool trnxInProcess, bool trnxSuccess, bool trnxFailure
});




}
/// @nodoc
class _$CableStateCopyWithImpl<$Res>
    implements $CableStateCopyWith<$Res> {
  _$CableStateCopyWithImpl(this._self, this._then);

  final CableState _self;
  final $Res Function(CableState) _then;

/// Create a copy of CableState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cableplans = null,Object? cable = null,Object? type = null,Object? iucNumber = null,Object? planId = null,Object? price = null,Object? number = null,Object? trnxInProcess = null,Object? trnxSuccess = null,Object? trnxFailure = null,}) {
  return _then(_self.copyWith(
cableplans: null == cableplans ? _self.cableplans : cableplans // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,cable: null == cable ? _self.cable : cable // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,iucNumber: null == iucNumber ? _self.iucNumber : iucNumber // ignore: cast_nullable_to_non_nullable
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


class _CableState implements CableState {
  const _CableState({required final  Map<String, dynamic> cableplans, required this.cable, required this.type, required this.iucNumber, required this.planId, required this.price, required this.number, required this.trnxInProcess, required this.trnxSuccess, required this.trnxFailure}): _cableplans = cableplans;
  

 final  Map<String, dynamic> _cableplans;
@override Map<String, dynamic> get cableplans {
  if (_cableplans is EqualUnmodifiableMapView) return _cableplans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_cableplans);
}

@override final  String cable;
@override final  String type;
@override final  String iucNumber;
@override final  String planId;
@override final  String price;
@override final  String number;
@override final  bool trnxInProcess;
@override final  bool trnxSuccess;
@override final  bool trnxFailure;

/// Create a copy of CableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CableStateCopyWith<_CableState> get copyWith => __$CableStateCopyWithImpl<_CableState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CableState&&const DeepCollectionEquality().equals(other._cableplans, _cableplans)&&(identical(other.cable, cable) || other.cable == cable)&&(identical(other.type, type) || other.type == type)&&(identical(other.iucNumber, iucNumber) || other.iucNumber == iucNumber)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.price, price) || other.price == price)&&(identical(other.number, number) || other.number == number)&&(identical(other.trnxInProcess, trnxInProcess) || other.trnxInProcess == trnxInProcess)&&(identical(other.trnxSuccess, trnxSuccess) || other.trnxSuccess == trnxSuccess)&&(identical(other.trnxFailure, trnxFailure) || other.trnxFailure == trnxFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cableplans),cable,type,iucNumber,planId,price,number,trnxInProcess,trnxSuccess,trnxFailure);

@override
String toString() {
  return 'CableState(cableplans: $cableplans, cable: $cable, type: $type, iucNumber: $iucNumber, planId: $planId, price: $price, number: $number, trnxInProcess: $trnxInProcess, trnxSuccess: $trnxSuccess, trnxFailure: $trnxFailure)';
}


}

/// @nodoc
abstract mixin class _$CableStateCopyWith<$Res> implements $CableStateCopyWith<$Res> {
  factory _$CableStateCopyWith(_CableState value, $Res Function(_CableState) _then) = __$CableStateCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> cableplans, String cable, String type, String iucNumber, String planId, String price, String number, bool trnxInProcess, bool trnxSuccess, bool trnxFailure
});




}
/// @nodoc
class __$CableStateCopyWithImpl<$Res>
    implements _$CableStateCopyWith<$Res> {
  __$CableStateCopyWithImpl(this._self, this._then);

  final _CableState _self;
  final $Res Function(_CableState) _then;

/// Create a copy of CableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cableplans = null,Object? cable = null,Object? type = null,Object? iucNumber = null,Object? planId = null,Object? price = null,Object? number = null,Object? trnxInProcess = null,Object? trnxSuccess = null,Object? trnxFailure = null,}) {
  return _then(_CableState(
cableplans: null == cableplans ? _self._cableplans : cableplans // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,cable: null == cable ? _self.cable : cable // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,iucNumber: null == iucNumber ? _self.iucNumber : iucNumber // ignore: cast_nullable_to_non_nullable
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
