import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/services/sync_service.dart';
import '../../../../features/home/presentation/providers/database_provider.dart';
import '../../../../features/settings/presentation/providers/profile_provider.dart';
import '../../../../l10n/app_localizations.dart';

abstract final class _Dims {
  static const double illustrationSize = 80.0;
  static const double headingTopGap    = 32.0;
  static const double subtitleGap      = 8.0;
  static const double buttonTopGap     = 40.0;
  static const double buttonGap        = 12.0;
  static const double dividerH         = 12.0;
  static const double skipTopGap       = 20.0;
}

/// [isOnboarding] true  → shown during first-run flow; Skip goes to profile setup.
/// [isOnboarding] false → shown from Profile tab; Skip just pops.
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key, this.isOnboarding = true});

  final bool isOnboarding;

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  bool _googleLoading = false;
  bool _syncing       = false;

  Future<void> _onAuthSuccess() async {
    // If there's existing local data, batch-push it to Firestore.
    setState(() => _syncing = true);
    try {
      final db      = ref.read(databaseProvider);
      final profile = ref.read(profileProvider).value;
      await ref.read(syncServiceProvider).pushAllLocalData(db, profile);
    } finally {
      if (mounted) setState(() => _syncing = false);
    }

    if (!mounted) return;
    if (widget.isOnboarding) {
      context.go('/onboarding/profile');
    } else {
      context.pop();
    }
  }

  void _skip() {
    if (widget.isOnboarding) {
      context.go('/onboarding/profile');
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => widget.isOnboarding ? context.go('/tour') : context.pop(),
        ),
      ),
      body: SafeArea(
        child: _syncing
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: AppDimensions.buttonPaddingV),
                    Text(
                      l10n.authSyncingData,
                      style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.buttonPaddingH,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: _Dims.headingTopGap),

                    CircleAvatar(
                      radius: _Dims.illustrationSize / 2,
                      backgroundColor: cs.primaryContainer,
                      child: Icon(
                        Icons.cloud_sync_rounded,
                        size: _Dims.illustrationSize * 0.55,
                        color: cs.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: _Dims.headingTopGap),

                    Text(
                      l10n.authSignInTitle,
                      style: tt.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: _Dims.subtitleGap),
                    Text(
                      l10n.authSignInSubtitle,
                      style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: _Dims.buttonTopGap),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        icon: const Icon(Icons.phone_rounded),
                        label: Text(l10n.authPhoneButton),
                        onPressed: () => context.push('/auth/phone'),
                      ),
                    ),
                    const SizedBox(height: _Dims.buttonGap),

                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: _Dims.dividerH,
                          ),
                          child: Text(
                            l10n.authOrDivider,
                            style: tt.labelSmall?.copyWith(
                              color: cs.onSurfaceVariant,
                              letterSpacing: AppDimensions.letterSpacingLabel,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: _Dims.buttonGap),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: _googleLoading
                            ? const SizedBox(
                                width: AppDimensions.buttonSpinnerSize,
                                height: AppDimensions.buttonSpinnerSize,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.g_mobiledata_rounded),
                        label: Text(l10n.authGoogleButton),
                        onPressed: _googleLoading ? null : _signInWithGoogle,
                      ),
                    ),
                    const SizedBox(height: _Dims.skipTopGap),

                    TextButton(
                      onPressed: _skip,
                      child: Text(
                        l10n.authSkip,
                        style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _googleLoading = true);
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        if (mounted) setState(() => _googleLoading = false);
        return;
      }
      final googleAuth = await googleUser.authentication;
      final credential = fb.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await fb.FirebaseAuth.instance.signInWithCredential(credential);
      if (mounted) await _onAuthSuccess();
    } catch (e) {
      if (mounted) {
        setState(() => _googleLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.errorGeneric)),
        );
      }
    }
  }
}
