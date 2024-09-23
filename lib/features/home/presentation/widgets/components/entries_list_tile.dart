import 'package:expesne_tracker_app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class EntriesListTile extends StatelessWidget {
  final String title;
  final String date;
  final String iconPath;
  final String amount;
  final String? paymentMethod;

  const EntriesListTile({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    this.paymentMethod,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(iconPath),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.secondaryColor,
            ),
          ),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                paymentMethod != null ? Icons.remove : Icons.add,
                size: 16,
                color: paymentMethod != null
                    ? AppTheme.errorColor
                    : AppTheme.successColor,
              ),
              const SizedBox(width: 4),
              Text(
                '\$$amount',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (paymentMethod != null) ...[
            const SizedBox(height: 4),
            Text(
              paymentMethod!,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.secondaryColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
