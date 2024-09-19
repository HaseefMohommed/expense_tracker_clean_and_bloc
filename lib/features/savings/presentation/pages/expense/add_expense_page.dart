import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/features/savings/presentation/bloc/cubit/savings_cubit.dart';
import 'package:expesne_tracker_app/resources/ui_components/app_drop_down/app_drop_down.dart';
import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';
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

  void _submitExpense() {
    final title = _expenseTitleController.text.trim();
    final amount = int.tryParse(_expenseAmountController.text.trim());
    if (title.isNotEmpty &&
        amount != null &&
        selectedCategory != null &&
        selectedPaymentMethod != null &&
        selectedDate != null) {
      final formattedDate = DateFormat('MM/dd/yyyy').format(selectedDate!);

      context.read<SavingsCubit>().addNewExpense(
            title: title,
            addedDate: formattedDate,
            expenseCategory: selectedCategory!,
            paymentMethod: selectedPaymentMethod!,
            amount: amount,
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _expenseAmountController.dispose();
    _expenseTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SavingsCubit, SavingsState>(
      listener: (context, state) {
        if (state.appState == AppStatus.success) Navigator.pop(context);
      },
      builder: (context, state) {
        return RootBackground(
          pageTitle: 'Add Expense',
          onPressed: _submitExpense,
          buttonTitle: state.appState == AppStatus.loading
              ? 'Please wait..'
              : 'Add Expense',
          children: [
            TableCalenderPicker(
              onDateSelected: (value) {
                selectedDate = value;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            AppTextField(
              controller: _expenseTitleController,
              hintText: 'Family Expense',
              labelText: 'Expense Title',
            ),
            const SizedBox(
              height: 16,
            ),
            AppTextField(
              controller: _expenseAmountController,
              hintText: '1000',
              labelText: 'Amount',
              suffixIconVisible: AssetsPaths.dollerSign,
              isenableNumberPad: true,
            ),
            const SizedBox(
              height: 16,
            ),
            AppDropDown<ExpenseCategory>(
              title: 'Expense Category',
              items: ExpenseCategory.values,
              itemAsString: (ExpenseCategory category) =>
                  category.toString().split('.').last.toLowerCase(),
              onSelect: (option) {
                selectedCategory = option;
              },
            ),
            AppDropDown<PaymentMethod>(
              title: 'Payment Method',
              items: PaymentMethod.values,
              itemAsString: (PaymentMethod paymentMethod) =>
                  paymentMethod.toString().split('.').last.toLowerCase(),
              onSelect: (option) {
                selectedPaymentMethod = option;
              },
            ),
          ],
        );
      },
    );
  }
}
