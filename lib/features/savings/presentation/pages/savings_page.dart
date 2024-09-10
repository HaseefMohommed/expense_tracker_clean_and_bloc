import 'package:expesne_tracker_app/constants/assets_provider.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/savings/presentation/bloc/cubit/goal_cubit.dart';
import 'package:expesne_tracker_app/features/savings/presentation/widgets/goal_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavingsPage extends StatefulWidget {
  static String pageTitle = 'Savings';
  const SavingsPage({super.key});

  @override
  State<SavingsPage> createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<GoalCubit>().fetchgoals();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(
            AppTheme.primaryPadding,
          ),
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
                child: const Center(
                  child: Text(
                    '\$800',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(
                  AppTheme.primaryPadding,
                ),
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
                    const Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 18, color: AppTheme.secondaryColor),
                        SizedBox(width: 8),
                        Text(
                          'July 2024',
                          style: TextStyle(
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
                              tabs: const [
                                Tab(text: '\$ 200'),
                                Tab(text: '\$ 500'),
                              ],
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppTheme.primaryColor,
                              ),
                              dividerColor: Colors.transparent,
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              unselectedLabelStyle: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
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
          child: BlocBuilder<GoalCubit, GoalState>(
            builder: (context, state) {
              return Column(
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
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (state.goalsList == null || state.goalsList!.isEmpty)
                    const Text(
                      'No goals available',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.secondaryColor,
                      ),
                    )
                  else
                    Column(
                      children: state.goalsList!
                          .take(2)
                          .map((goal) => GoalListTile(
                                icon: AssetsProvider.apple,
                                title: goal.title,
                                savedAmount: goal.savedAmount,
                                goalAmount: goal.goalAmount,
                              ))
                          .toList(),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
