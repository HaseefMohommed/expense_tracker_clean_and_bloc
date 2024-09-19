import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:expesne_tracker_app/utils/enums/goal_category.dart';
import 'package:expesne_tracker_app/features/common/pages/root_background.dart';
import 'package:expesne_tracker_app/features/savings/presentation/bloc/cubit/savings_cubit.dart';
import 'package:expesne_tracker_app/resources/ui_components/app_drop_down/app_drop_down.dart';
import 'package:expesne_tracker_app/resources/ui_components/date_picker/date_picker_dialog_box.dart';
import 'package:expesne_tracker_app/resources/ui_components/text_field/app_text_field.dart';
import 'package:expesne_tracker_app/utils/extentions/locale_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddGoalPage extends StatefulWidget {
  static String routeName = '/addGoalPage';
  const AddGoalPage({super.key});

  @override
  State<AddGoalPage> createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  final _goalTitleController = TextEditingController();
  final _goalAmountController = TextEditingController();
  String? selectedContributionType;
  GoalCategory? selectedCategory;
  DateTime? selectedDeadline;

  void _submitGoal() {
    final title = _goalTitleController.text.trim();
    final amount = int.tryParse(_goalAmountController.text.trim());
    if (title.isNotEmpty &&
        amount != null &&
        selectedCategory != null &&
        selectedContributionType != null &&
        selectedDeadline != null) {
      final formattedDate = DateFormat('MM/dd/yyyy').format(selectedDeadline!);
      FocusManager.instance.primaryFocus?.unfocus();
      context.read<SavingsCubit>().addNewGoal(
            title: title,
            category: selectedCategory!,
            contributionType: selectedContributionType!,
            selectedDate: formattedDate,
            savedAmount: 0,
            goalAmount: amount,
          );
    }
  }

  @override
  void dispose() {
    _goalTitleController.dispose();
    _goalAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return BlocConsumer<SavingsCubit, SavingsState>(
      listener: (context, state) {
        if (state.appState == AppStatus.success) Navigator.pop(context);
      },
      builder: (context, state) {
        return RootBackground(
          pageTitle: locale.add_goal,
          buttonTitle: state.appState == AppStatus.loading
              ? locale.please_wait
              : locale.add_goal,
          onPressed: _submitGoal,
          children: [
            AppTextField(
              hintText: locale.new_house,
              labelText: locale.goal_title,
              controller: _goalTitleController,
            ),
            const SizedBox(height: 16),
            AppTextField(
              hintText: locale.thousand,
              labelText: locale.amount,
              controller: _goalAmountController,
              suffixIconVisible: AssetsPaths.dollerSign,
              isenableNumberPad: true,
            ),
            const SizedBox(height: 16),
            AppDropDown<GoalCategory>(
              title: locale.category,
              items: GoalCategory.values,
              itemAsString: (GoalCategory category) =>
                  category.toString().split('.').last.toLowerCase(),
              onSelect: (option) {
                selectedCategory = option;
              },
            ),
            const SizedBox(height: 16),
            AppDropDown<String>(
              title: locale.contribution_type,
              items: const ['Yearly', 'Monthly', 'Weekly', 'Daily'],
              itemAsString: (String item) => item,
              onSelect: (option) {
                selectedContributionType = option;
              },
            ),
            const SizedBox(height: 16),
            DatePickerDialogBox(
              title: locale.dead_line,
              onDateSelected: (date) {
                selectedDeadline = date;
              },
            ),
          ],
        );
      },
    );
  }
}
