import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../application/app_notification.dart';

void openNotificationDeepLink(
  BuildContext context,
  AppNotification notification,
) {
  final deepLink = notification.deepLink;
  if (deepLink == null || deepLink.isEmpty) {
    return;
  }
  context.push(deepLink);
}
