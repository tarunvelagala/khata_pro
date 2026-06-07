import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/services/reminder_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../screens/attach_image_screen.dart';
import '../screens/customer_picker_screen.dart';
import '../providers/customer_provider.dart';
import '../../../settings/presentation/providers/profile_provider.dart';
import '../../../settings/domain/extensions/profile_extensions.dart';

abstract final class _Dims {
  static const double buttonSize     = 56.0;
  static const double tileWidth      = 72.0;
  static const double iconSize       = 24.0;
  static const double labelGap       = 8.0;
  static const double squircleRadius = 22.0;
}

class QuickActionsRow extends ConsumerWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final cs   = Theme.of(context).colorScheme;
    final tt   = Theme.of(context).textTheme;

    final actions = [
      (
        icon: Icons.person_add_rounded,
        label: l10n.quickActionAddCustomer,
        onTap: () => context.push('/customers/add'),
      ),
      (
        icon: Icons.receipt_long_rounded,
        label: l10n.quickActionGenerateBill,
        onTap: () => _showGenerateBill(context, ref),
      ),
      (
        icon: Icons.notifications_active_rounded,
        label: l10n.quickActionSendReminder,
        onTap: () => _showReminderPicker(context, ref),
      ),
      (
        icon: Icons.payments_rounded,
        label: l10n.quickActionRecordPayment,
        onTap: () => _showCustomerPicker(context, ref),
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((a) {
        return SizedBox(
          width: _Dims.tileWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: _Dims.buttonSize,
                height: _Dims.buttonSize,
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(_Dims.squircleRadius),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowCard,
                      blurRadius: AppDimensions.shadowBlurCard,
                      offset: const Offset(0, AppDimensions.shadowOffsetCard),
                    ),
                  ],
                ),
                child: Material(
                  color: cs.primaryContainer,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(_Dims.squircleRadius),
                  ),
                  child: InkWell(
                    onTap: a.onTap,
                    customBorder: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(_Dims.squircleRadius),
                    ),
                    child: Icon(
                      a.icon,
                      size: _Dims.iconSize,
                      color: cs.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: _Dims.labelGap),
              Text(
                a.label,
                style: tt.labelMedium?.copyWith(color: cs.onSurfaceVariant),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Future<void> _showGenerateBill(BuildContext context, WidgetRef ref) async {
    final l10n       = AppLocalizations.of(context)!;
    final customerId = await context.push<String>(
      '/customers/pick',
      extra: CustomerPickerExtra(title: l10n.generateBillTitle),
    );
    if (customerId == null || !context.mounted) return;
    context.push('/customers/$customerId/bill');
  }

  Future<void> _showCustomerPicker(BuildContext context, WidgetRef ref) async {
    final l10n       = AppLocalizations.of(context)!;
    final customerId = await context.push<String>(
      '/customers/pick',
      extra: CustomerPickerExtra(title: l10n.recordPaymentPickerTitle),
    );
    if (customerId == null || !context.mounted) return;
    context.push('/customers/$customerId/entry/receive');
  }

  Future<void> _showReminderPicker(BuildContext context, WidgetRef ref) async {
    final l10n       = AppLocalizations.of(context)!;
    final customerId = await context.push<String>(
      '/customers/pick',
      extra: CustomerPickerExtra(title: l10n.quickActionSendReminder),
    );
    if (customerId == null || !context.mounted) return;

    final customers = ref.read(customerProvider).value ?? [];
    final customer  = customers.where((c) => c.id == customerId).firstOrNull;
    if (customer == null) return;

    final phone = customer.phone;
    if (phone == null || phone.trim().isEmpty) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.reminderNoPhone)),
      );
      return;
    }
    if (customer.netBalance == 0) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.reminderNoBalance)),
      );
      return;
    }

    final profile      = ref.read(profileProvider).value;
    final businessName = profile.businessName;
    final message = l10n.reminderMessage(
      customer.name,
      customer.netBalance.abs().toStringAsFixed(0),
      businessName,
    );
    final catalogPaths = profile?.catalogImagePaths ?? const [];

    if (catalogPaths.isEmpty) {
      if (!context.mounted) return;
      await ReminderService.sendViaShareSheet(context: context, message: message);
      return;
    }

    if (!context.mounted) return;
    final result = await context.push<AttachResult>(
      '/reminder/attach',
      extra: AttachImageExtra(message: message, imagePaths: catalogPaths),
    );
    if (!context.mounted) return;
    await ReminderService.sendViaShareSheet(
      context: context,
      message: message,
      imagePath: result?.imagePath,
    );
  }
}

