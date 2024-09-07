import 'package:expesne_tracker_app/constants/assets_provider.dart';
import 'package:expesne_tracker_app/features/common/pages/root_background.dart';
import 'package:expesne_tracker_app/resources/ui_components/app_drop_down/app_drop_down.dart';
import 'package:expesne_tracker_app/resources/ui_components/date_picker/date_picker_dialog_box.dart';
import 'package:expesne_tracker_app/resources/ui_components/text_field/app_text_field.dart';
import 'package:flutter/material.dart';

class AddGoalPage extends StatefulWidget {
  static String routeName = '/addGoalPage';
  const AddGoalPage({super.key});

  @override
  State<AddGoalPage> createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  final _goalTitleController = TextEditingController();
  final _goalAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RootBackground(
      title: 'Add Goal',
      onPressed: () {},
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
          controller: _goalAmount,
          suffixIconVisible: AssetsProvider.dollerSign,
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
          onSelect: (option) {},
        ),
        const SizedBox(height: 16),
        const DatePickerDialogBox(
          title: 'Deadline',
        ),
      ],
    );
  }
}
