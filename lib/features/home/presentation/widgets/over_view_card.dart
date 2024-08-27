import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class OverviewCard extends StatelessWidget {
  final String title;
  final String amount;
  final String iconPath;
  final Color backgroundColor;
  final Color textColor;

  const OverviewCard({
    super.key,
    required this.title,
    required this.amount,
    required this.iconPath,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: backgroundColor,
      child: SizedBox(
        width: 170,
        height: 160,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(iconPath),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
              Text(
                amount,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}