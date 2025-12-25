import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @pleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields.'**
  String get pleaseFillAllFields;

  /// No description provided for @loginFailedCheckYourCredentials.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Check your credentials.'**
  String get loginFailedCheckYourCredentials;

  /// No description provided for @cannotSelectPastDates.
  ///
  /// In en, this message translates to:
  /// **'Cannot select past dates'**
  String get cannotSelectPastDates;

  /// No description provided for @userDataNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'User data not available'**
  String get userDataNotAvailable;

  /// No description provided for @yourAccountIsNotAllowedToMakeBookings.
  ///
  /// In en, this message translates to:
  /// **'Your account is not allowed to make bookings'**
  String get yourAccountIsNotAllowedToMakeBookings;

  /// No description provided for @pleaseSelectStartAndEndDates.
  ///
  /// In en, this message translates to:
  /// **'Please select start and end dates'**
  String get pleaseSelectStartAndEndDates;

  /// No description provided for @bookingSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Booking successful'**
  String get bookingSuccessful;

  /// No description provided for @bookingPeriodUnavailable.
  ///
  /// In en, this message translates to:
  /// **'bookingFailedThisApartmentIsAlreadyRentedForTheSelectedPeriod'**
  String get bookingPeriodUnavailable;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get end;

  /// No description provided for @bookingDetails.
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get bookingDetails;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @availableTimes.
  ///
  /// In en, this message translates to:
  /// **'Available Times'**
  String get availableTimes;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirmBooking;

  /// No description provided for @missingFields.
  ///
  /// In en, this message translates to:
  /// **'Missing fields'**
  String get missingFields;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @pleaseSelectProfileAndIDImages.
  ///
  /// In en, this message translates to:
  /// **'Please select profile and ID images'**
  String get pleaseSelectProfileAndIDImages;

  /// No description provided for @pleaseSelectLocation.
  ///
  /// In en, this message translates to:
  /// **'Please select location'**
  String get pleaseSelectLocation;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration Failed'**
  String get registrationFailed;

  /// No description provided for @selectYourLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Your Location'**
  String get selectYourLocation;

  /// No description provided for @joinAndExplore.
  ///
  /// In en, this message translates to:
  /// **'Join and explore'**
  String get joinAndExplore;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @profileImage.
  ///
  /// In en, this message translates to:
  /// **'Profile Image'**
  String get profileImage;

  /// No description provided for @iDImage.
  ///
  /// In en, this message translates to:
  /// **'ID Image'**
  String get iDImage;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @intro.
  ///
  /// In en, this message translates to:
  /// **'Where comfort meets certainty in every rental choice.\nDaleel – helping you find home, hassle-free.'**
  String get intro;

  /// No description provided for @profileDetails.
  ///
  /// In en, this message translates to:
  /// **'Profile Details'**
  String get profileDetails;

  /// No description provided for @myHouses.
  ///
  /// In en, this message translates to:
  /// **'My Houses'**
  String get myHouses;

  /// No description provided for @contractsHistory.
  ///
  /// In en, this message translates to:
  /// **'Contracts History'**
  String get contractsHistory;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @renter.
  ///
  /// In en, this message translates to:
  /// **'Renter'**
  String get renter;

  /// No description provided for @tenant.
  ///
  /// In en, this message translates to:
  /// **'Tenant'**
  String get tenant;

  /// No description provided for @timeRemaining.
  ///
  /// In en, this message translates to:
  /// **'Time Remaining'**
  String get timeRemaining;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No Description'**
  String get noDescription;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @unknownCity.
  ///
  /// In en, this message translates to:
  /// **'Unknown City'**
  String get unknownCity;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @noCommentsYet.
  ///
  /// In en, this message translates to:
  /// **'No Comments Yet'**
  String get noCommentsYet;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get showMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get showLess;

  /// No description provided for @addAComment.
  ///
  /// In en, this message translates to:
  /// **'Add a comment'**
  String get addAComment;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @updateBooking.
  ///
  /// In en, this message translates to:
  /// **'Update Booking'**
  String get updateBooking;

  /// No description provided for @contractDetails.
  ///
  /// In en, this message translates to:
  /// **'Contract Details'**
  String get contractDetails;

  /// No description provided for @rentFee.
  ///
  /// In en, this message translates to:
  /// **'Rent Fee'**
  String get rentFee;

  /// No description provided for @contractPeriod.
  ///
  /// In en, this message translates to:
  /// **'Contract Period'**
  String get contractPeriod;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @partiesInvolved.
  ///
  /// In en, this message translates to:
  /// **'Parties Involved'**
  String get partiesInvolved;

  /// No description provided for @viewApartmentDetails.
  ///
  /// In en, this message translates to:
  /// **'View Apartment Details'**
  String get viewApartmentDetails;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get number;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @publishedBy.
  ///
  /// In en, this message translates to:
  /// **'Published By'**
  String get publishedBy;

  /// No description provided for @pleaseFillAllRequiredFieldsSelectALocationAndAddAHeadImage.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields, select a location, and add a head image.'**
  String get pleaseFillAllRequiredFieldsSelectALocationAndAddAHeadImage;

  /// No description provided for @failedToAddApartmentPleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Failed to add apartment. Please try again.'**
  String get failedToAddApartmentPleaseTryAgain;

  /// No description provided for @yourApartmentWasAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your apartment was added successfully!'**
  String get yourApartmentWasAddedSuccessfully;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @okay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get okay;

  /// No description provided for @addApartment.
  ///
  /// In en, this message translates to:
  /// **'Add Apartment'**
  String get addApartment;

  /// No description provided for @mainImage.
  ///
  /// In en, this message translates to:
  /// **'Main Image'**
  String get mainImage;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @features.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get features;

  /// No description provided for @morePictures.
  ///
  /// In en, this message translates to:
  /// **'More Pictures'**
  String get morePictures;

  /// No description provided for @tellUsMoreAboutYourPlace.
  ///
  /// In en, this message translates to:
  /// **'Tell us more about your place'**
  String get tellUsMoreAboutYourPlace;

  /// No description provided for @tapToAddMainImage.
  ///
  /// In en, this message translates to:
  /// **'Tap to add main image'**
  String get tapToAddMainImage;

  /// No description provided for @thisFieldCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'This field cannot be empty'**
  String get thisFieldCannotBeEmpty;

  /// No description provided for @bathrooms.
  ///
  /// In en, this message translates to:
  /// **'Bathrooms'**
  String get bathrooms;

  /// No description provided for @bedrooms.
  ///
  /// In en, this message translates to:
  /// **'Bedrooms'**
  String get bedrooms;

  /// No description provided for @floor.
  ///
  /// In en, this message translates to:
  /// **'Floor'**
  String get floor;

  /// No description provided for @areaM2.
  ///
  /// In en, this message translates to:
  /// **'Area (m²)'**
  String get areaM2;

  /// No description provided for @selectApartmentLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Apartment Location'**
  String get selectApartmentLocation;

  /// No description provided for @availableForRent.
  ///
  /// In en, this message translates to:
  /// **'Available for Rent'**
  String get availableForRent;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @titleegModernVilla.
  ///
  /// In en, this message translates to:
  /// **'Title (e.g., Modern Villa)'**
  String get titleegModernVilla;

  /// No description provided for @myContracts.
  ///
  /// In en, this message translates to:
  /// **'My Contracts'**
  String get myContracts;

  /// No description provided for @noContractsFound.
  ///
  /// In en, this message translates to:
  /// **'No contracts found'**
  String get noContractsFound;

  /// No description provided for @noApartmentsFound.
  ///
  /// In en, this message translates to:
  /// **'No apartments found'**
  String get noApartmentsFound;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @searchHere.
  ///
  /// In en, this message translates to:
  /// **'Search Here'**
  String get searchHere;

  /// No description provided for @mostPopular.
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get mostPopular;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @closeToYou.
  ///
  /// In en, this message translates to:
  /// **'Close To You'**
  String get closeToYou;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @requestSubmittedYourApartmentIsNowPendingAdminApproval.
  ///
  /// In en, this message translates to:
  /// **'Request Submitted!\nYour apartment is now pending admin approval.'**
  String get requestSubmittedYourApartmentIsNowPendingAdminApproval;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @updateRequestSentWaitingForApproval.
  ///
  /// In en, this message translates to:
  /// **'Your update request has been sent and is waiting for the owner\'s approval'**
  String get updateRequestSentWaitingForApproval;

  /// No description provided for @contractUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Contract updated successfully'**
  String get contractUpdatedSuccessfully;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirmCancelContract.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel the contract?'**
  String get confirmCancelContract;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @contractCancelled.
  ///
  /// In en, this message translates to:
  /// **'Contract has been cancelled'**
  String get contractCancelled;

  /// No description provided for @sayHi.
  ///
  /// In en, this message translates to:
  /// **'Say hi!'**
  String get sayHi;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'...'**
  String get points;

  /// No description provided for @myChats.
  ///
  /// In en, this message translates to:
  /// **'My Chats'**
  String get myChats;

  /// No description provided for @noChatsYetExplorePropertiesToContactOwners.
  ///
  /// In en, this message translates to:
  /// **'No chats yet.\nExplore properties to contact owners!'**
  String get noChatsYetExplorePropertiesToContactOwners;

  /// No description provided for @typeAMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message'**
  String get typeAMessage;

  /// No description provided for @contractApprovedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'The contract has been approved successfully'**
  String get contractApprovedSuccessfully;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @confirmRejectContract.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reject this contract?'**
  String get confirmRejectContract;

  /// No description provided for @contractRejectedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Contract has been rejected successfully'**
  String get contractRejectedSuccessfully;

  /// No description provided for @favouriteRemoved.
  ///
  /// In en, this message translates to:
  /// **'favourite removed'**
  String get favouriteRemoved;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @noApartmentsNearYou.
  ///
  /// In en, this message translates to:
  /// **'no apartments near you'**
  String get noApartmentsNearYou;

  /// No description provided for @filteredResults.
  ///
  /// In en, this message translates to:
  /// **'Filtered Results'**
  String get filteredResults;

  /// No description provided for @contractHistory.
  ///
  /// In en, this message translates to:
  /// **'Contract History'**
  String get contractHistory;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @personImage.
  ///
  /// In en, this message translates to:
  /// **'Personal Image'**
  String get personImage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
