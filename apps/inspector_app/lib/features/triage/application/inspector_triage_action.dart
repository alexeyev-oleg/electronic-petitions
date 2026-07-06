enum InspectorTriageAction {
  markInvalid,
  mergeCase,
  dispatchTask,
  validateWarning,
  validateFine,
  validateNoAction,
}

extension InspectorTriageActionX on InspectorTriageAction {
  String get resultingStatus {
    switch (this) {
      case InspectorTriageAction.markInvalid:
        return 'invalid';
      case InspectorTriageAction.mergeCase:
        return 'merged_with_existing_case';
      case InspectorTriageAction.dispatchTask:
        return 'dispatch_task';
      case InspectorTriageAction.validateWarning:
        return 'validated_warning';
      case InspectorTriageAction.validateFine:
        return 'validated_fine';
      case InspectorTriageAction.validateNoAction:
        return 'validated_no_action';
    }
  }

  bool get requiresExistingDispatch {
    switch (this) {
      case InspectorTriageAction.validateWarning:
      case InspectorTriageAction.validateFine:
      case InspectorTriageAction.validateNoAction:
        return true;
      default:
        return false;
    }
  }
}

abstract final class InspectorMockSecurity {
  static const mockOtpCode = '123456';
}
