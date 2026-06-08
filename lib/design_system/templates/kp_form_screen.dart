import 'package:flutter/material.dart';

/// Single-column form screen template.
///
/// Handles scroll + sticky CTA layout so feature screens only supply content.
/// The [body] scrolls; [cta] is pinned to the bottom above the keyboard.
///
/// ```dart
/// KpFormScreen(
///   appBar: AppBar(title: Text('Add Customer')),
///   body: CustomerFormFields(),
///   cta: KpFilledButton(label: 'Save', onPressed: _submit),
/// )
/// ```
class KpFormScreen extends StatelessWidget {
  const KpFormScreen({
    super.key,
    required this.appBar,
    required this.body,
    required this.cta,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  });

  final PreferredSizeWidget appBar;
  final Widget body;
  final Widget cta;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(child: body),
            ),
            cta,
          ],
        ),
      ),
    );
  }
}
