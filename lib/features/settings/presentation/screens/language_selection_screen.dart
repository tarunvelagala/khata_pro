import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/kp_back_button.dart';
import '../../../../core/widgets/scroll_hint_wrapper.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';

// ── Language data ─────────────────────────────────────────────────────────────
typedef _Language = ({String code, String nativeName, String badge});

const List<_Language> _languages = [
  (code: 'en', nativeName: 'English',  badge: 'A'),
  (code: 'hi', nativeName: 'हिन्दी',   badge: 'अ'),
  (code: 'kn', nativeName: 'ಕನ್ನಡ',    badge: 'ಕ'),
  (code: 'ta', nativeName: 'தமிழ்',    badge: 'த'),
  (code: 'bn', nativeName: 'বাংলা',    badge: 'ব'),
  (code: 'mr', nativeName: 'मराठी',    badge: 'म'),
  (code: 'ml', nativeName: 'മലയാളം',   badge: 'മ'),
  (code: 'te', nativeName: 'తెలుగు',   badge: 'త'),
];

// ── File-private layout constants ─────────────────────────────────────────────
abstract final class _Dims {
  static const double headerTopPadding   = 48.0;
  static const double iconSize           = 64.0;
  static const double iconGap            = 24.0;
  static const double titleGap           = 8.0;
  static const double listTopGap         = 32.0;
  static const double rowSpacing         = 10.0;
  static const double badgeSize          = 36.0;
  static const double badgeRadius        = 10.0;
  static const double badgeFontSize      = 15.0;
  static const double rowPaddingV        = 12.0;
  static const double rowPaddingH        = 12.0;
  static const double badgeToNameGap     = 10.0;
}

class LanguageSelectionScreen extends ConsumerStatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  ConsumerState<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState
    extends ConsumerState<LanguageSelectionScreen> {
  String _selectedCode = 'en';

  @override
  void initState() {
    super.initState();
    final locale = ref.read(localeProvider).value;
    if (locale != null) _selectedCode = locale.languageCode;
  }

  Future<void> _onContinue() async {
    await ref.read(localeProvider.notifier).setLocale(_selectedCode);
    if (!mounted) return;
    final prefs       = await SharedPreferences.getInstance();
    final profileDone = prefs.getBool('profile_setup_done') ?? false;
    final tourSeen    = prefs.getBool('tour_seen') ?? false;
    if (!mounted) return;
    if (!profileDone) {
      context.push('/tour');
    } else if (!tourSeen) {
      context.push('/tour');
    } else {
      context.go('/home');
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
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Navigator.of(context).canPop() ? const KpBackButton() : null,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: ScrollHintWrapper(
                hintLabel: l10n.scrollForMore,
                child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.buttonPaddingH,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: _Dims.headerTopPadding),

                          // ── Icon ──────────────────────────────────────
                          Center(
                            child: Container(
                              width: _Dims.iconSize,
                              height: _Dims.iconSize,
                              decoration: BoxDecoration(
                                color: cs.primaryContainer,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.translate_rounded,
                                size: _Dims.iconSize / 2,
                                color: cs.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: _Dims.iconGap),

                          // ── Title + subtitle ──────────────────────────
                          Text(
                            l10n.languageScreenTitle,
                            style: tt.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: cs.onSurface,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: _Dims.titleGap),
                          Text(
                            l10n.languageScreenSubtitle,
                            style: tt.bodyLarge?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: _Dims.listTopGap),

                          // ── Language rows ─────────────────────────────
                          for (int row = 0; row < (_languages.length / 2).ceil(); row++) ...[
                            if (row > 0) const SizedBox(height: _Dims.rowSpacing),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: _LanguageRow(
                                      lang: _languages[row * 2],
                                      isSelected: _selectedCode == _languages[row * 2].code,
                                      onTap: () => setState(() => _selectedCode = _languages[row * 2].code),
                                    ),
                                  ),
                                  const SizedBox(width: _Dims.rowSpacing),
                                  if (row * 2 + 1 < _languages.length)
                                    Expanded(
                                      child: _LanguageRow(
                                        lang: _languages[row * 2 + 1],
                                        isSelected: _selectedCode == _languages[row * 2 + 1].code,
                                        onTap: () => setState(() => _selectedCode = _languages[row * 2 + 1].code),
                                      ),
                                    )
                                  else
                                    const Expanded(child: SizedBox()),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: AppDimensions.buttonPaddingH),
                        ],
                      ),
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
                    child: FilledButton(
                      onPressed: _onContinue,
                      child: Text(l10n.languageContinueButton),
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

// ── Language row — full-width, badge left, name centre, check right ───────────

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({
    required this.lang,
    required this.isSelected,
    required this.onTap,
  });

  final _Language lang;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs           = Theme.of(context).colorScheme;
    final tt           = Theme.of(context).textTheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final borderRadius = BorderRadius.circular(AppDimensions.radiusMedium);
    final bgColor      = isSelected ? cs.primaryContainer : cs.surfaceContainerLow;
    final borderColor  = isSelected ? cs.primary : cs.outlineVariant;
    final borderWidth  = isSelected ? AppDimensions.borderFocused : AppDimensions.borderDefault;

    return AnimatedContainer(
      duration: reduceMotion ? Duration.zero : AppDimensions.animShort,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          splashColor: cs.primary.withValues(alpha: AppDimensions.splashAlpha),
          highlightColor: cs.primary.withValues(alpha: AppDimensions.highlightAlpha),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _Dims.rowPaddingH,
              vertical: _Dims.rowPaddingV,
            ),
            child: Row(
              children: [
                Container(
                  width: _Dims.badgeSize,
                  height: _Dims.badgeSize,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? cs.primary
                        : cs.onSurface.withValues(alpha: AppDimensions.badgeGlassAlpha),
                    borderRadius: BorderRadius.circular(_Dims.badgeRadius),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    lang.badge,
                    style: tt.titleMedium?.copyWith(
                      fontSize: _Dims.badgeFontSize,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? cs.onPrimary : cs.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: _Dims.badgeToNameGap),
                Expanded(
                  child: Text(
                    lang.nativeName,
                    style: tt.bodyMedium?.copyWith(
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle_rounded,
                    color: cs.primary,
                    size: AppDimensions.iconSizeMedium,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
