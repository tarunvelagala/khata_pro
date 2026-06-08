import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/kp_back_button.dart';
import '../../../../core/widgets/button_spinner.dart';
import '../../../../design_system/molecules/kp_labeled_field.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../settings/presentation/providers/profile_provider.dart';

abstract final class _Dims {
  static const double headerTopPadding = 48.0;
  static const double iconSize         = 64.0;
  static const double iconGap          = 24.0;
  static const double titleGap         = 8.0;
  static const double formTopGap       = 32.0;
  static const double fieldGap         = 16.0;
}

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey  = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _shopCtrl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill name from Firebase Auth (Google sign-in provides displayName).
    final firebaseName = fb.FirebaseAuth.instance.currentUser?.displayName ?? '';
    _nameCtrl = TextEditingController(text: firebaseName);
    _shopCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _shopCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final name     = _nameCtrl.text.trim();
    final shopName = _shopCtrl.text.trim().isEmpty ? null : _shopCtrl.text.trim();
    await ref.read(profileProvider.notifier).save(
          UserProfile(name: name, shopName: shopName),
        );
    if (mounted) context.go('/home');
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
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: true,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: _Dims.headerTopPadding),

                    // ── Icon ────────────────────────────────────────
                    Center(
                      child: Container(
                        width: _Dims.iconSize,
                        height: _Dims.iconSize,
                        decoration: BoxDecoration(
                          color: cs.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person_rounded,
                          size: _Dims.iconSize / 2,
                          color: cs.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: _Dims.iconGap),

                    // ── Title ────────────────────────────────────────
                    Text(
                      l10n.profileSetupTitle,
                      style: tt.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: _Dims.titleGap),
                    Text(
                      l10n.profileSetupSubtitle,
                      style: tt.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: _Dims.formTopGap),

                    // ── Form ─────────────────────────────────────────
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          KpLabeledField(
                            label: l10n.profileNameLabel,
                            child: TextFormField(
                              controller: _nameCtrl,
                              autofocus: true,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: l10n.profileNameHint,
                                prefixIcon: const Icon(Icons.person_outline_rounded),
                              ),
                              validator: (v) {
                                final s = v?.trim() ?? '';
                                if (s.isEmpty) return l10n.profileNameRequired;
                                if (s.length > 80) return l10n.profileNameTooLong;
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: _Dims.fieldGap),
                          KpLabeledField(
                            label: l10n.profileShopLabel,
                            child: TextFormField(
                              controller: _shopCtrl,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => _submit(),
                              decoration: InputDecoration(
                                hintText: l10n.profileShopHint,
                                prefixIcon: const Icon(Icons.storefront_outlined),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                    child: _saving
                        ? FilledButton(onPressed: null, child: const ButtonSpinner())
                        : FilledButton(
                            onPressed: _submit,
                            child: Text(l10n.profileContinueButton),
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
}
