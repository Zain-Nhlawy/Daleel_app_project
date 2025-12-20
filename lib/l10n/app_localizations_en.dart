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

  @override
  String get cannotSclectPastDates => 'Cannot select past dates';

  @override
  String get userDataNotAvailable => 'User data not available';

  @override
  String get yourAccountIsNotAllowedToMakeBookings =>
      'Your account is not allowed to make bookings';

  @override
  String get pleaseSelectStartAndEndDates =>
      'Please select start and end dates';

  @override
  String get bookingSuccessful => 'Booking successful';

  @override
  String get bookingFailedThisApartmentIsAlreadyRentedForTheSelectedPeriod =>
      'bookingFailedThisApartmentIsAlreadyRentedForTheSelectedPeriod';

  @override
  String get start => 'Start';

  @override
  String get end => 'End';

  @override
  String get bookingDetails => 'Booking Details';

  @override
  String get selectDate => 'Select Date';

  @override
  String get availableTimes => 'Available Times';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get processing => 'Processing...';

  @override
  String get confirmBooking => 'Confirm Booking';
}
