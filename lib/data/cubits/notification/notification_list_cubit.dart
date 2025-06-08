import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/notification/notification_list_state.dart';
import 'package:itdata/data/models/notification/notification.dart';

class NotificationListCubit extends Cubit<NotificationsListState> {
  NotificationListCubit() : super(NotificationsListState.initial());

  void loadNotifications() {
    emit(
      state.copyWith(
        loadingInProgress: true,
        loadingFailure: false,
        loadingSuccess: false,
      ),
    );
    try {
      Future.delayed(Duration(seconds: 3), () {
        List<Notification> notifications = [];
        emit(
          state.copyWith(
            notifications: notifications,
            loadingFailure: false,
            loadingInProgress: false,
            loadingSuccess: true,
          ),
        );
      });
    } catch (e) {
      emit(
        state.copyWith(
          loadingFailure: true,
          loadingInProgress: false,
          loadingSuccess: false,
        ),
      );
    }
  }
}
