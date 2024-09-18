import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/resources/ui_components/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';

extension FailureExtention on Failure? {
  void showError(BuildContext context, AppStatus appStatus) {
    if (this != null && appStatus == AppStatus.failure) {
      AppSnackbar.showError(
        context,
        message: this!.getMessage(),
        showTrailerIcon: false,
      );
    }
  }
}
