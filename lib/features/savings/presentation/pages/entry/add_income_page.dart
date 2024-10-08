import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/features/savings/presentation/bloc/cubit/savings_cubit.dart';
import 'package:expesne_tracker_app/resources/ui_components/app_drop_down/app_drop_down.dart';
import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:expesne_tracker_app/utils/enums/income_category.dart';
import 'package:expesne_tracker_app/utils/enums/validity_status.dart';
import 'package:expesne_tracker_app/utils/extentions/locale_extention.dart';
import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/features/common/pages/root_background.dart';
import 'package:expesne_tracker_app/resources/ui_components/date_picker/table_calender_picker.dart';
import 'package:expesne_tracker_app/resources/ui_components/text_field/app_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddIncomePage extends StatefulWidget {
  static String routeName = '/addIncomePage';
  const AddIncomePage({super.key});

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  final _incomeTitleController = TextEditingController();
  final _incomeAmountController = TextEditingController();
  IncomeCategory? selectedCategory;
  DateTime? selectedDate;

  void _validateAndSubmit() {
    final title = _incomeTitleController.text.trim();
    final amountString = _incomeAmountController.text.trim();
    final formattedDate = selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(selectedDate!)
        : '';

    context.read<SavingsCubit>().validateFields(
          title: title,
          amount: amountString,
          date: formattedDate,
          incomeCategory: selectedCategory?.name ?? '',
          isValidDate: selectedDate != null,
        );

    if (context
        .read<SavingsCubit>()
        .state
        .formValidityStatus
        .values
        .every((status) => status == ValidityStatus.valid)) {
      _submitIncome();
    }
  }

  void _submitIncome() {
    final title = _incomeTitleController.text.trim();
    final amount = int.parse(_incomeAmountController.text.trim());
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);

    context.read<SavingsCubit>().addNewEntry(
          title: title,
          addedDate: formattedDate,
          amount: amount,
          incomeCategory: selectedCategory,
        );
  }

  void _resetForm() {
    setState(() {
      _incomeTitleController.clear();
      _incomeAmountController.clear();
      selectedCategory = null;
      selectedDate = null;
    });
    context.read<SavingsCubit>().resetForm();
  }

  @override
  void dispose() {
    _incomeAmountController.dispose();
    _incomeTitleController.dispose();
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
            pageTitle: locale.add_item('Income'),
            onPressed: _validateAndSubmit,
            buttonTitle: state.appState == AppStatus.loading
                ? locale.please_wait
                : locale.add_item('Income'),
            children: [
              TableCalenderPicker(
                onDateSelected: (value) {
                  setState(() {
                    selectedDate = value;
                  });
                },
                errorText: switch (formValidityStatus['date']) {
                  ValidityStatus.valid => null,
                  ValidityStatus.empty => locale.requird_field,
                  ValidityStatus.invalid => locale.please_select_valid('Date'),
                  _ => null,
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _incomeTitleController,
                hintText: locale.salary,
                labelText: locale.item_title('Income'),
                errorText: switch (formValidityStatus['title']) {
                  ValidityStatus.valid => null,
                  ValidityStatus.empty => locale.requird_field,
                  ValidityStatus.invalid => locale.please_enter_valid('title'),
                  _ => null,
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _incomeAmountController,
                hintText: locale.thousand,
                labelText: locale.amount,
                suffixIconVisible: AssetsPaths.dollerSign,
                isenableNumberPad: true,
                errorText: switch (formValidityStatus['amount']) {
                  ValidityStatus.valid => null,
                  ValidityStatus.empty => locale.requird_field,
                  ValidityStatus.invalid => locale.please_enter_valid('amount'),
                  _ => null,
                },
              ),
              const SizedBox(height: 16),
              AppDropDown<IncomeCategory>(
                title: locale.item_category('Income'),
                items: IncomeCategory.values,
                itemAsString: (IncomeCategory category) =>
                    category.displayName.split('.').last,
                onSelect: (option) {
                  setState(() {
                    selectedCategory = option;
                  });
                },
                errorText: switch (formValidityStatus['incomeCategory']) {
                  ValidityStatus.valid => null,
                  ValidityStatus.empty => locale.requird_field,
                  ValidityStatus.invalid =>
                    locale.please_select_valid('Income Category'),
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
