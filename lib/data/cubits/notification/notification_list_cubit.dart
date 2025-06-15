import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/notification/notification_list_state.dart';
import 'package:itdata/data/models/notification/notification.dart';
import 'package:itdata/services/notification_service.dart';

class NotificationListCubit extends Cubit<NotificationsListState> {
  NotificationListCubit() : super(NotificationsListState.initial());
  void setUserId(String id){
    emit(state.copyWith(userId: id));
  }
  void loadNotifications() async {
    emit(
      state.copyWith(
        loadingInProgress: true,
        loadingFailure: false,
        loadingSuccess: false,
      ),
    );
    try {
        List<Notification> notifications = [];
        final data = await NotificationService().load(state.userId);
        for (var notication in data){
          notifications.add(Notification.fromJson(notication));
        }

        emit(
          state.copyWith(
            notifications: notifications,
            loadingFailure: false,
            loadingInProgress: false,
            loadingSuccess: true,
          ),
        );
    } catch (e) {
      print("=========== ERROR ============");
      print(e.toString());
      print("=========== ERROR ============");
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
