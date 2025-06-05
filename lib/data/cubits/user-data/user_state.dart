// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:itdata/data/models/user/user.dart';

part 'user_state.freezed.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    required UserData? userData,
    required bool userDataSuccess,
    required bool uesrDataInProgress,
    required bool userDataFailure,
  }) = _UserState;

  factory UserState.initial() {
    return UserState(
      userData: null,
      userDataSuccess: false,
      uesrDataInProgress: false,
      userDataFailure: false,
    );
  }
}
