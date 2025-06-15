// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationsListState {

 String get userId; List<Notification>? get notifications; bool get loadingInProgress; bool get loadingSuccess; bool get loadingFailure;
/// Create a copy of NotificationsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsListStateCopyWith<NotificationsListState> get copyWith => _$NotificationsListStateCopyWithImpl<NotificationsListState>(this as NotificationsListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsListState&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.notifications, notifications)&&(identical(other.loadingInProgress, loadingInProgress) || other.loadingInProgress == loadingInProgress)&&(identical(other.loadingSuccess, loadingSuccess) || other.loadingSuccess == loadingSuccess)&&(identical(other.loadingFailure, loadingFailure) || other.loadingFailure == loadingFailure));
}


@override
int get hashCode => Object.hash(runtimeType,userId,const DeepCollectionEquality().hash(notifications),loadingInProgress,loadingSuccess,loadingFailure);

@override
String toString() {
  return 'NotificationsListState(userId: $userId, notifications: $notifications, loadingInProgress: $loadingInProgress, loadingSuccess: $loadingSuccess, loadingFailure: $loadingFailure)';
}


}

/// @nodoc
abstract mixin class $NotificationsListStateCopyWith<$Res>  {
  factory $NotificationsListStateCopyWith(NotificationsListState value, $Res Function(NotificationsListState) _then) = _$NotificationsListStateCopyWithImpl;
@useResult
$Res call({
 String userId, List<Notification>? notifications, bool loadingInProgress, bool loadingSuccess, bool loadingFailure
});




}
/// @nodoc
class _$NotificationsListStateCopyWithImpl<$Res>
    implements $NotificationsListStateCopyWith<$Res> {
  _$NotificationsListStateCopyWithImpl(this._self, this._then);

  final NotificationsListState _self;
  final $Res Function(NotificationsListState) _then;

/// Create a copy of NotificationsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? notifications = freezed,Object? loadingInProgress = null,Object? loadingSuccess = null,Object? loadingFailure = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,notifications: freezed == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<Notification>?,loadingInProgress: null == loadingInProgress ? _self.loadingInProgress : loadingInProgress // ignore: cast_nullable_to_non_nullable
as bool,loadingSuccess: null == loadingSuccess ? _self.loadingSuccess : loadingSuccess // ignore: cast_nullable_to_non_nullable
as bool,loadingFailure: null == loadingFailure ? _self.loadingFailure : loadingFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _NotificationsListState implements NotificationsListState {
  const _NotificationsListState({required this.userId, required final  List<Notification>? notifications, required this.loadingInProgress, required this.loadingSuccess, required this.loadingFailure}): _notifications = notifications;
  

@override final  String userId;
 final  List<Notification>? _notifications;
@override List<Notification>? get notifications {
  final value = _notifications;
  if (value == null) return null;
  if (_notifications is EqualUnmodifiableListView) return _notifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool loadingInProgress;
@override final  bool loadingSuccess;
@override final  bool loadingFailure;

/// Create a copy of NotificationsListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationsListStateCopyWith<_NotificationsListState> get copyWith => __$NotificationsListStateCopyWithImpl<_NotificationsListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationsListState&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._notifications, _notifications)&&(identical(other.loadingInProgress, loadingInProgress) || other.loadingInProgress == loadingInProgress)&&(identical(other.loadingSuccess, loadingSuccess) || other.loadingSuccess == loadingSuccess)&&(identical(other.loadingFailure, loadingFailure) || other.loadingFailure == loadingFailure));
}


@override
int get hashCode => Object.hash(runtimeType,userId,const DeepCollectionEquality().hash(_notifications),loadingInProgress,loadingSuccess,loadingFailure);

@override
String toString() {
  return 'NotificationsListState(userId: $userId, notifications: $notifications, loadingInProgress: $loadingInProgress, loadingSuccess: $loadingSuccess, loadingFailure: $loadingFailure)';
}


}

/// @nodoc
abstract mixin class _$NotificationsListStateCopyWith<$Res> implements $NotificationsListStateCopyWith<$Res> {
  factory _$NotificationsListStateCopyWith(_NotificationsListState value, $Res Function(_NotificationsListState) _then) = __$NotificationsListStateCopyWithImpl;
@override @useResult
$Res call({
 String userId, List<Notification>? notifications, bool loadingInProgress, bool loadingSuccess, bool loadingFailure
});




}
/// @nodoc
class __$NotificationsListStateCopyWithImpl<$Res>
    implements _$NotificationsListStateCopyWith<$Res> {
  __$NotificationsListStateCopyWithImpl(this._self, this._then);

  final _NotificationsListState _self;
  final $Res Function(_NotificationsListState) _then;

/// Create a copy of NotificationsListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? notifications = freezed,Object? loadingInProgress = null,Object? loadingSuccess = null,Object? loadingFailure = null,}) {
  return _then(_NotificationsListState(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,notifications: freezed == notifications ? _self._notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<Notification>?,loadingInProgress: null == loadingInProgress ? _self.loadingInProgress : loadingInProgress // ignore: cast_nullable_to_non_nullable
as bool,loadingSuccess: null == loadingSuccess ? _self.loadingSuccess : loadingSuccess // ignore: cast_nullable_to_non_nullable
as bool,loadingFailure: null == loadingFailure ? _self.loadingFailure : loadingFailure // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
