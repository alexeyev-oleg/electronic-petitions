import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_info_banner.dart';
import '../../../../core/widgets/app_inspector_action_sheet.dart';
import '../../../../core/widgets/app_media_gallery.dart';
import '../../../../core/widgets/app_status_chip.dart';
import '../../../triage/application/inspector_triage_action.dart';
import '../../../triage/application/triage_controller.dart';
import '../../application/dispatch_controller.dart';

class DispatchTaskDetailScreen extends ConsumerStatefulWidget {
  const DispatchTaskDetailScreen({
    super.key,
    required this.taskId,
  });

  final String taskId;

  @override
  ConsumerState<DispatchTaskDetailScreen> createState() =>
      _DispatchTaskDetailScreenState();
}

class _DispatchTaskDetailScreenState extends ConsumerState<DispatchTaskDetailScreen> {
  var _isApplying = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    ref.watch(dispatchControllerProvider);
    ref.watch(triageControllerProvider);
    final report = ref.read(dispatchControllerProvider).findById(widget.taskId) ??
        ref.read(triageControllerProvider).findById(widget.taskId);

    if (report == null || !report.isDispatchQueueItem) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.dispatchQueueTitle)),
        body: Center(child: Text(l10n.dispatchTaskNotFound)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dispatchTaskDetail),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            report.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppStatusChip(status: report.status),
          const SizedBox(height: AppSpacing.md),
          Text(report.description),
          const SizedBox(height: AppSpacing.md),
          Text('${l10n.locationLabel}: ${report.locationLabel}'),
          const SizedBox(height: AppSpacing.sm),
          Text('${l10n.trustLevelLabel}: ${report.trustLabel}'),
          const SizedBox(height: AppSpacing.sm),
          Text('${l10n.submittedAtLabel}: ${report.submittedAtLabel}'),
          if (report.actionNote != null && report.actionNote!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text('${l10n.actionNoteLabel}: ${report.actionNote}'),
          ],
          if (report.oversightNote != null &&
              report.oversightNote!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text('${l10n.oversightNoteLabel}: ${report.oversightNote}'),
          ],
          if (report.latitude != null && report.longitude != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${l10n.coordinatesLabel}: ${report.latitude!.toStringAsFixed(3)}, ${report.longitude!.toStringAsFixed(3)}',
            ),
          ],
          if (report.geoMismatch) ...[
            const SizedBox(height: AppSpacing.md),
            AppInfoBanner(message: l10n.geoMismatchNotice),
          ],
          if (report.hasMedia) ...[
            const SizedBox(height: AppSpacing.md),
            AppMediaGallery(attachments: report.mediaAttachments),
          ],
          if (report.isClosed) ...[
            const SizedBox(height: AppSpacing.lg),
            AppInfoBanner(message: l10n.reportClosedNotice),
          ] else ...[
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.dispatchActionsTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            if (report.canStartFieldVisit) ...[
              FilledButton(
                onPressed: _isApplying
                    ? null
                    : () => _runAction(InspectorTriageAction.startFieldVisit),
                child: Text(l10n.startFieldVisitAction),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            if (report.canValidateOutcome) ...[
              Text(
                l10n.validatedOutcomeTitle,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: _isApplying
                    ? null
                    : () => _runAction(InspectorTriageAction.validateWarning),
                child: Text(l10n.validateWarningAction),
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: _isApplying
                    ? null
                    : () => _runAction(InspectorTriageAction.validateFine),
                child: Text(l10n.validateFineAction),
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: _isApplying
                    ? null
                    : () => _runAction(InspectorTriageAction.validateNoAction),
                child: Text(l10n.validateNoActionAction),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Future<void> _runAction(InspectorTriageAction action) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await AppInspectorActionSheet.show(
      context,
      title: l10n.sensitiveActionTitle,
      message: l10n.sensitiveActionMessage,
    );
    if (!confirmed || !mounted) {
      return;
    }

    setState(() => _isApplying = true);
    final updated = await ref.read(triageControllerProvider).applyAction(
          reportId: widget.taskId,
          action: action,
        );
    if (!mounted) {
      return;
    }
    setState(() => _isApplying = false);

    if (updated == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.actionFailedMessage)),
      );
      return;
    }

    await ref.read(dispatchControllerProvider).load();
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.actionAppliedNotice)),
    );
  }
}
