import 'package:flutter/material.dart';
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

  Color get color {
    switch (this) {
      case ExpenseCategory.housing:
        return Colors.blue;
      case ExpenseCategory.foodAndDining:
        return Colors.green;
      case ExpenseCategory.transportation:
        return Colors.orange;
      case ExpenseCategory.entertainmentAndLeisure:
        return Colors.purple;
      case ExpenseCategory.other:
        return Colors.red;
    }
  }

  String get displayName {
    switch (this) {
      case ExpenseCategory.housing:
        return 'Housing';
      case ExpenseCategory.foodAndDining:
        return 'Food & Dining';
      case ExpenseCategory.transportation:
        return 'Transportation';
      case ExpenseCategory.entertainmentAndLeisure:
        return 'Entertainment & Leisure';
      case ExpenseCategory.other:
        return 'Other';
    }
  }
}

String getIconForExpenseCategory(ExpenseCategory category) {
  return category.icon;
}

Color getColorForExpenseCategory(ExpenseCategory category) {
  return category.color;
}

String getDisplayNameForExpenseCategory(ExpenseCategory category) {
  return category.displayName;
}
