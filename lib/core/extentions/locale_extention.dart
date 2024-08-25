import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/core/exceptions/exceptions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationGetter on BuildContext {
  AppLocalizations get locale {
    final AppLocalizations? locale = AppLocalizations.of(this);
    if (locale == null) throw LocalException('AppLocalizations not found');
    return locale;
  }
}
