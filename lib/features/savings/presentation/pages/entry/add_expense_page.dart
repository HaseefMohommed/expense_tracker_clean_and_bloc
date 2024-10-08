import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/features/savings/presentation/bloc/cubit/savings_cubit.dart';
import 'package:expesne_tracker_app/resources/ui_components/app_drop_down/app_drop_down.dart';
import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';
import 'package:expesne_tracker_app/utils/enums/validity_status.dart';
import 'package:expesne_tracker_app/utils/extentions/locale_extention.dart';
import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/features/common/pages/root_background.dart';
import 'package:expesne_tracker_app/resources/ui_components/date_picker/table_calender_picker.dart';
import 'package:expesne_tracker_app/resources/ui_components/text_field/app_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatefulWidget {
  static String routeName = '/addExpensePage';
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _expenseTitleController = TextEditingController();
  final _expenseAmountController = TextEditingController();
  ExpenseCategory? selectedCategory;
  PaymentMethod? selectedPaymentMethod;
  DateTime? selectedDate;

  void _validateAndSubmit() {
    final title = _expenseTitleController.text.trim();
    final amountString = _expenseAmountController.text.trim();
    final formattedDate = selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(selectedDate!)
        : '';

    context.read<SavingsCubit>().validateFields(
          title: title,
          amount: amountString,
          date: formattedDate,
          expenseCategory: selectedCategory?.name ?? '',
          paymentMethod: selectedPaymentMethod?.name ?? '',
          isValidDate: selectedDate != null,
        );

    if (context
        .read<SavingsCubit>()
        .state
        .formValidityStatus
        .values
        .every((status) => status == ValidityStatus.valid)) {
      _submitExpense();
    }
  }

  void _submitExpense() {
    final title = _expenseTitleController.text.trim();
    final amount = int.parse(_expenseAmountController.text.trim());
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);

    context.read<SavingsCubit>().addNewEntry(
          title: title,
          addedDate: formattedDate,
          expenseCategory: selectedCategory,
          paymentMethod: selectedPaymentMethod,
          amount: amount,
        );
    context.read<SavingsCubit>().fetchentries();
    context.read<SavingsCubit>().fetchEntryTotals();
  }

  void _resetForm() {
    setState(() {
      _expenseTitleController.clear();
      _expenseAmountController.clear();
      selectedPaymentMethod = null;
      selectedCategory = null;
      selectedDate = null;
    });
    context.read<SavingsCubit>().resetForm();
  }

  @override
  void dispose() {
    _expenseAmountController.dispose();
    _expenseTitleController.dispose();
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
            pageTitle: locale.add_item('Expense'),
            onPressed: _validateAndSubmit,
            buttonTitle: state.appState == AppStatus.loading
                ? locale.please_wait
                : locale.add_item('Expense'),
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
                controller: _expenseTitleController,
                hintText: locale.family_expense,
                labelText: locale.item_title('Expense'),
                errorText: switch (formValidityStatus['title']) {
                  ValidityStatus.valid => null,
                  ValidityStatus.empty => locale.requird_field,
                  ValidityStatus.invalid => locale.please_enter_valid('Title'),
                  _ => null,
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _expenseAmountController,
                hintText: locale.thousand,
                labelText: locale.amount,
                suffixIconVisible: AssetsPaths.dollerSign,
                isenableNumberPad: true,
                errorText: switch (formValidityStatus['amount']) {
                  ValidityStatus.valid => null,
                  ValidityStatus.empty => locale.requird_field,
                  ValidityStatus.invalid => locale.please_enter_valid('Amount'),
                  _ => null,
                },
              ),
              const SizedBox(height: 16),
              AppDropDown<ExpenseCategory>(
                title: locale.item_category('Expense'),
                items: ExpenseCategory.values,
                itemAsString: (ExpenseCategory category) =>
                    category.displayName.split('.').last,
                onSelect: (option) {
                  setState(() {
                    selectedCategory = option;
                  });
                },
                errorText: switch (formValidityStatus['expenseCategory']) {
                  ValidityStatus.valid => null,
                  ValidityStatus.empty => locale.requird_field,
                  ValidityStatus.invalid =>
                    locale.please_select_valid('Expense Category'),
                  _ => null,
                },
              ),
              AppDropDown<PaymentMethod>(
                title: locale.payment_method,
                items: PaymentMethod.values,
                itemAsString: (PaymentMethod paymentMethod) =>
                    paymentMethod.displayName.split('.').last,
                onSelect: (option) {
                  setState(() {
                    selectedPaymentMethod = option;
                  });
                },
                errorText: switch (formValidityStatus['paymentMethod']) {
                  ValidityStatus.valid => null,
                  ValidityStatus.empty => locale.requird_field,
                  ValidityStatus.invalid =>
                    locale.please_select_valid('Payment Method'),
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
