import 'package:expesne_tracker_app/constants/assets_provider.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class EntriesListTile extends StatelessWidget {
  final String title;
  final String description;
  final String amount;
  final String paymentMethod;
  const EntriesListTile({
    super.key,
    required this.title,
    required this.description,
    required this.amount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(AssetsProvider.email),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(
            height: 4,
          ),
          Text(description),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(amount),
          const SizedBox(
            height: 4,
          ),
          Text(paymentMethod),
        ],
      ),
    );
  }
}