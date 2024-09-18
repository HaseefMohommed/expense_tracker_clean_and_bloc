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
        return AssetsPaths.emergencyFund;
      case GoalCategory.debtRepayment:
        return AssetsPaths.debtRepayment;
      case GoalCategory.retirementFund:
        return AssetsPaths.emergencyFund;
      case GoalCategory.educationFund:
        return AssetsPaths.educationFund;
      case GoalCategory.other:
        return AssetsPaths.food;
    }
  }
}

String getIconForCategory(GoalCategory category) {
  return category.icon;
}
