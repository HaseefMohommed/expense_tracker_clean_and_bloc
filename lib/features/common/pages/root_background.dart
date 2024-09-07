import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/resources/ui_components/buttons/app_button.dart';

class RootBackground extends StatelessWidget {
  final String title;
  final bool isEnabledButton;
  final List<Widget> children;
  final VoidCallback onPressed;

  const RootBackground({
    super.key,
    required this.title,
    required this.children,
    required this.onPressed,
    this.isEnabledButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondaryPaleColor,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            AppTheme.primaryPadding,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: children,
                ),
              ),
              if (isEnabledButton) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    name: title,
                    onPressed: onPressed,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
