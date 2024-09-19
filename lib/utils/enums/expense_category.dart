import 'package:expesne_tracker_app/constants/assets_paths.dart';

enum ExpenseCategory {
  housing,
  foodAndDining,
  transportation,
  entertainmentAndLeisure,
  other
}

extension ExpenseCategoryExtension on ExpenseCategory {
  String get icon {
    switch (this) {
      case ExpenseCategory.housing:
        return AssetsPaths.salary;
      case ExpenseCategory.foodAndDining:
        return AssetsPaths.educationFund;
      case ExpenseCategory.transportation:
        return AssetsPaths.salary;
      case ExpenseCategory.entertainmentAndLeisure:
        return AssetsPaths.educationFund;
      case ExpenseCategory.other:
        return AssetsPaths.emergencyFund;
    }
  }
}

String getIconForExpenseCategory(ExpenseCategory category) {
  return category.icon;
}
