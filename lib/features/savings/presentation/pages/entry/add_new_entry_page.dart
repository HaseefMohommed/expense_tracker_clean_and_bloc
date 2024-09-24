import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/savings/presentation/bloc/cubit/savings_cubit.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/entry/add_expense_page.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/entries_list_tile.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/option_card.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/entry/add_income_page.dart';
import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:expesne_tracker_app/utils/extentions/locale_extention.dart';
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
    final locale = context.locale;
    return Scaffold(
      backgroundColor: AppTheme.secondaryPaleColor,
      appBar: AppBar(
        title: Text(
          locale.add_item(''),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
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
                  title: locale.add_item('Income'),
                  onTap: () => Navigator.pushNamed(
                    context,
                    AddIncomePage.routeName,
                  ),
                ),
                OptionCard(
                  title: locale.add_item('Expense'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.latest_entries,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.more_horiz),
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
                                  ? Center(
                                      child: Text(
                                      locale.no_items_yet('entries'),
                                    ))
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
                              : Center(
                                  child: Text(
                                  locale.an_error_occurred,
                                )),
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
