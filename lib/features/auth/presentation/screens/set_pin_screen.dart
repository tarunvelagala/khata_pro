import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/app_lock_provider.dart';
import '../widgets/pin_entry.dart';

enum _Step { enter, confirm }

class SetPinScreen extends ConsumerStatefulWidget {
  const SetPinScreen({super.key});

  @override
  ConsumerState<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends ConsumerState<SetPinScreen> {
  _Step _step   = _Step.enter;
  String _first = '';
  String? _error;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;

    final title    = _step == _Step.enter ? l10n.pinSetupTitle    : l10n.pinConfirmTitle;
    final subtitle = _step == _Step.enter ? l10n.pinSetupSubtitle : null;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.buttonPaddingH,
            AppDimensions.buttonPaddingV,
            AppDimensions.buttonPaddingH,
            AppDimensions.buttonPaddingV,
          ),
          child: Column(
            children: [
              Text(
                title,
                style: tt.headlineSmall?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.buttonStackGap),
              PinEntry(
                key: ValueKey(_step),
                subtitle: subtitle,
                errorText: _error,
                onComplete: _onPinComplete,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onPinComplete(String pin) async {
    if (_step == _Step.enter) {
      setState(() {
        _first = pin;
        _step  = _Step.confirm;
        _error = null;
      });
      // The PinEntry widget resets when its key changes — rebuild will create fresh state.
      return;
    }

    // Confirm step
    if (pin != _first) {
      setState(() {
        _error = AppLocalizations.of(context)!.pinMismatch;
        _step  = _Step.enter;
        _first = '';
      });
      return;
    }

    await ref.read(appLockProvider.notifier).setPin(pin);
    await ref.read(appLockProvider.notifier).setEnabled(true);
    if (mounted) context.pop();
  }
}
