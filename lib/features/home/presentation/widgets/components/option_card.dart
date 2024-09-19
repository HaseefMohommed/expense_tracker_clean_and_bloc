import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final void Function() onTap;
  const OptionCard({
    super.key,
    required this.title,
    this.backgroundColor = Colors.white,
    required this.onTap,
    this.textColor = Colors.black,
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
          width: 150,
          height: 90,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      color: textColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
