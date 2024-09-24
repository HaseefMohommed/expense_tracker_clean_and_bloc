import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/entries_list_tile.dart';
import 'package:expesne_tracker_app/features/savings/presentation/bloc/cubit/savings_cubit.dart';
import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:expesne_tracker_app/utils/extentions/locale_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/income_category.dart';

class EntriesPage extends StatefulWidget {
  static String routeName = '/entriesPage';
  const EntriesPage({super.key});

  @override
  State<EntriesPage> createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<SavingsCubit>().fetchentries());
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.latest_entries,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.primaryPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              locale.latest_entries,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            BlocConsumer<SavingsCubit, SavingsState>(
              listener: (context, state) {},
              builder: (context, state) {
                return state.appState == AppStatus.loading
                    ? const Center(child: CircularProgressIndicator())
                    : state.appState == AppStatus.success
                        ? state.entriesList.isEmpty
                            ?  Center(
                                child: Text(
                                  locale.no_items_yet('entries'),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.entriesList.length,
                                itemBuilder: (context, index) {
                                  final entry = state.entriesList[index];
                                  return EntriesListTile(
                                    title: entry.title,
                                    date: entry.addedDate,
                                    amount: entry.amount.toString(),
                                    paymentMethod: entry.paymentMethod?.name,
                                    iconPath: entry.paymentMethod != null
                                        ? entry.expenseCategory?.icon ??
                                            AssetsPaths.shopping
                                        : entry.incomeCategory?.icon ??
                                            AssetsPaths.shopping,
                                  );
                                },
                              )
                        :  Center(
                            child: Text(
                              locale.an_error_occurred,
                            ),
                          );
              },
            ),
          ],
        ),
      ),
    );
  }
}
