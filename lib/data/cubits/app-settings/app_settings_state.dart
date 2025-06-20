import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings_state.freezed.dart';

@freezed
abstract class AppSettingsState with _$AppSettingsState {
  const factory AppSettingsState({
    required bool isDarkMode,
    required bool isPushNotificationsEnabled,
    required bool isEmailNotificationsEnabled,
    required bool isBiometricAuthEnabled,
    required String language,
  }) = _AppSettingsState;

  factory AppSettingsState.initial() => const AppSettingsState(
        isDarkMode: false,
        isPushNotificationsEnabled: true,
        isEmailNotificationsEnabled: false,
        isBiometricAuthEnabled: false,
        language: 'en',

  );
}