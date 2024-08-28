import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/core/theme.dart';

import 'package:svg_flutter/svg_flutter.dart';

enum ButtonType { primary, secondary, icon }

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String name;
  final ButtonType type;
  final String? iconPath;
  final bool? enabledBorder;

  factory AppButton({
    void Function()? onPressed,
    required String name,
  }) {
    return AppButton._(
      onPressed: onPressed,
      name: name,
      type: ButtonType.primary,
    );
  }
  const AppButton._({
    this.onPressed,
    required this.name,
    required this.type,
    this.iconPath,
    this.enabledBorder,
  });

  factory AppButton.seondary({
    void Function()? onPressed,
    required String name,
    bool? enabledBorder,
  }) {
    return AppButton._(
      onPressed: onPressed,
      name: name,
      type: ButtonType.secondary,
      enabledBorder: enabledBorder,
    );
  }

  factory AppButton.icon({
    void Function()? onPressed,
    required String name,
    required String iconPath,
    bool? enabledBorder,
  }) {
    return AppButton._(
      onPressed: onPressed,
      name: name,
      iconPath: iconPath,
      type: ButtonType.icon,
      enabledBorder: enabledBorder,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDarkMode ? Colors.white : Colors.black;
    return SizedBox(
      height: AppTheme.primaryButtonHeight,
      child: switch (type) {
        ButtonType.primary => ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                AppTheme.primaryColor.withOpacity(onPressed == null ? 0.3 : 1),
              ),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            ),
            child: Text(
              name,
              style: const TextStyle(fontSize: AppTheme.primaryButtonFontSize),
            ),
          ),
        ButtonType.secondary => ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              shape: enabledBorder == true
                  ? WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        side: const BorderSide(
                          color: AppTheme.buttonBorderColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    )
                  : null,
              backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
              foregroundColor:
                  WidgetStateProperty.all<Color>(AppTheme.secondaryColor),
            ),
            child: Text(
              name,
              style: const TextStyle(
                  fontSize: AppTheme.primaryButtonFontSize,
                  color: AppTheme.textColor),
            ),
          ),
        ButtonType.icon => ElevatedButton.icon(
            onPressed: onPressed,
            style: ButtonStyle(
              elevation: WidgetStateProperty.all<double>(0),
              backgroundColor:
                  WidgetStateProperty.all<Color>(Colors.transparent),
              foregroundColor:
                  WidgetStateProperty.all<Color>(AppTheme.secondaryColor),
              shape: enabledBorder == true
                  ? WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        side: const BorderSide(
                          color: AppTheme.buttonBorderColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    )
                  : null,
            ),
            icon: isDarkMode
                ? SvgPicture.asset(
                    iconPath!,
                    colorFilter: ColorFilter.mode(baseColor, BlendMode.srcIn),
                  )
                : SvgPicture.asset(
                    iconPath!,
                  ),
            label: Text(
              name,
              style: TextStyle(
                fontSize: AppTheme.primaryButtonFontSize,
                color: baseColor,
              ),
            ),
          ),
      },
    );
  }
}
