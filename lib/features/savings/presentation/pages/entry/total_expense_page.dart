import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/entries_list_tile.dart';
import 'package:expesne_tracker_app/features/savings/presentation/bloc/cubit/savings_cubit.dart';
import 'package:expesne_tracker_app/features/savings/presentation/widgets/category_chart.dart';
import 'package:expesne_tracker_app/resources/ui_components/date_picker/table_calender_picker.dart';
import 'package:expesne_tracker_app/utils/extentions/locale_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';

class TotalExpensePage extends StatefulWidget {
  static String routeName = '/totalExpensePage';
  const TotalExpensePage({super.key});

  @override
  State<TotalExpensePage> createState() => _TotalExpensePageState();
}

class _TotalExpensePageState extends State<TotalExpensePage> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SavingsCubit>().fetchEntriesForSpecificDay(
            date: _selectedDate,
          );
      context.read<SavingsCubit>().fetchDailyExpenseByCategory(
            date: _selectedDate,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return Scaffold(
      backgroundColor: AppTheme.secondaryPaleColor,
      appBar: AppBar(
        title: const Text(
          'Total Expenses',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<SavingsCubit, SavingsState>(
        listener: (context, state) {},
        builder: (context, state) {
          double totalExpense = state.entriesForSpecificDay.fold(
            0,
            (sum, entry) => sum + entry.amount,
          );

          List<ChartData> chartData = [];
          if (totalExpense > 0) {
            chartData = state.dailyExpenseAmount.entries.map((entry) {
              double percentage = (entry.value / totalExpense) * 100;
              return ChartData(
                value: percentage,
                color: entry.key.color,
                category: entry.key.displayName.split('.').last,
              );
            }).toList();
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppTheme.primaryPadding),
                child: TableCalenderPicker(
                  onDateSelected: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                    context.read<SavingsCubit>().fetchEntriesForSpecificDay(
                          date: _selectedDate,
                        );
                    context
                        .read<SavingsCubit>()
                        .fetchDailyExpenseByCategory(date: date);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryColor,
                ),
                child: Center(
                  child: Text(
                    '\$${totalExpense.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Total spend for ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: AppTheme.primaryPadding,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppTheme.primaryPadding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          tabs: [
                            Tab(text: 'Spends'),
                            Tab(text: 'Categories'),
                          ],
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              width: 4,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          dividerColor: Colors.transparent,
                          labelColor: AppTheme.primaryColor,
                          unselectedLabelColor: AppTheme.secondaryColor,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              // Spends Tab
                              state.entriesForSpecificDay.isEmpty
                                  ? Center(
                                      child:
                                          Text(locale.no_items_yet('entries')))
                                  : SingleChildScrollView(
                                      child: Column(
                                        children: state.entriesForSpecificDay
                                            .map((entry) {
                                          return EntriesListTile(
                                              title: entry.title,
                                              date: entry.addedDate,
                                              amount: entry.amount.toString(),
                                              paymentMethod:
                                                  entry.paymentMethod?.name,
                                              iconPath:
                                                  entry.expenseCategory?.icon ??
                                                      AssetsPaths.shopping);
                                        }).toList(),
                                      ),
                                    ),
                              // Categories Tab
                              state.dailyExpenseAmount.isEmpty
                                  ? Center(
                                      child:
                                          Text(locale.no_items_yet('entries')))
                                  : SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 20),
                                          CategoryChart(data: chartData),
                                          const SizedBox(height: 20),
                                          ...state.entriesForSpecificDay
                                              .map((entry) {
                                            return EntriesListTile(
                                                title: entry.title,
                                                date: entry.addedDate,
                                                amount: entry.amount.toString(),
                                                paymentMethod:
                                                    entry.paymentMethod?.name,
                                                iconPath: entry.expenseCategory
                                                        ?.icon ??
                                                    AssetsPaths.shopping);
                                          }),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
