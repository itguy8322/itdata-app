// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserState {

 UserData? get userData; bool get isNewUser; bool get userDataSuccess; bool get uesrDataInProgress; bool get userDataFailure;
/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStateCopyWith<UserState> get copyWith => _$UserStateCopyWithImpl<UserState>(this as UserState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserState&&(identical(other.userData, userData) || other.userData == userData)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser)&&(identical(other.userDataSuccess, userDataSuccess) || other.userDataSuccess == userDataSuccess)&&(identical(other.uesrDataInProgress, uesrDataInProgress) || other.uesrDataInProgress == uesrDataInProgress)&&(identical(other.userDataFailure, userDataFailure) || other.userDataFailure == userDataFailure));
}


@override
int get hashCode => Object.hash(runtimeType,userData,isNewUser,userDataSuccess,uesrDataInProgress,userDataFailure);

@override
String toString() {
  return 'UserState(userData: $userData, isNewUser: $isNewUser, userDataSuccess: $userDataSuccess, uesrDataInProgress: $uesrDataInProgress, userDataFailure: $userDataFailure)';
}


}

/// @nodoc
abstract mixin class $UserStateCopyWith<$Res>  {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) _then) = _$UserStateCopyWithImpl;
@useResult
$Res call({
 UserData? userData, bool isNewUser, bool userDataSuccess, bool uesrDataInProgress, bool userDataFailure
});




}
/// @nodoc
class _$UserStateCopyWithImpl<$Res>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._self, this._then);

  final UserState _self;
  final $Res Function(UserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userData = freezed,Object? isNewUser = null,Object? userDataSuccess = null,Object? uesrDataInProgress = null,Object? userDataFailure = null,}) {
  return _then(_self.copyWith(
userData: freezed == userData ? _self.userData : userData // ignore: cast_nullable_to_non_nullable
as UserData?,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,userDataSuccess: null == userDataSuccess ? _self.userDataSuccess : userDataSuccess // ignore: cast_nullable_to_non_nullable
as bool,uesrDataInProgress: null == uesrDataInProgress ? _self.uesrDataInProgress : uesrDataInProgress // ignore: cast_nullable_to_non_nullable
as bool,userDataFailure: null == userDataFailure ? _self.userDataFailure : userDataFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _UserState implements UserState {
  const _UserState({required this.userData, required this.isNewUser, required this.userDataSuccess, required this.uesrDataInProgress, required this.userDataFailure});
  

@override final  UserData? userData;
@override final  bool isNewUser;
@override final  bool userDataSuccess;
@override final  bool uesrDataInProgress;
@override final  bool userDataFailure;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStateCopyWith<_UserState> get copyWith => __$UserStateCopyWithImpl<_UserState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserState&&(identical(other.userData, userData) || other.userData == userData)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser)&&(identical(other.userDataSuccess, userDataSuccess) || other.userDataSuccess == userDataSuccess)&&(identical(other.uesrDataInProgress, uesrDataInProgress) || other.uesrDataInProgress == uesrDataInProgress)&&(identical(other.userDataFailure, userDataFailure) || other.userDataFailure == userDataFailure));
}


@override
int get hashCode => Object.hash(runtimeType,userData,isNewUser,userDataSuccess,uesrDataInProgress,userDataFailure);

@override
String toString() {
  return 'UserState(userData: $userData, isNewUser: $isNewUser, userDataSuccess: $userDataSuccess, uesrDataInProgress: $uesrDataInProgress, userDataFailure: $userDataFailure)';
}


}

/// @nodoc
abstract mixin class _$UserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserStateCopyWith(_UserState value, $Res Function(_UserState) _then) = __$UserStateCopyWithImpl;
@override @useResult
$Res call({
 UserData? userData, bool isNewUser, bool userDataSuccess, bool uesrDataInProgress, bool userDataFailure
});




}
/// @nodoc
class __$UserStateCopyWithImpl<$Res>
    implements _$UserStateCopyWith<$Res> {
  __$UserStateCopyWithImpl(this._self, this._then);

  final _UserState _self;
  final $Res Function(_UserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userData = freezed,Object? isNewUser = null,Object? userDataSuccess = null,Object? uesrDataInProgress = null,Object? userDataFailure = null,}) {
  return _then(_UserState(
userData: freezed == userData ? _self.userData : userData // ignore: cast_nullable_to_non_nullable
as UserData?,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,userDataSuccess: null == userDataSuccess ? _self.userDataSuccess : userDataSuccess // ignore: cast_nullable_to_non_nullable
as bool,uesrDataInProgress: null == uesrDataInProgress ? _self.uesrDataInProgress : uesrDataInProgress // ignore: cast_nullable_to_non_nullable
as bool,userDataFailure: null == userDataFailure ? _self.userDataFailure : userDataFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
