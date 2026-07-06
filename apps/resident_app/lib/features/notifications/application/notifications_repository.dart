import 'app_notification.dart';

abstract class NotificationsRepository {
  Future<List<AppNotification>> fetchNotifications();
  Future<void> markAsRead(String id);
}
