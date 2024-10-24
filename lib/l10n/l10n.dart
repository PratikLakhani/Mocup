import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Application localization extension
extension AppLocalizationsX on BuildContext {
  /// getter for AppLocalizations
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
