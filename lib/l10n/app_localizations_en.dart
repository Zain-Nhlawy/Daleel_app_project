// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get signUp => 'Sign Up';

  @override
  String get dontHaveAnAccount => 'Don\'t have an account?';

  @override
  String get password => 'Password';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get welcomeBack => 'ًWelcom Back!';

  @override
  String get pleaseFillAllFields => 'Please fill all fields.';

  @override
  String get loginFailedCheckYourCredentials =>
      'Login failed. Check your credentials.';
}
