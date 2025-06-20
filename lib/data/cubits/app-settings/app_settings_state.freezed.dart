// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettingsState {

 bool get isDarkMode; bool get isPushNotificationsEnabled; bool get isEmailNotificationsEnabled; bool get isBiometricAuthEnabled; String get language;
/// Create a copy of AppSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsStateCopyWith<AppSettingsState> get copyWith => _$AppSettingsStateCopyWithImpl<AppSettingsState>(this as AppSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettingsState&&(identical(other.isDarkMode, isDarkMode) || other.isDarkMode == isDarkMode)&&(identical(other.isPushNotificationsEnabled, isPushNotificationsEnabled) || other.isPushNotificationsEnabled == isPushNotificationsEnabled)&&(identical(other.isEmailNotificationsEnabled, isEmailNotificationsEnabled) || other.isEmailNotificationsEnabled == isEmailNotificationsEnabled)&&(identical(other.isBiometricAuthEnabled, isBiometricAuthEnabled) || other.isBiometricAuthEnabled == isBiometricAuthEnabled)&&(identical(other.language, language) || other.language == language));
}


@override
int get hashCode => Object.hash(runtimeType,isDarkMode,isPushNotificationsEnabled,isEmailNotificationsEnabled,isBiometricAuthEnabled,language);

@override
String toString() {
  return 'AppSettingsState(isDarkMode: $isDarkMode, isPushNotificationsEnabled: $isPushNotificationsEnabled, isEmailNotificationsEnabled: $isEmailNotificationsEnabled, isBiometricAuthEnabled: $isBiometricAuthEnabled, language: $language)';
}


}

/// @nodoc
abstract mixin class $AppSettingsStateCopyWith<$Res>  {
  factory $AppSettingsStateCopyWith(AppSettingsState value, $Res Function(AppSettingsState) _then) = _$AppSettingsStateCopyWithImpl;
@useResult
$Res call({
 bool isDarkMode, bool isPushNotificationsEnabled, bool isEmailNotificationsEnabled, bool isBiometricAuthEnabled, String language
});




}
/// @nodoc
class _$AppSettingsStateCopyWithImpl<$Res>
    implements $AppSettingsStateCopyWith<$Res> {
  _$AppSettingsStateCopyWithImpl(this._self, this._then);

  final AppSettingsState _self;
  final $Res Function(AppSettingsState) _then;

/// Create a copy of AppSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isDarkMode = null,Object? isPushNotificationsEnabled = null,Object? isEmailNotificationsEnabled = null,Object? isBiometricAuthEnabled = null,Object? language = null,}) {
  return _then(_self.copyWith(
isDarkMode: null == isDarkMode ? _self.isDarkMode : isDarkMode // ignore: cast_nullable_to_non_nullable
as bool,isPushNotificationsEnabled: null == isPushNotificationsEnabled ? _self.isPushNotificationsEnabled : isPushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,isEmailNotificationsEnabled: null == isEmailNotificationsEnabled ? _self.isEmailNotificationsEnabled : isEmailNotificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,isBiometricAuthEnabled: null == isBiometricAuthEnabled ? _self.isBiometricAuthEnabled : isBiometricAuthEnabled // ignore: cast_nullable_to_non_nullable
as bool,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _AppSettingsState implements AppSettingsState {
  const _AppSettingsState({required this.isDarkMode, required this.isPushNotificationsEnabled, required this.isEmailNotificationsEnabled, required this.isBiometricAuthEnabled, required this.language});
  

@override final  bool isDarkMode;
@override final  bool isPushNotificationsEnabled;
@override final  bool isEmailNotificationsEnabled;
@override final  bool isBiometricAuthEnabled;
@override final  String language;

/// Create a copy of AppSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsStateCopyWith<_AppSettingsState> get copyWith => __$AppSettingsStateCopyWithImpl<_AppSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettingsState&&(identical(other.isDarkMode, isDarkMode) || other.isDarkMode == isDarkMode)&&(identical(other.isPushNotificationsEnabled, isPushNotificationsEnabled) || other.isPushNotificationsEnabled == isPushNotificationsEnabled)&&(identical(other.isEmailNotificationsEnabled, isEmailNotificationsEnabled) || other.isEmailNotificationsEnabled == isEmailNotificationsEnabled)&&(identical(other.isBiometricAuthEnabled, isBiometricAuthEnabled) || other.isBiometricAuthEnabled == isBiometricAuthEnabled)&&(identical(other.language, language) || other.language == language));
}


@override
int get hashCode => Object.hash(runtimeType,isDarkMode,isPushNotificationsEnabled,isEmailNotificationsEnabled,isBiometricAuthEnabled,language);

@override
String toString() {
  return 'AppSettingsState(isDarkMode: $isDarkMode, isPushNotificationsEnabled: $isPushNotificationsEnabled, isEmailNotificationsEnabled: $isEmailNotificationsEnabled, isBiometricAuthEnabled: $isBiometricAuthEnabled, language: $language)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsStateCopyWith<$Res> implements $AppSettingsStateCopyWith<$Res> {
  factory _$AppSettingsStateCopyWith(_AppSettingsState value, $Res Function(_AppSettingsState) _then) = __$AppSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isDarkMode, bool isPushNotificationsEnabled, bool isEmailNotificationsEnabled, bool isBiometricAuthEnabled, String language
});




}
/// @nodoc
class __$AppSettingsStateCopyWithImpl<$Res>
    implements _$AppSettingsStateCopyWith<$Res> {
  __$AppSettingsStateCopyWithImpl(this._self, this._then);

  final _AppSettingsState _self;
  final $Res Function(_AppSettingsState) _then;

/// Create a copy of AppSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isDarkMode = null,Object? isPushNotificationsEnabled = null,Object? isEmailNotificationsEnabled = null,Object? isBiometricAuthEnabled = null,Object? language = null,}) {
  return _then(_AppSettingsState(
isDarkMode: null == isDarkMode ? _self.isDarkMode : isDarkMode // ignore: cast_nullable_to_non_nullable
as bool,isPushNotificationsEnabled: null == isPushNotificationsEnabled ? _self.isPushNotificationsEnabled : isPushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,isEmailNotificationsEnabled: null == isEmailNotificationsEnabled ? _self.isEmailNotificationsEnabled : isEmailNotificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,isBiometricAuthEnabled: null == isBiometricAuthEnabled ? _self.isBiometricAuthEnabled : isBiometricAuthEnabled // ignore: cast_nullable_to_non_nullable
as bool,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
