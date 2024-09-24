import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:expesne_tracker_app/utils/enums/goal_category.dart';
import 'package:expesne_tracker_app/features/common/pages/root_background.dart';
import 'package:expesne_tracker_app/features/savings/presentation/bloc/cubit/savings_cubit.dart';
import 'package:expesne_tracker_app/resources/ui_components/app_drop_down/app_drop_down.dart';
import 'package:expesne_tracker_app/resources/ui_components/date_picker/date_picker_dialog_box.dart';
import 'package:expesne_tracker_app/resources/ui_components/text_field/app_text_field.dart';
import 'package:expesne_tracker_app/utils/enums/validity_status.dart';
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

  void _validateAndSubmit() {
    final title = _goalTitleController.text.trim();
    final amountString = _goalAmountController.text.trim();
    final formattedDate = selectedDeadline != null
        ? DateFormat('yyyy-MM-dd').format(selectedDeadline!)
        : '';
    final selectedGoalCategory = selectedCategory?.name ?? '';

    
    context.read<SavingsCubit>().validateFields(
          title: title,
          amount: amountString,
          goalCategory: selectedGoalCategory,
          contributionType: selectedContributionType ?? '',
          date: formattedDate,
          isValidDate: selectedDeadline != null,
        );

    
    if (context
        .read<SavingsCubit>()
        .state
        .formValidityStatus
        .values
        .every((status) => status == ValidityStatus.valid)) {
      _submitGoal();
    }
  }

  void _submitGoal() {
    final title = _goalTitleController.text.trim();
    final amount = int.parse(_goalAmountController.text.trim());
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDeadline!);
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

  void _resetForm() {
    setState(() {
      _goalTitleController.clear();
      _goalAmountController.clear();
      selectedContributionType = null;
      selectedCategory = null;
      selectedDeadline = null;
    });
    context.read<SavingsCubit>().resetForm();
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
        if (state.appState == AppStatus.success) {
          _resetForm();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final formValidityStatus = state.formValidityStatus;
        return AbsorbPointer(
          absorbing: state.appState == AppStatus.loading,
          child: RootBackground(
            pageTitle: locale.add_item('Goal'),
            buttonTitle: state.appState == AppStatus.loading
                ? locale.please_wait
                : locale.add_item('Goal'),
            onPressed: _validateAndSubmit,
            children: [
              AppTextField(
                hintText: locale.new_house,
                labelText: locale.item_title('Goal'),
                controller: _goalTitleController,
                errorText: switch (formValidityStatus['title']) {
                  ValidityStatus.valid => null,
                  ValidityStatus.empty => locale.requird_field,
                  ValidityStatus.invalid => locale.please_enter_valid('title'),
                  _ => null,
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                hintText: locale.thousand,
                labelText: locale.amount,
                controller: _goalAmountController,
                suffixIconVisible: AssetsPaths.dollerSign,
                isenableNumberPad: true,
                errorText: switch (formValidityStatus['amount']) {
                  ValidityStatus.valid => null,
                  ValidityStatus.empty =>  locale.requird_field,
                  ValidityStatus.invalid => locale.please_enter_valid('amount'),
                  _ => null,
                },
              ),
              const SizedBox(height: 16),
              AppDropDown<GoalCategory>(
                title: locale.item_category('Goal'),
                items: GoalCategory.values,
                itemAsString: (GoalCategory category) =>
                    category.toString().split('.').last.toLowerCase(),
                onSelect: (option) {
                  setState(() {
                    selectedCategory = option;
                  });
                },
                errorText: switch (formValidityStatus['goalCategory']) {
                  ValidityStatus.valid => null,
                  ValidityStatus.empty =>  locale.requird_field,
                  ValidityStatus.invalid => locale.please_select_valid('Goal Category'),
                  _ => null,
                },
              ),
              const SizedBox(height: 16),
              AppDropDown<String>(
                title: locale.contribution_type,
                items: const ['Yearly', 'Monthly', 'Weekly', 'Daily'],
                itemAsString: (String item) => item,
                onSelect: (option) {
                  setState(() {
                    selectedContributionType = option;
                  });
                },
                errorText: switch (formValidityStatus['contributionType']) {
                  ValidityStatus.valid => null,
                  ValidityStatus.empty =>  locale.requird_field,
                  ValidityStatus.invalid => locale.please_select_valid('Contribution Type'),
                  _ => null,
                },
              ),
              const SizedBox(height: 16),
              DatePickerDialogBox(
                title: locale.dead_line,
                onDateSelected: (date) {
                  setState(() {
                    selectedDeadline = date;
                  });
                },
                errorText: switch (formValidityStatus['date']) {
                  ValidityStatus.valid => null,
                  ValidityStatus.empty =>  locale.requird_field,
                  ValidityStatus.invalid => locale.please_select_valid('Date'),
                  _ => null,
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
