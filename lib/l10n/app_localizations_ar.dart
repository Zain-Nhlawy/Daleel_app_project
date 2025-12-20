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
  String get signUp => 'إنشاء حساب';

  @override
  String get dontHaveAnAccount => 'ليس لديك حساب؟';

  @override
  String get password => 'كلمة المرور';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get welcomeBack => 'مرحبًا بعودتك!';

  @override
  String get pleaseFillAllFields => 'يرجى تعبئة جميع الحقول.';

  @override
  String get loginFailedCheckYourCredentials =>
      'فشل تسجيل الدخول. تحقق من بياناتك.';

  @override
  String get cannotSclectPastDates => 'لا يمكن اختيار تواريخ سابقة';

  @override
  String get userDataNotAvailable => 'بيانات المستخدم غير متوفرة';

  @override
  String get yourAccountIsNotAllowedToMakeBookings =>
      'حسابك غير مسموح له بإجراء حجوزات';

  @override
  String get pleaseSelectStartAndEndDates =>
      'يرجى اختيار تاريخي البداية والنهاية';

  @override
  String get bookingSuccessful => 'تم الحجز بنجاح';

  @override
  String get bookingFailedThisApartmentIsAlreadyRentedForTheSelectedPeriod =>
      'فشل الحجز. هذه الشقة محجوزة بالفعل خلال الفترة المحددة';

  @override
  String get start => 'بدء';

  @override
  String get end => 'نهاية';

  @override
  String get bookingDetails => 'تفاصيل الحجز';

  @override
  String get selectDate => 'اختر التاريخ';

  @override
  String get availableTimes => 'الأوقات المتاحة';

  @override
  String get from => 'من';

  @override
  String get to => 'إلى';

  @override
  String get processing => 'جارٍ المعالجة...';

  @override
  String get confirmBooking => 'تأكيد الحجز';
}
