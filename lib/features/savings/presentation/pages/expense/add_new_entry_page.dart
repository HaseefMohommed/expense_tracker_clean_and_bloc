import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/expense/add_expense_page.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/entries_list_tile.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/option_card.dart';
import 'package:flutter/material.dart';

class AddNewEntryPage extends StatefulWidget {
  static String routeName = '/addNewEntryPage';
  const AddNewEntryPage({super.key});

  @override
  State<AddNewEntryPage> createState() => _AddNewEntryPageState();
}

class _AddNewEntryPageState extends State<AddNewEntryPage> {
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
    return Scaffold(
      backgroundColor: AppTheme.secondaryPaleColor,
      appBar: AppBar(
        title: const Text(
          'Add',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                AppTheme.primaryPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OptionCard(
                    title: 'Add Income',
                    onTap: () {},
                  ),
                  OptionCard(
                    title: 'Add Expense',
                    backgroundColor: AppTheme.primaryColor,
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AddExpensePage.routeName,
                      );
                    },
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppTheme.primaryPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppTheme.primaryPadding),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latest Entries',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.more_horiz),
                    ],
                  ),
                  ...entries
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
