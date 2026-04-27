import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/selection_card.dart';
import '../../../../l10n/app_localizations.dart';

// ── Language data ─────────────────────────────────────────────────────────────
typedef _Language = ({String code, String nativeName, String englishName});

const List<_Language> _languages = [
  (code: 'en', nativeName: 'English', englishName: 'English'),
  (code: 'hi', nativeName: 'हिन्दी', englishName: 'Hindi'),
  (code: 'bn', nativeName: 'বাংলা', englishName: 'Bengali'),
  (code: 'mr', nativeName: 'मराठी', englishName: 'Marathi'),
  (code: 'kn', nativeName: 'ಕನ್ನಡ', englishName: 'Kannada'),
  (code: 'ta', nativeName: 'தமிழ்', englishName: 'Tamil'),
  (code: 'ml', nativeName: 'മലയാളം', englishName: 'Malayalam'),
  (code: 'te', nativeName: 'తెలుగు', englishName: 'Telugu'),
];

// ── File-private layout constants ─────────────────────────────────────────────
abstract final class _Dims {
  static const int gridColumns = 2;
  static const double gridChildRatio = 1.8;
  static const double translateIconSize = 48.0;
  static const double translateIconRadius = 16.0;
  static const double translateIconPad = 16.0;
  static const double headerTopPadding = 24.0;
  static const double iconToTitleGap = 16.0;
  static const double titleToSubtitleGap = 4.0;
  static const double subtitleToGridGap = 24.0;
  static const double ctaHeight = 48.0;
  static const double footerTopRadius = 24.0;
  static const double footerShadowBlur = 12.0;
  static const double footerShadowOpacity = 0.04;
}

const Color _screenBg = Color(0xFFF2F3F5);

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
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('selected_locale');
    if (saved != null && mounted) {
      setState(() => _selectedCode = saved);
    }
  }

  Future<void> _onContinue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_locale', _selectedCode);
    if (!mounted) return;
    context.go('/tour');
  }

  Future<void> _onSkip() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_locale', 'en');
    if (!mounted) return;
    context.go('/tour');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: _screenBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.buttonPaddingH,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: _Dims.headerTopPadding),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(_Dims.translateIconPad),
                        decoration: BoxDecoration(
                          color: cs.primaryContainer,
                          borderRadius: BorderRadius.circular(
                            _Dims.translateIconRadius,
                          ),
                        ),
                        child: Icon(
                          Icons.translate_rounded,
                          size: _Dims.translateIconSize,
                          color: cs.onPrimaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(height: _Dims.iconToTitleGap),
                    Center(
                      child: Text(
                        l10n.languageScreenTitle,
                        style: tt.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: _Dims.titleToSubtitleGap),
                    Center(
                      child: Text(
                        l10n.languageScreenSubtitle,
                        style: tt.bodyMedium?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: _Dims.subtitleToGridGap),
                    GridView.count(
                      crossAxisCount: _Dims.gridColumns,
                      mainAxisSpacing: AppDimensions.radiusSmall,
                      crossAxisSpacing: AppDimensions.radiusSmall,
                      childAspectRatio: _Dims.gridChildRatio,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: _languages.map((lang) {
                        return SelectionCard(
                          title: lang.nativeName,
                          subtitle: lang.englishName,
                          isSelected: _selectedCode == lang.code,
                          onTap: () =>
                              setState(() => _selectedCode = lang.code),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppDimensions.buttonPaddingH),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: cs.surfaceContainerLowest,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(_Dims.footerTopRadius),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(
                      (_Dims.footerShadowOpacity * 255).round(),
                    ),
                    blurRadius: _Dims.footerShadowBlur,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(
                AppDimensions.buttonPaddingH,
                AppDimensions.buttonPaddingV,
                AppDimensions.buttonPaddingH,
                AppDimensions.buttonPaddingV + bottomInset,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: _Dims.ctaHeight,
                    child: FilledButton(
                      onPressed: _onContinue,
                      child: Text(l10n.languageContinueButton),
                    ),
                  ),
                  TextButton(
                    onPressed: _onSkip,
                    child: Text(l10n.languageSkipButton),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
