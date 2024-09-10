import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/resources/ui_components/buttons/app_button.dart';

class RootBackground extends StatelessWidget {
  final String pageTitle;
  final bool isEnabledButton;
  final List<Widget> children;
  final String buttonTitle;
  final void Function() onPressed;

  const RootBackground({
    super.key,
    required this.pageTitle,
    required this.children,
    required this.onPressed,
    this.isEnabledButton = true,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondaryPaleColor,
      appBar: AppBar(
        title: Text(
          pageTitle,
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
                  child: SingleChildScrollView(
                child: Column(
                  children: children,
                ),
              )),
              if (isEnabledButton) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    name: buttonTitle,
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
