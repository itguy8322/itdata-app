import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/app-settings/app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState>{
  AppSettingsCubit() : super(AppSettingsState.initial());

  void reset() {
    emit(AppSettingsState.initial());
  }

  void setDarkMode(bool isDarkMode) {
    emit(state.copyWith(isDarkMode: isDarkMode));
  }

  void setPushNotificationsEnabled(bool isEnabled) {
    emit(state.copyWith(isPushNotificationsEnabled: isEnabled));
  }

  void setEmailNotificationsEnabled(bool isEnabled) {
    emit(state.copyWith(isEmailNotificationsEnabled: isEnabled));
  }

  void setBiometricAuthEnabled(bool isEnabled) {
    emit(state.copyWith(isBiometricAuthEnabled: isEnabled));
  }

  void setLanguage(String language) {
    emit(state.copyWith(language: language));
  }
}