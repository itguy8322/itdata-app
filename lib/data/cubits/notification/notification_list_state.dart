// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:itdata/data/models/notification/notification.dart';

part 'notification_list_state.freezed.dart';

@freezed
abstract class NotificationsListState with _$NotificationsListState {
  const factory NotificationsListState({
    required String userId,
    required List<Notification>? notifications,
    required bool loadingInProgress,
    required bool loadingSuccess,
    required bool loadingFailure,
  }) = _NotificationsListState;

  factory NotificationsListState.initial() {
    return NotificationsListState(
      userId: '',
      notifications: [],
      loadingInProgress: false,
      loadingSuccess: false,
      loadingFailure: false,
    );
  }
}
