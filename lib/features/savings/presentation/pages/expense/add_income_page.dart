import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/resources/ui_components/app_drop_down/app_drop_down.dart';
import 'package:expesne_tracker_app/utils/enums/Income_category.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';
import 'package:flutter/material.dart';

import 'package:expesne_tracker_app/features/common/pages/root_background.dart';
import 'package:expesne_tracker_app/resources/ui_components/date_picker/table_calender_picker.dart';
import 'package:expesne_tracker_app/resources/ui_components/text_field/app_text_field.dart';

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
  PaymentMethod? selectedPaymentMethod;
  DateTime? selectedDate;

  @override
  void dispose() {
    super.dispose();
    _incomeAmountController.dispose();
    _incomeTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootBackground(
      pageTitle: 'Add Income',
      onPressed: () {},
      buttonTitle: 'Add Income',
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
          controller: _incomeTitleController,
          hintText: 'Family Income',
          labelText: 'Income Title',
        ),
        const SizedBox(
          height: 16,
        ),
        AppTextField(
          controller: _incomeAmountController,
          hintText: '1000',
          labelText: 'Amount',
          suffixIconVisible: AssetsPaths.dollerSign,
          isenableNumberPad: true,
        ),
        const SizedBox(
          height: 16,
        ),
        AppDropDown<IncomeCategory>(
          title: 'Income Category',
          items: IncomeCategory.values,
          itemAsString: (IncomeCategory category) =>
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
  }
}
