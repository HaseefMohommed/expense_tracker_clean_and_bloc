import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/savings/presentation/bloc/cubit/savings_cubit.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/entry/add_expense_page.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/entries_list_tile.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/option_card.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/entry/add_income_page.dart';
import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/income_category.dart';

class AddNewEntryPage extends StatefulWidget {
  static String routeName = '/addNewEntryPage';
  const AddNewEntryPage({super.key});

  @override
  State<AddNewEntryPage> createState() => _AddNewEntryPageState();
}

class _AddNewEntryPageState extends State<AddNewEntryPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<SavingsCubit>().fetchentries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondaryPaleColor,
      appBar: AppBar(
        title: const Text('Add', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppTheme.primaryPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OptionCard(
                  title: 'Add Income',
                  onTap: () => Navigator.pushNamed(
                    context,
                    AddIncomePage.routeName,
                  ),
                ),
                OptionCard(
                  title: 'Add Expense',
                  backgroundColor: AppTheme.primaryColor,
                  textColor: Colors.white,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AddExpensePage.routeName,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
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
                  const SizedBox(height: 12),
                  Expanded(
                    child: BlocBuilder<SavingsCubit, SavingsState>(
                      builder: (context, state) => state.appState ==
                              AppStatus.loading
                          ? const Center(child: CircularProgressIndicator())
                          : state.appState == AppStatus.success
                              ? state.entriesList.isEmpty
                                  ? const Center(
                                      child: Text(
                                          'No entries yet. Add some entries!'))
                                  : ListView.builder(
                                      itemCount: state.entriesList.length,
                                      itemBuilder: (context, index) {
                                        final entry = state.entriesList[index];
                                        return EntriesListTile(
                                          title: entry.title,
                                          date: entry.addedDate,
                                          amount: entry.amount.toString(),
                                          paymentMethod:
                                              entry.paymentMethod?.name,
                                          iconPath: entry.paymentMethod != null
                                              ? entry.expenseCategory?.icon ??
                                                  AssetsPaths.shopping
                                              : entry.incomeCategory?.icon ??
                                                  AssetsPaths.shopping,
                                        );
                                      },
                                    )
                              : const Center(
                                  child: Text(
                                      'An error occurred. Please try again.')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
