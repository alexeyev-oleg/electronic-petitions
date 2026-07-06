import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mock/mock_local_store.dart';
import 'app_notification.dart';
import 'mock_notifications_repository.dart';
import 'notifications_repository.dart';

final notificationsRepositoryProvider = Provider<NotificationsRepository>(
  (ref) => MockNotificationsRepository(ref.watch(mockLocalStoreProvider)),
);

final notificationsControllerProvider =
    ChangeNotifierProvider<NotificationsController>(
  (ref) => NotificationsController(
    repository: ref.watch(notificationsRepositoryProvider),
  )..load(),
);

class NotificationsController extends ChangeNotifier {
  NotificationsController({
    required NotificationsRepository repository,
  }) : _repository = repository;

  final NotificationsRepository _repository;

  List<AppNotification> _items = const [];
  bool _isLoading = false;
  bool _hasLoadError = false;

  List<AppNotification> get items => _items;
  bool get isLoading => _isLoading;
  bool get hasLoadError => _hasLoadError;

  Future<void> load() async {
    _isLoading = true;
    _hasLoadError = false;
    notifyListeners();

    try {
      _items = await _repository.fetchNotifications();
    } catch (_) {
      _hasLoadError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markAsRead(String id) async {
    await _repository.markAsRead(id);
    _items = [
      for (final item in _items)
        if (item.id == id) item.copyWith(isRead: true) else item,
    ];
    notifyListeners();
  }
}
