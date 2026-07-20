import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_list_state_view.dart';
import '../../application/notifications_controller.dart';
import '../notification_navigation.dart';

class InboxScreen extends ConsumerWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(notificationsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.inbox),
      ),
      body: AppListStateView(
        isLoading: controller.isLoading,
        hasLoadError: controller.hasLoadError,
        isEmpty: controller.items.isEmpty,
        emptyMessage: l10n.noNotificationsYet,
        onRetry: () => ref.read(notificationsControllerProvider).load(),
        child: ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: controller.items.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            final item = controller.items[index];
            final hasDeepLink = item.deepLink != null && item.deepLink!.isNotEmpty;

            return Semantics(
              button: hasDeepLink,
              label: item.title,
              hint: hasDeepLink ? l10n.openNotificationAction : item.body,
              child: Card(
                child: ListTile(
                  title: Text(item.title),
                  subtitle: Text('${item.body}\n${item.createdAtLabel}'),
                  isThreeLine: true,
                  trailing: item.isRead
                      ? (hasDeepLink
                          ? const Icon(Icons.open_in_new)
                          : null)
                      : const Icon(Icons.mark_email_unread_outlined),
                  onTap: () {
                    ref
                        .read(notificationsControllerProvider)
                        .markAsRead(item.id);
                    if (hasDeepLink) {
                      openNotificationDeepLink(context, item);
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
