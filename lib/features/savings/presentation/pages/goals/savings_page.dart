import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/savings/presentation/bloc/cubit/savings_cubit.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/goals/your_goals_page.dart';
import 'package:expesne_tracker_app/features/savings/presentation/widgets/goal_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expesne_tracker_app/utils/enums/goal_category.dart';
import 'package:intl/intl.dart';

class SavingsPage extends StatefulWidget {
  static String pageTitle = 'Savings';
  const SavingsPage({super.key});

  @override
  State<SavingsPage> createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SavingsCubit>().fetchGoalSavedAmount();
      context.read<SavingsCubit>().fetchGoals();
      context.read<SavingsCubit>().fetchMonthlyAmount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SavingsCubit, SavingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppTheme.primaryPadding),
              child: Column(
                children: [
                  const Text(
                    'Current Savings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        '\$${state.savedAmount}',
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(AppTheme.primaryPadding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.secondaryColor.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: AppTheme.secondaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              DateFormat('MMMM yyyy').format(DateTime.now()),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Goal for this Month',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        DefaultTabController(
                          length: 2,
                          child: ColoredBox(
                            color: AppTheme.secondaryPaleColor,
                            child: Column(
                              children: [
                                TabBar(
                                  tabs: [
                                    Tab(
                                        text:
                                            '\$ ${state.monthlyGoalAmount['GoalAmount']}'),
                                    Tab(
                                        text:
                                            '\$ ${state.monthlyGoalAmount['SavedAmount']}'),
                                  ],
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppTheme.primaryColor,
                                  ),
                                  dividerColor: Colors.transparent,
                                  labelStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  unselectedLabelStyle: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(AppTheme.primaryPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your Goals',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            YourGoalsPage.routeName,
                          );
                        },
                        icon: const Icon(Icons.more_horiz),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  state.goalsList.isEmpty
                      ? const Text(
                          'No goals available',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.secondaryColor,
                          ),
                        )
                      : Column(
                          children: state.goalsList
                              .take(2)
                              .map((goal) => GoalListTile(
                                    icon: goal.category.icon,
                                    title: goal.title,
                                    savedAmount: goal.savedAmount,
                                    goalAmount: goal.goalAmount,
                                  ))
                              .toList(),
                        ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
