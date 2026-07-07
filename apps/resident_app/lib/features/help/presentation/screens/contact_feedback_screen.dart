import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/constants/app_links.dart';
import '../../../../core/widgets/app_section_card.dart';

class ContactFeedbackScreen extends StatefulWidget {
  const ContactFeedbackScreen({super.key});

  @override
  State<ContactFeedbackScreen> createState() => _ContactFeedbackScreenState();
}

class _ContactFeedbackScreenState extends State<ContactFeedbackScreen> {
  static const _storageKey = 'gesher_contact_feedback_mock';

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_storageKey) ?? <String>[];
    existing.add(
      '${DateTime.now().toIso8601String()}|${_nameController.text.trim()}|${_emailController.text.trim()}|${_messageController.text.trim()}',
    );
    await prefs.setStringList(_storageKey, existing);

    if (!mounted) {
      return;
    }

    setState(() => _submitted = true);
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.contactFeedbackTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            l10n.contactFeedbackIntro,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          AppSectionCard(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: l10n.contactNameLabel,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.contactNameRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: l10n.contactEmailLabel,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.contactEmailRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextFormField(
                    controller: _messageController,
                    minLines: 4,
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText: l10n.contactMessageLabel,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.contactMessageRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Semantics(
                    button: true,
                    label: l10n.contactSubmit,
                    child: FilledButton(
                      onPressed: _submit,
                      child: Text(l10n.contactSubmit),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.contactMockNotice,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (_submitted) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.contactSuccess,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Text(
            '${l10n.publicWebLabel}: ${AppLinks.publicWebUrl}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
