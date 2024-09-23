import 'package:expesne_tracker_app/constants/assets_paths.dart';

enum GoalCategory {
  emergencyFund,
  debtRepayment,
  retirementFund,
  educationFund,
  other
}

extension GoalCategoryExtension on GoalCategory {
  String get icon {
    switch (this) {
      case GoalCategory.emergencyFund:
        return AssetsPaths.salary;
      case GoalCategory.debtRepayment:
        return AssetsPaths.debtRepayment;
      case GoalCategory.retirementFund:
        return AssetsPaths.investment;
      case GoalCategory.educationFund:
        return AssetsPaths.savings;
      case GoalCategory.other:
        return AssetsPaths.shopping;
    }
  }
}

String getIconForCategory(GoalCategory category) {
  return category.icon;
}
