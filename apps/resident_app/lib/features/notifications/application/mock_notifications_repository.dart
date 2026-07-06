import 'dart:async';

import '../../../core/mock/mock_local_store.dart';
import 'app_notification.dart';
import 'notifications_repository.dart';

class MockNotificationsRepository implements NotificationsRepository {
  MockNotificationsRepository(this._store);

  final MockLocalStore _store;

  @override
  Future<List<AppNotification>> fetchNotifications() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return _store.fetchNotifications();
  }

  @override
  Future<void> markAsRead(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    final items = await _store.readNotifications();
    final index = items.indexWhere((item) => item.id == id);
    if (index == -1) return;
    final updated = [...items];
    updated[index] = updated[index].copyWith(isRead: true);
    await _store.saveNotifications(updated);
  }
}
