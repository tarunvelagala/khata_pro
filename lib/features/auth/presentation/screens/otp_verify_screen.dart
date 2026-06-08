import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/services/sync_service.dart';
import '../../../../core/widgets/kp_back_button.dart';
import '../../../../core/widgets/button_spinner.dart';
import '../../../../design_system/molecules/kp_labeled_field.dart';
import '../../../../features/home/presentation/providers/database_provider.dart';
import '../../../../features/settings/presentation/providers/profile_provider.dart';
import '../../../../l10n/app_localizations.dart';
import 'phone_number_screen.dart';

abstract final class _Dims {
  static const double topGap      = 32.0;
  static const double subtitleGap = 8.0;
  static const double fieldTopGap = 40.0;
  static const double resendTopGap = 24.0;
  static const int    otpLength   = 6;
  static const int    resendCooldown = 30;
}

class OtpVerifyScreen extends ConsumerStatefulWidget {
  const OtpVerifyScreen({super.key, required this.args});

  final OtpScreenArgs args;

  @override
  ConsumerState<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends ConsumerState<OtpVerifyScreen> {
  final _otpCtrl = TextEditingController();
  bool _loading  = false;

  late String _verificationId;
  int? _resendToken;

  // Resend countdown
  int   _secondsLeft = _Dims.resendCooldown;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _verificationId = widget.args.verificationId;
    _resendToken    = widget.args.resendToken;
    _startTimer();
  }

  void _startTimer() {
    _secondsLeft = _Dims.resendCooldown;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 1) {
        t.cancel();
        if (mounted) setState(() => _secondsLeft = 0);
      } else {
        if (mounted) setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _otpCtrl.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _onAuthSuccess() async {
    setState(() => _loading = true);
    try {
      final db      = ref.read(databaseProvider);
      final profile = ref.read(profileProvider).value;
      await ref.read(syncServiceProvider).pushAllLocalData(db, profile);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
    if (!mounted) return;
    context.push('/onboarding/profile');
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
        leading: const KpBackButton(),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.buttonPaddingH,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: _Dims.topGap),
                    Text(
                      l10n.authOtpTitle,
                      style: tt.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: _Dims.subtitleGap),
                    Text(
                      l10n.authOtpSubtitle(widget.args.phone),
                      style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                    ),
                    const SizedBox(height: _Dims.fieldTopGap),
                    KpLabeledField(
                      label: l10n.authOtpLabel,
                      child: TextFormField(
                        controller: _otpCtrl,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(_Dims.otpLength),
                        ],
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _verify(),
                        decoration: const InputDecoration(
                          hintText: '------',
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                        ),
                      ),
                    ),
                    const SizedBox(height: _Dims.resendTopGap),
                    _ResendRow(
                      secondsLeft: _secondsLeft,
                      onResend: _resend,
                    ),
                  ],
                ),
              ),
            ),
            Builder(
              builder: (ctx) {
                final bottom = MediaQuery.paddingOf(ctx).bottom;
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppDimensions.buttonPaddingH,
                    AppDimensions.buttonPaddingV / 2,
                    AppDimensions.buttonPaddingH,
                    AppDimensions.buttonPaddingV / 2 + bottom,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: _loading
                        ? FilledButton(onPressed: null, child: const ButtonSpinner())
                        : FilledButton(
                            onPressed: _verify,
                            child: Text(l10n.authVerifyButton),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verify() async {
    final code = _otpCtrl.text.trim();
    if (code.length != _Dims.otpLength) return;
    setState(() => _loading = true);
    try {
      final credential = fb.PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: code,
      );
      await fb.FirebaseAuth.instance.signInWithCredential(credential);
      if (mounted) await _onAuthSuccess();
    } on fb.FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message ?? AppLocalizations.of(context)!.errorGeneric,
            ),
          ),
        );
      }
    }
  }

  Future<void> _resend() async {
    setState(() => _loading = true);
    try {
      await fb.FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.args.phone,
        forceResendingToken: _resendToken,
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          if (mounted) {
            setState(() => _loading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  e.message ?? AppLocalizations.of(context)!.errorGeneric,
                ),
              ),
            );
          }
        },
        codeSent: (verificationId, resendToken) {
          if (mounted) {
            setState(() {
              _verificationId = verificationId;
              _resendToken    = resendToken;
              _loading        = false;
              _otpCtrl.clear();
            });
            _startTimer();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.authOtpResent),
              ),
            );
          }
        },
        codeAutoRetrievalTimeout: (_) {},
      );
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.errorGeneric)),
        );
      }
    }
  }
}

class _ResendRow extends StatelessWidget {
  const _ResendRow({required this.secondsLeft, required this.onResend});

  final int          secondsLeft;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;
    final canResend = secondsLeft == 0;

    return Row(
      children: [
        Text(
          l10n.authDidntReceive,
          style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
        ),
        const SizedBox(width: 4),
        canResend
            ? GestureDetector(
                onTap: onResend,
                child: Text(
                  l10n.authResendOtp,
                  style: tt.bodySmall?.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : Text(
                l10n.authResendIn(secondsLeft),
                style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
              ),
      ],
    );
  }
}
