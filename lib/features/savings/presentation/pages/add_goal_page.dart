import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/core/enums/app_status.dart';
import 'package:expesne_tracker_app/features/common/pages/root_background.dart';
import 'package:expesne_tracker_app/features/savings/presentation/bloc/cubit/goal_cubit.dart';
import 'package:expesne_tracker_app/resources/ui_components/app_drop_down/app_drop_down.dart';
import 'package:expesne_tracker_app/resources/ui_components/date_picker/date_picker_dialog_box.dart';
import 'package:expesne_tracker_app/resources/ui_components/text_field/app_text_field.dart';
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
  String? selectedCategory;
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

      context.read<GoalCubit>().addNewGoal(
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
    return BlocConsumer<GoalCubit, GoalState>(
      listener: (context, state) {
        if (state.appState == AppStatus.success) Navigator.pop(context);
      },
      builder: (context, state) {
        return RootBackground(
          pageTitle: 'Add Goal',
          buttonTitle: state.appState == AppStatus.loading
              ? 'Please wait..'
              : 'Add Goal',
          onPressed: _submitGoal,
          children: [
            AppTextField(
              hintText: 'New House',
              labelText: 'Goal Title',
              controller: _goalTitleController,
            ),
            const SizedBox(height: 16),
            AppTextField(
              hintText: '1000',
              labelText: 'Amount',
              controller: _goalAmountController,
              suffixIconVisible: AssetsPaths.dollerSign,
            ),
            const SizedBox(height: 16),
            AppDropDown(
              title: 'Category',
              items: const [
                'Emergency Fund',
                'Debt Repayment',
                'Retirement Fund',
                'Major Purchases',
                'Education Fund',
              ],
              onSelect: (option) {
                selectedCategory = option;
              },
            ),
            const SizedBox(height: 16),
            AppDropDown(
              title: 'Contribution Type',
              items: const [
                'Yearly',
                'Monthly',
                'Weekly',
                'Daily',
              ],
              onSelect: (option) {
                selectedContributionType = option;
              },
            ),
            const SizedBox(height: 16),
            DatePickerDialogBox(
              title: 'Deadline',
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
