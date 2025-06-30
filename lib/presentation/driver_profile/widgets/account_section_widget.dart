import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../localization/app_localizations.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class AccountSectionWidget extends StatelessWidget {
  final VoidCallback onPaymentMethods;
  final VoidCallback onTaxDocuments;
  final VoidCallback onReferralProgram;
  final VoidCallback onSupport;
  final VoidCallback onLogout;

  const AccountSectionWidget({
    super.key,
    required this.onPaymentMethods,
    required this.onTaxDocuments,
    required this.onReferralProgram,
    required this.onSupport,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cuenta',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 3.h),

            _buildAccountItem(
              context,
              'account_balance_wallet',
              'Métodos de Pago',
              'Gestiona tus métodos de pago',
              onPaymentMethods,
            ),

            Divider(height: 4.h),

            _buildAccountItem(
              context,
              'receipt_long',
              'Documentos Fiscales',
              'Accede a tus comprobantes fiscales',
              onTaxDocuments,
            ),

            Divider(height: 4.h),

            _buildAccountItem(
              context,
              'card_giftcard',
              'Programa de Referidos',
              'Invita amigos y gana recompensas',
              onReferralProgram,
            ),

            Divider(height: 4.h),

            _buildAccountItem(
              context,
              'help_center',
              AppLocalizations.get('support'),
              'Centro de ayuda y chat en vivo',
              onSupport,
            ),

            Divider(height: 4.h),

            _buildAccountItem(
              context,
              'logout',
              AppLocalizations.get('logout'),
              'Cerrar sesión de forma segura',
              onLogout,
              isLogout: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountItem(
    BuildContext context,
    String iconName,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isLogout = false,
  }) {
    final Color itemColor =
        isLogout ? AppTheme.errorRed : AppTheme.primaryOrange;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: itemColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: iconName,
                  color: itemColor,
                  size: 24,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isLogout ? AppTheme.errorRed : null,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.neutralMedium,
                    ),
                  ),
                ],
              ),
            ),
            CustomIconWidget(
              iconName: 'chevron_right',
              color: AppTheme.neutralMedium,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
