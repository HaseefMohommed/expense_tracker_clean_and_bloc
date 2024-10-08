import 'package:expesne_tracker_app/constants/assets_paths.dart';

enum IncomeCategory { salary, investments, sideHustles, giftsAndGrants, other }

extension IncomeCategoryExtension on IncomeCategory {
  String get icon {
    switch (this) {
      case IncomeCategory.salary:
        return AssetsPaths.salary;
      case IncomeCategory.investments:
        return AssetsPaths.investment;
      case IncomeCategory.sideHustles:
        return AssetsPaths.savings;
      case IncomeCategory.giftsAndGrants:
        return AssetsPaths.debtRepayment;
      case IncomeCategory.other:
        return AssetsPaths.shopping;
    }
  }

  String get displayName {
    switch (this) {
      case IncomeCategory.salary:
        return 'Salary';
      case IncomeCategory.investments:
        return 'Investments';
      case IncomeCategory.sideHustles:
        return 'Side Hustles';
      case IncomeCategory.giftsAndGrants:
        return 'Gifts & Grants';
      case IncomeCategory.other:
        return 'Other';
    }
  }
}

String getIconForIncomeCategory(IncomeCategory category) {
  return category.icon;
}

String getDisplayNameForIncomeCategory(IncomeCategory category) {
  return category.displayName;
}
