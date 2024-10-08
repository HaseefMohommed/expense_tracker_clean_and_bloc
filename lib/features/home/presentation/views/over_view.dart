import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/savings/presentation/bloc/cubit/savings_cubit.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/entry/add_new_entry_page.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/entries_list_tile.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/option_button.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/over_view_card.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/entry/entries_page.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/entry/total_expense_page.dart';
import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/income_category.dart';

class OverView extends StatefulWidget {
  const OverView({super.key});

  @override
  State<OverView> createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SavingsCubit>().fetchentries();
      context.read<SavingsCubit>().fetchEntryTotals();
    });
  }

  void onPressed(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<OptionButton> optionButtons = [
      OptionButton(
        title: 'Savings',
        icon: Icons.add,
        isSelected: _currentIndex == 0,
        onPressed: () {
          onPressed(0);
          Navigator.pushNamed(
            context,
            AddNewEntryPage.routeName,
          );
        },
      ),
      OptionButton(
        title: 'Remind',
        icon: Icons.notifications,
        isSelected: _currentIndex == 1,
        onPressed: () {
          onPressed(1);
        },
      ),
      OptionButton(
        title: 'Budget',
        icon: Icons.account_balance_wallet,
        isSelected: _currentIndex == 2,
        onPressed: () {
          onPressed(2);
        },
      ),
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(
            AppTheme.primaryPadding,
          ),
          child: BlocBuilder<SavingsCubit, SavingsState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OverviewCard(
                    title: 'Total Income',
                    amount: '${state.totalIncome}',
                    onTap: () {},
                  ),
                  OverviewCard(
                    title: 'Total Expense',
                    amount: '${state.totalExpense}',
                    backgroundColor: AppTheme.primaryColor,
                    textColor: Colors.white,
                    onTap: () => Navigator.pushNamed(
                      context,
                      TotalExpensePage.routeName,
                    ),
                  )
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Flexible(
          child: Container(
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
                  children: optionButtons,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: optionButtons.asMap().entries.map((entry) {
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
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Latest Entries',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          EntriesPage.routeName,
                        );
                      },
                      icon: const Icon(Icons.more_horiz),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                BlocBuilder<SavingsCubit, SavingsState>(
                  builder: (context, state) => state.appState ==
                          AppStatus.loading
                      ? const Center(child: CircularProgressIndicator())
                      : state.appState == AppStatus.success
                          ? state.entriesList.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No entries yet. Add some entries!',
                                  ),
                                )
                              : Column(
                                  children: state.entriesList
                                      .take(4)
                                      .map((entry) => EntriesListTile(
                                            title: entry.title,
                                            date: entry.addedDate,
                                            amount: entry.amount.toString(),
                                            paymentMethod:
                                                entry.paymentMethod?.name,
                                            iconPath: entry.paymentMethod !=
                                                    null
                                                ? entry.expenseCategory?.icon ??
                                                    AssetsPaths.shopping
                                                : entry.incomeCategory?.icon ??
                                                    AssetsPaths.shopping,
                                          ))
                                      .toList(),
                                )
                          : const Center(
                              child: Text(
                                'An error occurred. Please try again.',
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
