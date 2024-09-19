import 'package:expesne_tracker_app/constants/assets_paths.dart';

enum IncomeCategory {
  salary,
  investments,
  sideHustles,
  giftsAndGrants,
  other
}

extension IncomeCategoryExtension on IncomeCategory {
  String get icon {
    switch (this) {
      case IncomeCategory.salary:
        return AssetsPaths.salary;
      case IncomeCategory.investments:
        return AssetsPaths.educationFund;
      case IncomeCategory.sideHustles:
        return AssetsPaths.emergencyFund;
      case IncomeCategory.giftsAndGrants:
        return AssetsPaths.salary;
      case IncomeCategory.other:
        return AssetsPaths.salary;
    }
  }
}

String getIconForIncomeCategory(IncomeCategory category) {
  return category.icon;
}
