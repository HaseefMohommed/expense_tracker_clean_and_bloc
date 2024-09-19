import 'package:expesne_tracker_app/core/theme.dart';
import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final void Function()? onPressed;

  const OptionButton({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? AppTheme.primaryColor : AppTheme.secondaryPaleColor,
        padding: const EdgeInsets.all(12),
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: isSelected ? AppTheme.secondaryPaleColor : Colors.black,
      ),
      label: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppTheme.secondaryPaleColor : Colors.black,
        ),
      ),
    );
  }
}
