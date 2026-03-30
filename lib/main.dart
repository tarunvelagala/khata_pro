import 'package:flutter/material.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const KhataMitraApp());
}

class KhataMitraApp extends StatelessWidget {
  const KhataMitraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KhataMitra',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const _TypographyPreview(),
    );
  }
}

class _TypographyPreview extends StatelessWidget {
  const _TypographyPreview();

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu_book),
        title: Text('KhataMitra', style: tt.titleLarge),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _Section('Headlines', [
            Text('Display Large', style: tt.displayLarge),
            Text('Headline Large', style: tt.headlineLarge),
            Text('Headline Medium', style: tt.headlineMedium),
            Text('Headline Small', style: tt.headlineSmall),
          ]),
          _Section('Body & Label', [
            Text('Body Large — Inter 16', style: tt.bodyLarge),
            Text('Body Medium — Inter 14', style: tt.bodyMedium),
            Text('Body Small — Inter 12', style: tt.bodySmall),
            Text('LABEL SMALL — CAPS', style: tt.labelSmall),
          ]),
          _Section('Color Roles', [
            _ColorChip('Primary', AppColors.primary, AppColors.onPrimary),
            _ColorChip('Secondary (Credit)', AppColors.secondary, AppColors.onSecondary),
            _ColorChip('Tertiary (Debit)', AppColors.tertiary, AppColors.onTertiary),
            _ColorChip('Error', AppColors.error, AppColors.onError),
            _ColorChip('Surface Container', AppColors.surfaceContainer, AppColors.onSurface),
          ]),
          _Section('Buttons', [
            ElevatedButton(
              key: const ValueKey('btn_continue'),
              onPressed: () {},
              child: const Text('Continue to Dashboard'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              key: const ValueKey('btn_later'),
              onPressed: () {},
              child: const Text('Maybe Later'),
            ),
          ]),
          _Section('Input', [
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.store),
                hintText: 'e.g. Agarwal Kirana Store',
                labelText: 'Shop Name',
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.title, this.children);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 28, bottom: 12),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        const Divider(height: 1),
        const SizedBox(height: 16),
        ...children.map((w) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: w,
            )),
      ],
    );
  }
}

class _ColorChip extends StatelessWidget {
  const _ColorChip(this.label, this.color, this.onColor);

  final String label;
  final Color color;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: onColor),
      ),
    );
  }
}
