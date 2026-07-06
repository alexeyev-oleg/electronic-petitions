import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_info_banner.dart';
import '../../../../core/widgets/app_inspector_action_sheet.dart';
import '../../../../core/widgets/app_media_gallery.dart';
import '../../../../core/widgets/app_status_chip.dart';
import '../../application/inspector_triage_action.dart';
import '../../application/triage_controller.dart';

class TriageReportDetailScreen extends ConsumerStatefulWidget {
  const TriageReportDetailScreen({
    super.key,
    required this.reportId,
  });

  final String reportId;

  @override
  ConsumerState<TriageReportDetailScreen> createState() =>
      _TriageReportDetailScreenState();
}

class _TriageReportDetailScreenState
    extends ConsumerState<TriageReportDetailScreen> {
  var _isApplying = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(triageControllerProvider);
    final report = controller.findById(widget.reportId);

    if (report == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.triageQueueTitle)),
        body: Center(child: Text(l10n.triageReportNotFound)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.triageReportDetail),
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
              l10n.inspectorActionsTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            if (report.canApplyTriageActions) ...[
              OutlinedButton(
                onPressed: _isApplying
                    ? null
                    : () => _runAction(
                          InspectorTriageAction.markInvalid,
                        ),
                child: Text(l10n.markInvalidAction),
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: _isApplying
                    ? null
                    : () => _mergeCase(context, l10n),
                child: Text(l10n.mergeCaseAction),
              ),
              const SizedBox(height: AppSpacing.sm),
              FilledButton(
                onPressed: _isApplying
                    ? null
                    : () => _runAction(
                          InspectorTriageAction.dispatchTask,
                        ),
                child: Text(l10n.dispatchTaskAction),
              ),
            ],
            if (report.canValidateOutcome) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.validatedOutcomeTitle,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: _isApplying
                    ? null
                    : () => _runAction(
                          InspectorTriageAction.validateWarning,
                        ),
                child: Text(l10n.validateWarningAction),
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: _isApplying
                    ? null
                    : () => _runAction(
                          InspectorTriageAction.validateFine,
                        ),
                child: Text(l10n.validateFineAction),
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: _isApplying
                    ? null
                    : () => _runAction(
                          InspectorTriageAction.validateNoAction,
                        ),
                child: Text(l10n.validateNoActionAction),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Future<void> _mergeCase(BuildContext context, AppLocalizations l10n) async {
    final caseController = TextEditingController(text: 'existing-case-104');
    final caseId = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.mergeCaseDialogTitle),
          content: TextField(
            controller: caseController,
            decoration: InputDecoration(
              labelText: l10n.mergeCaseIdLabel,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.cancelAction),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(caseController.text.trim()),
              child: Text(l10n.confirmSensitiveAction),
            ),
          ],
        );
      },
    );
    caseController.dispose();

    if (!mounted || caseId == null || caseId.isEmpty) {
      return;
    }

    await _runAction(
      InspectorTriageAction.mergeCase,
      actionNote: l10n.mergeCaseNote(caseId),
    );
  }

  Future<void> _runAction(
    InspectorTriageAction action, {
    String? actionNote,
  }) async {
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
          reportId: widget.reportId,
          action: action,
          actionNote: actionNote,
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.actionAppliedNotice)),
    );
  }
}
