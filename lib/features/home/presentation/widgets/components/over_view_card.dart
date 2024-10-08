import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class OverviewCard extends StatelessWidget {
  final String title;
  final String amount;
  final void Function() onTap;

  final Color backgroundColor;
  final Color textColor;

  const OverviewCard({
    super.key,
    required this.title,
    required this.amount,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        color: backgroundColor,
        child: SizedBox(
          width: 170,
          height: 130,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AssetsPaths.wallet,
                    ),
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
      ),
    );
  }
}
