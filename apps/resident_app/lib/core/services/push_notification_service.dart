import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pushNotificationServiceProvider =
    ChangeNotifierProvider<MockPushNotificationService>(
  (_) => MockPushNotificationService(),
);

abstract class PushNotificationService {
  Future<void> initialize();

  Future<void> setEnabled(bool enabled);

  bool get isEnabled;

  String? get deviceToken;

  String get statusLabel;
}

class MockPushNotificationService extends ChangeNotifier
    implements PushNotificationService {
  bool _enabled = false;
  String? _token;

  @override
  bool get isEnabled => _enabled;

  @override
  String? get deviceToken => _token;

  @override
  String get statusLabel {
    if (!_enabled) {
      return 'disabled';
    }
    return _token == null ? 'pending' : 'registered';
  }

  @override
  Future<void> initialize() async {
    debugPrint('push: scaffold initialized (mock, no FCM backend yet)');
  }

  @override
  Future<void> setEnabled(bool enabled) async {
    _enabled = enabled;
    if (!enabled) {
      _token = null;
      debugPrint('push: mock registration cleared');
      notifyListeners();
      return;
    }

    await Future<void>.delayed(const Duration(milliseconds: 350));
    _token = 'mock-fcm-token-${DateTime.now().millisecondsSinceEpoch}';
    debugPrint('push: mock device token $_token');
    notifyListeners();
  }
}
