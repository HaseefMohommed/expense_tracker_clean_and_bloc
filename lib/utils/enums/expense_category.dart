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
        return AssetsPaths.housing;
      case ExpenseCategory.foodAndDining:
        return AssetsPaths.food;
      case ExpenseCategory.transportation:
        return AssetsPaths.transportation;
      case ExpenseCategory.entertainmentAndLeisure:
        return AssetsPaths.entertainment;
      case ExpenseCategory.other:
        return AssetsPaths.shopping;
    }
  }
}

String getIconForExpenseCategory(ExpenseCategory category) {
  return category.icon;
}
