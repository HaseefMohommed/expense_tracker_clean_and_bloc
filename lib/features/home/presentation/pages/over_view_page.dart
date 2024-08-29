import 'package:expesne_tracker_app/constants/assets_provider.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/over_view_card.dart';
import 'package:expesne_tracker_app/resources/ui_components/buttons/app_button.dart';
import 'package:flutter/material.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(
              AppTheme.primaryPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OverviewCard(
                  title: 'title',
                  amount: 'amount',
                  iconPath: AssetsProvider.email,
                ),
                OverviewCard(
                  title: 'title',
                  amount: 'amount',
                  iconPath: AssetsProvider.email,
                  backgroundColor: AppTheme.primaryColor,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(
              AppTheme.primaryPadding,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                AppTheme.primaryPadding,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    AppButton.icon(
                        name: 'savings', iconPath: AssetsProvider.apple)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
