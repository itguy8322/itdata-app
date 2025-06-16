// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_providers_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NetworkProvidersState {

 List<String>? get networkProviders;
/// Create a copy of NetworkProvidersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkProvidersStateCopyWith<NetworkProvidersState> get copyWith => _$NetworkProvidersStateCopyWithImpl<NetworkProvidersState>(this as NetworkProvidersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkProvidersState&&const DeepCollectionEquality().equals(other.networkProviders, networkProviders));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(networkProviders));

@override
String toString() {
  return 'NetworkProvidersState(networkProviders: $networkProviders)';
}


}

/// @nodoc
abstract mixin class $NetworkProvidersStateCopyWith<$Res>  {
  factory $NetworkProvidersStateCopyWith(NetworkProvidersState value, $Res Function(NetworkProvidersState) _then) = _$NetworkProvidersStateCopyWithImpl;
@useResult
$Res call({
 List<String>? networkProviders
});




}
/// @nodoc
class _$NetworkProvidersStateCopyWithImpl<$Res>
    implements $NetworkProvidersStateCopyWith<$Res> {
  _$NetworkProvidersStateCopyWithImpl(this._self, this._then);

  final NetworkProvidersState _self;
  final $Res Function(NetworkProvidersState) _then;

/// Create a copy of NetworkProvidersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? networkProviders = freezed,}) {
  return _then(_self.copyWith(
networkProviders: freezed == networkProviders ? _self.networkProviders : networkProviders // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// @nodoc


class _NetworkProvidersState implements NetworkProvidersState {
  const _NetworkProvidersState({required final  List<String>? networkProviders}): _networkProviders = networkProviders;
  

 final  List<String>? _networkProviders;
@override List<String>? get networkProviders {
  final value = _networkProviders;
  if (value == null) return null;
  if (_networkProviders is EqualUnmodifiableListView) return _networkProviders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of NetworkProvidersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkProvidersStateCopyWith<_NetworkProvidersState> get copyWith => __$NetworkProvidersStateCopyWithImpl<_NetworkProvidersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkProvidersState&&const DeepCollectionEquality().equals(other._networkProviders, _networkProviders));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_networkProviders));

@override
String toString() {
  return 'NetworkProvidersState(networkProviders: $networkProviders)';
}


}

/// @nodoc
abstract mixin class _$NetworkProvidersStateCopyWith<$Res> implements $NetworkProvidersStateCopyWith<$Res> {
  factory _$NetworkProvidersStateCopyWith(_NetworkProvidersState value, $Res Function(_NetworkProvidersState) _then) = __$NetworkProvidersStateCopyWithImpl;
@override @useResult
$Res call({
 List<String>? networkProviders
});




}
/// @nodoc
class __$NetworkProvidersStateCopyWithImpl<$Res>
    implements _$NetworkProvidersStateCopyWith<$Res> {
  __$NetworkProvidersStateCopyWithImpl(this._self, this._then);

  final _NetworkProvidersState _self;
  final $Res Function(_NetworkProvidersState) _then;

/// Create a copy of NetworkProvidersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? networkProviders = freezed,}) {
  return _then(_NetworkProvidersState(
networkProviders: freezed == networkProviders ? _self._networkProviders : networkProviders // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
