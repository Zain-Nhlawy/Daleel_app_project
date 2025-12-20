// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signUp => 'اشتراك';

  @override
  String get dontHaveAnAccount => 'ليس لديك حساب؟';

  @override
  String get password => 'كلمة السر';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get welcomeBack => 'ًمرحبا مجدداً!';

  @override
  String get pleaseFillAllFields => 'الرجاء ملأ كل الحقول';

  @override
  String get loginFailedCheckYourCredentials =>
      'فشل تسجيل الدخول. تأكد من معلوماتك';
}
