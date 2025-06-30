import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../localization/app_localizations.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class SettingsSectionWidget extends StatelessWidget {
  final bool isDarkMode;
  final bool notificationsEnabled;
  final String selectedLanguage;
  final Function(bool) onDarkModeToggle;
  final Function(bool) onNotificationToggle;
  final VoidCallback onLanguagePress;
  final VoidCallback onPrivacyPress;

  const SettingsSectionWidget({
    super.key,
    required this.isDarkMode,
    required this.notificationsEnabled,
    required this.selectedLanguage,
    required this.onDarkModeToggle,
    required this.onNotificationToggle,
    required this.onLanguagePress,
    required this.onPrivacyPress,
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
              AppLocalizations.get('settings'),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 3.h),

            // Notifications Toggle
            _buildSettingsToggle(
              context,
              'notifications',
              'Notificaciones',
              'Recibe alertas de nuevos viajes y mensajes',
              notificationsEnabled,
              onNotificationToggle,
            ),

            Divider(height: 4.h),

            // Dark Mode Toggle
            _buildSettingsToggle(
              context,
              'dark_mode',
              'Modo Oscuro',
              'Ideal para conducir de noche',
              isDarkMode,
              onDarkModeToggle,
            ),

            Divider(height: 4.h),

            // Language Selection
            _buildSettingsItem(
              context,
              'language',
              'Idioma',
              selectedLanguage,
              onLanguagePress,
              showArrow: true,
            ),

            Divider(height: 4.h),

            // Privacy Controls
            _buildSettingsItem(
              context,
              'privacy_tip',
              'Privacidad y Seguridad',
              'Gestiona tu información personal',
              onPrivacyPress,
              showArrow: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsToggle(
    BuildContext context,
    String iconName,
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: AppTheme.primaryOrange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: iconName,
              color: AppTheme.primaryOrange,
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
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 0.5.h),
              Text(
                subtitle,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.neutralMedium),
              ),
            ],
          ),
        ),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    String iconName,
    String title,
    String value,
    VoidCallback onTap, {
    bool showArrow = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.5.h),
        child: Row(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: AppTheme.primaryOrange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: iconName,
                  color: AppTheme.primaryOrange,
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
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.neutralMedium,
                    ),
                  ),
                ],
              ),
            ),
            if (showArrow)
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
