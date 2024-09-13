import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/entries_list_tile.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/over_view_card.dart';
import 'package:expesne_tracker_app/resources/ui_components/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class OverViewPage extends StatefulWidget {
  const OverViewPage({super.key});

  @override
  State<OverViewPage> createState() => _OverViewPageState();
}

class _OverViewPageState extends State<OverViewPage> {
  int _currentIndex = 0;

  void onPressed(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<EntriesListTile> entries = [
    const EntriesListTile(
      title: 'Salary',
      description: '1 Mar 2024',
      iconPath: AssetsPaths.salary,
      amount: '+\$3,500.00',
      paymentMethod: 'Bank Transfer',
    ),
    const EntriesListTile(
      title: 'Grocery Shopping',
      description: '5 Mar 2024',
      iconPath: AssetsPaths.salary,
      amount: '-\$85.50',
      paymentMethod: 'Credit Card',
    ),
    const EntriesListTile(
      title: 'Electricity Bill',
      description: '10 Mar 2024',
      iconPath: AssetsPaths.salary,
      amount: '-\$120.75',
      paymentMethod: 'Auto-Pay',
    ),
    const EntriesListTile(
      title: 'Freelance Work',
      description: '15 Mar 2024',
      iconPath: AssetsPaths.salary,
      amount: '+\$250.00',
      paymentMethod: 'PayPal',
    ),
    const EntriesListTile(
      title: 'Restaurant Dinner',
      description: '20 Mar 2024',
      iconPath: AssetsPaths.salary,
      amount: '-\$65.30',
      paymentMethod: 'Debit Card',
    ),
    const EntriesListTile(
      title: 'Mobile Phone Bill',
      description: '25 Mar 2024',
      iconPath: AssetsPaths.salary,
      amount: '-\$45.99',
      paymentMethod: 'Auto-Pay',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<AppButton> iconButtons = [
      AppButton.icon(
        name: 'savings',
        iconPath: AssetsPaths.apple,
        onPressed: () {
          onPressed(0);
        },
      ),
      AppButton.icon(
        name: 'savings',
        iconPath: AssetsPaths.apple,
        onPressed: () {
          onPressed(1);
        },
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(AppTheme.primaryPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OverviewCard(
                  title: 'title',
                  amount: 'amount',
                  iconPath: AssetsPaths.email,
                ),
                OverviewCard(
                  title: 'title',
                  amount: 'amount',
                  iconPath: AssetsPaths.email,
                  backgroundColor: AppTheme.primaryColor,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppTheme.primaryPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.primaryPadding),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: iconButtons,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: iconButtons.asMap().entries.map((entry) {
                    return Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 4.0,
                      ),
                      child: SvgPicture.asset(
                        _currentIndex == entry.key
                            ? AssetsPaths.activeIndicator
                            : AssetsPaths.inactiveIndicator,
                      ),
                    );
                  }).toList(),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Latest Entries',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    Icon(Icons.more_horiz),
                  ],
                ),
                ...entries
              ],
            ),
          ),
        ],
      ),
    );
  }
}
