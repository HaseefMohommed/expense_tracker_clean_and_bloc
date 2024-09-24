import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/savings/presentation/bloc/cubit/savings_cubit.dart';
import 'package:expesne_tracker_app/features/savings/presentation/widgets/goal_list_tile.dart';
import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:expesne_tracker_app/utils/extentions/locale_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expesne_tracker_app/utils/enums/goal_category.dart';

class YourGoalsPage extends StatefulWidget {
  static String routeName = '/yourGoalsPage';
  const YourGoalsPage({super.key});

  @override
  State<YourGoalsPage> createState() => _YourGoalsPageState();
}

class _YourGoalsPageState extends State<YourGoalsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<SavingsCubit>().fetchGoals());
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.your_goals,
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
              locale.all_your_goals,
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
                        ? state.goalsList.isEmpty
                            ? Center(
                                child: Text(
                                  locale.no_goals_available,
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.goalsList.length,
                                itemBuilder: (context, index) {
                                  final goal = state.goalsList[index];
                                  return GoalListTile(
                                    icon: goal.category.icon,
                                    title: goal.title,
                                    savedAmount: goal.savedAmount,
                                    goalAmount: goal.goalAmount,
                                  );
                                },
                              )
                        : Center(
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
