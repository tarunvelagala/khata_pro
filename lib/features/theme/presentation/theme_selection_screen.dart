import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../application/theme_provider.dart';

class ThemeSelectionScreen extends ConsumerWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 64, 24, 120),
              child: Column(
                children: [
                  // ── App Icon & Branding ──
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: cs.primaryContainer.withValues(alpha: isDark ? 0.3 : 1.0),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: cs.shadow.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.menu_book,
                      size: 40,
                      color: cs.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'KhataMitra',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: cs.primary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Choose your theme',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: cs.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 40),

                  // ── Theme Cards ──
                  _ThemeCard(
                    title: 'Light',
                    subtitle: 'Bright white background',
                    icon: Icons.light_mode,
                    mode: ThemeMode.light,
                    currentMode: themeMode,
                    // Use onPrimaryFixedVariant for unselected icon color on primaryFixed bg
                    unselectedIconBg: cs.primaryFixed,
                    unselectedIconColor: cs.onPrimaryFixedVariant,
                    onTap: () => ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.light),
                  ),
                  const SizedBox(height: 16),
                  _ThemeCard(
                    title: 'Dark',
                    subtitle: 'Easy on the eyes at night',
                    icon: Icons.dark_mode,
                    mode: ThemeMode.dark,
                    currentMode: themeMode,
                    unselectedIconBg: cs.inverseSurface,
                    unselectedIconColor: cs.onInverseSurface,
                    onTap: () => ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.dark),
                  ),
                  const SizedBox(height: 16),
                  _ThemeCard(
                    title: 'System Default',
                    subtitle: 'Follows your phone setting',
                    icon: Icons.contrast,
                    mode: ThemeMode.system,
                    currentMode: themeMode,
                    unselectedIconBg: cs.primaryFixed,
                    unselectedIconColor: cs.onPrimaryFixedVariant,
                    onTap: () => ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.system),
                  ),

                  const SizedBox(height: 48),

                  // ── Decorative Bento Grid ──
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 128,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cs.surfaceContainerLowest.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: cs.secondaryContainer,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: 8,
                                width: 64,
                                margin: const EdgeInsets.only(bottom: 4),
                                decoration: BoxDecoration(
                                  color: cs.outlineVariant.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(99),
                                ),
                              ),
                              Container(
                                height: 8,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: cs.outlineVariant.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(99),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 128,
                          decoration: BoxDecoration(
                            color: cs.surfaceContainerLowest.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Icon(
                            Icons.brush_outlined,
                            size: 48,
                            color: cs.outlineVariant.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Sticky Footer ──
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      cs.surface,
                      cs.surface.withValues(alpha: 0.9),
                      cs.surface.withValues(alpha: 0.0),
                    ],
                    stops: const [0, 0.6, 1],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () => context.go('/language'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    minimumSize: const Size(double.infinity, 56),
                    shape: const StadiumBorder(),
                    elevation: 4,
                    shadowColor: cs.primary.withValues(alpha: 0.3),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeCard extends StatelessWidget {
  const _ThemeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.mode,
    required this.currentMode,
    required this.unselectedIconBg,
    required this.unselectedIconColor,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final ThemeMode mode;
  final ThemeMode currentMode;
  final Color unselectedIconBg;
  final Color unselectedIconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = currentMode == mode;
    final cs = Theme.of(context).colorScheme;

    // Selected: cs.primary bg (Dark Navy in light, Light Blue in dark)
    // Unselected: standard surface
    final selectedCardBg = cs.primary;
    final unselectedCardBg = cs.surfaceContainerLowest;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? selectedCardBg : unselectedCardBg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? cs.primary : cs.outlineVariant.withValues(alpha: 0.35),
            width: isSelected ? 2.0 : 1.5,
          ),
        ),
        child: Row(
          children: [
            // Icon box
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                // Selected: White box contrasts perfectly with the primary bg
                color: isSelected ? Colors.white : unselectedIconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                // Selected icon: uses primary color inside white box
                color: isSelected ? cs.primary : unselectedIconColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            // Labels
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          // Selected uses onPrimary for guaranteed contrast
                          color: isSelected ? cs.onPrimary : cs.onSurface,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          // Dimmed onPrimary for subtitle when selected
                          color: isSelected 
                              ? cs.onPrimary.withValues(alpha: 0.8) 
                              : cs.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            // Checkmark
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isSelected
                  ? Icon(
                      Icons.check_circle,
                      key: const ValueKey('check'),
                      color: cs.onPrimary,
                      size: 24,
                    )
                  : const SizedBox(key: ValueKey('empty'), width: 24, height: 24),
            ),
          ],
        ),
      ),
    );
  }
}
