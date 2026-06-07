import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/app_lock_provider.dart';
import '../widgets/pin_entry.dart';

class AppLockScreen extends ConsumerStatefulWidget {
  const AppLockScreen({super.key, required this.onUnlocked});

  final VoidCallback onUnlocked;

  @override
  ConsumerState<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends ConsumerState<AppLockScreen> {
  final _auth   = LocalAuthentication();
  String? _error;
  bool _bioDone = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryBiometric());
  }

  Future<void> _tryBiometric() async {
    if (_bioDone) return;
    _bioDone = true;
    try {
      final canCheck = await _auth.canCheckBiometrics ||
          await _auth.isDeviceSupported();
      if (!canCheck || !mounted) return;

      final l10n = AppLocalizations.of(context)!;
      final ok = await _auth.authenticate(
        localizedReason: l10n.biometricReason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
      if (ok && mounted) widget.onUnlocked();
    } catch (_) {
      // Biometric unavailable — fall through to PIN
    }
  }

  Future<void> _onPinComplete(String pin) async {
    final ok = await ref.read(appLockProvider.notifier).verifyPin(pin);
    if (!mounted) return;
    if (ok) {
      widget.onUnlocked();
    } else {
      final l10n = AppLocalizations.of(context)!;
      setState(() => _error = l10n.pinIncorrect);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;

    return Material(
      color: cs.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.buttonPaddingH,
            AppDimensions.buttonPaddingV * 2,
            AppDimensions.buttonPaddingH,
            AppDimensions.buttonPaddingV,
          ),
          child: Column(
            children: [
              Icon(
                Icons.lock_rounded,
                size: 48,
                color: cs.primary,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.pinEnterTitle,
                style: tt.headlineSmall?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.buttonStackGap),
              PinEntry(
                errorText: _error,
                onComplete: _onPinComplete,
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: _tryBiometric,
                icon: const Icon(Icons.fingerprint_rounded),
                label: Text(l10n.biometricReason),
              ),
              const Spacer(),
              Text(
                l10n.pinForgot,
                style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
