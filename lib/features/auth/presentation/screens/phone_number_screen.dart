import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/sticky_footer_cta.dart';
import '../../../../l10n/app_localizations.dart';

abstract final class _Dims {
  static const double topGap      = 32.0;
  static const double subtitleGap = 8.0;
  static const double fieldTopGap = 40.0;
}

class PhoneNumberScreen extends ConsumerStatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  ConsumerState<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends ConsumerState<PhoneNumberScreen> {
  final _phoneCtrl = TextEditingController();
  bool _loading    = false;

  static final _phoneRegex = RegExp(r'^\+?[\d\s\-]{10,15}$');

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
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
          onPressed: () => context.pop(),
        ),
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
                      l10n.authPhoneStepTitle,
                      style: tt.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: _Dims.subtitleGap),
                    Text(
                      l10n.authPhoneStepSubtitle,
                      style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                    ),
                    const SizedBox(height: _Dims.fieldTopGap),
                    TextFormField(
                      controller: _phoneCtrl,
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[\d\s\+\-]')),
                      ],
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _sendOtp(),
                      decoration: InputDecoration(
                        labelText: l10n.authPhoneLabel,
                        hintText: l10n.authPhoneHint,
                        prefixIcon: const Icon(Icons.phone_rounded),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StickyFooterCta(
              label: l10n.authSendOtpButton,
              onPressed: _sendOtp,
              loading: _loading,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendOtp() async {
    final raw   = _phoneCtrl.text.trim();
    final phone = raw.replaceAll(RegExp(r'[\s\-]'), '');
    if (phone.isEmpty || !_phoneRegex.hasMatch(raw)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.addCustomerPhoneInvalid)),
      );
      return;
    }
    setState(() => _loading = true);

    try {
      await fb.FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone.startsWith('+') ? phone : '+91$phone',
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
            setState(() => _loading = false);
            context.push(
              '/auth/otp',
              extra: OtpScreenArgs(
                phone: phone.startsWith('+') ? phone : '+91$phone',
                verificationId: verificationId,
                resendToken: resendToken,
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

class OtpScreenArgs {
  const OtpScreenArgs({
    required this.phone,
    required this.verificationId,
    this.resendToken,
  });

  final String phone;
  final String verificationId;
  final int?   resendToken;
}
