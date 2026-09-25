import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_km.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
    Locale('en'),
    Locale('km')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'N1 TRANSPORTATION'**
  String get appTitle;

  /// No description provided for @roleDriver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get roleDriver;

  /// No description provided for @roleTripAdviser.
  ///
  /// In en, this message translates to:
  /// **'Trip Adviser'**
  String get roleTripAdviser;

  /// No description provided for @roleFuelStockManager.
  ///
  /// In en, this message translates to:
  /// **'Fuel Stock Manager'**
  String get roleFuelStockManager;

  /// No description provided for @roleCeo.
  ///
  /// In en, this message translates to:
  /// **'CEO / Owner'**
  String get roleCeo;

  /// No description provided for @roleDriverShort.
  ///
  /// In en, this message translates to:
  /// **'Driver operations'**
  String get roleDriverShort;

  /// No description provided for @roleTripAdviserShort.
  ///
  /// In en, this message translates to:
  /// **'Trip planning'**
  String get roleTripAdviserShort;

  /// No description provided for @roleFuelStockManagerShort.
  ///
  /// In en, this message translates to:
  /// **'Fuel operations'**
  String get roleFuelStockManagerShort;

  /// No description provided for @roleCeoShort.
  ///
  /// In en, this message translates to:
  /// **'Business overview'**
  String get roleCeoShort;

  /// No description provided for @roleDriverDesc.
  ///
  /// In en, this message translates to:
  /// **'View assigned trips, update delivery status, and request fuel.'**
  String get roleDriverDesc;

  /// No description provided for @roleTripAdviserDesc.
  ///
  /// In en, this message translates to:
  /// **'Plan trips, assign vehicles and drivers, then monitor progress.'**
  String get roleTripAdviserDesc;

  /// No description provided for @roleFuelStockManagerDesc.
  ///
  /// In en, this message translates to:
  /// **'Approve fuel requests and keep vehicle fuel stock accurate.'**
  String get roleFuelStockManagerDesc;

  /// No description provided for @roleCeoDesc.
  ///
  /// In en, this message translates to:
  /// **'Monitor logistics performance, delivery, fuel, and operating costs.'**
  String get roleCeoDesc;

  /// No description provided for @roleDriverSignIn.
  ///
  /// In en, this message translates to:
  /// **'Driver ID'**
  String get roleDriverSignIn;

  /// No description provided for @roleTripAdviserSignIn.
  ///
  /// In en, this message translates to:
  /// **'Work email'**
  String get roleTripAdviserSignIn;

  /// No description provided for @roleFuelStockManagerSignIn.
  ///
  /// In en, this message translates to:
  /// **'Employee ID'**
  String get roleFuelStockManagerSignIn;

  /// No description provided for @roleCeoSignIn.
  ///
  /// In en, this message translates to:
  /// **'Work email'**
  String get roleCeoSignIn;

  /// No description provided for @loginTagline.
  ///
  /// In en, this message translates to:
  /// **'Safe Transport · Build Tomorrow'**
  String get loginTagline;

  /// No description provided for @welcomeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Logistics that\nmove with confidence.'**
  String get welcomeHeadline;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'One operational workspace for your fleet, fuel, trips, and delivery performance.'**
  String get welcomeSubtitle;

  /// No description provided for @openApp.
  ///
  /// In en, this message translates to:
  /// **'Open N1 TRANSPORTATION'**
  String get openApp;

  /// No description provided for @operationsMadeSimple.
  ///
  /// In en, this message translates to:
  /// **'Operations made simple'**
  String get operationsMadeSimple;

  /// No description provided for @selectRoleTitle.
  ///
  /// In en, this message translates to:
  /// **'Select your role'**
  String get selectRoleTitle;

  /// No description provided for @selectRoleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your workspace is tailored to the work you do.'**
  String get selectRoleSubtitle;

  /// No description provided for @selectRoleFooter.
  ///
  /// In en, this message translates to:
  /// **'You can switch roles from the dashboard later.'**
  String get selectRoleFooter;

  /// No description provided for @continueAsRole.
  ///
  /// In en, this message translates to:
  /// **'Continue as {role}'**
  String continueAsRole(Object role);

  /// No description provided for @onboardingWorkspaceEyebrow.
  ///
  /// In en, this message translates to:
  /// **'YOUR WORKSPACE'**
  String get onboardingWorkspaceEyebrow;

  /// No description provided for @onboardingBuiltFor.
  ///
  /// In en, this message translates to:
  /// **'Built for {role}.'**
  String onboardingBuiltFor(Object role);

  /// No description provided for @onboardingFlowEyebrow.
  ///
  /// In en, this message translates to:
  /// **'ONE CLEAR FLOW'**
  String get onboardingFlowEyebrow;

  /// No description provided for @onboardingReadyEyebrow.
  ///
  /// In en, this message translates to:
  /// **'READY WHEN YOU ARE'**
  String get onboardingReadyEyebrow;

  /// No description provided for @onboardingReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay in control, anywhere.'**
  String get onboardingReadyTitle;

  /// No description provided for @onboardingReadyBody.
  ///
  /// In en, this message translates to:
  /// **'Important updates, clear next steps, and practical information are always within reach.'**
  String get onboardingReadyBody;

  /// No description provided for @onboardingAutoAdvance.
  ///
  /// In en, this message translates to:
  /// **'Your workspace will open automatically'**
  String get onboardingAutoAdvance;

  /// No description provided for @flowTitleDriver.
  ///
  /// In en, this message translates to:
  /// **'From assigned trip to proof of delivery.'**
  String get flowTitleDriver;

  /// No description provided for @flowTitleTripAdviser.
  ///
  /// In en, this message translates to:
  /// **'Create, assign, and monitor every trip.'**
  String get flowTitleTripAdviser;

  /// No description provided for @flowTitleFuelStockManager.
  ///
  /// In en, this message translates to:
  /// **'Approve fuel with live stock visibility.'**
  String get flowTitleFuelStockManager;

  /// No description provided for @flowTitleCeo.
  ///
  /// In en, this message translates to:
  /// **'See the business, not just the numbers.'**
  String get flowTitleCeo;

  /// No description provided for @flowBodyDriver.
  ///
  /// In en, this message translates to:
  /// **'See the next action immediately: start, navigate, load, deliver, and complete.'**
  String get flowBodyDriver;

  /// No description provided for @flowBodyTripAdviser.
  ///
  /// In en, this message translates to:
  /// **'Set the vehicle, driver, pickup, delivery, material, and quantity in one clear workflow.'**
  String get flowBodyTripAdviser;

  /// No description provided for @flowBodyFuelStockManager.
  ///
  /// In en, this message translates to:
  /// **'Receive a request, approve or reject it, then record the fuel issued.'**
  String get flowBodyFuelStockManager;

  /// No description provided for @flowBodyCeo.
  ///
  /// In en, this message translates to:
  /// **'Review delivery, active fleet, fuel usage, cost, and driver performance from one dashboard.'**
  String get flowBodyCeo;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @signInToWorkspace.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your {role} workspace.'**
  String signInToWorkspace(Object role);

  /// No description provided for @signingInAs.
  ///
  /// In en, this message translates to:
  /// **'Signing in as {role}'**
  String signingInAs(Object role);

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @enterYourField.
  ///
  /// In en, this message translates to:
  /// **'Enter your {field}'**
  String enterYourField(Object field);

  /// No description provided for @enterValidPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid password'**
  String get enterValidPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'Please contact N1 TRANSPORTATION support to reset your password.'**
  String get forgotPasswordMessage;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @demoAccessNote.
  ///
  /// In en, this message translates to:
  /// **'Demo access · No account creation required'**
  String get demoAccessNote;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navTrips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get navTrips;

  /// No description provided for @navFuel.
  ///
  /// In en, this message translates to:
  /// **'Fuel'**
  String get navFuel;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get navNotifications;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Welcome,'**
  String get goodMorning;

  /// No description provided for @onDuty.
  ///
  /// In en, this message translates to:
  /// **'On duty'**
  String get onDuty;

  /// No description provided for @todaysTrip.
  ///
  /// In en, this message translates to:
  /// **'Today\'s assigned trip'**
  String get todaysTrip;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get quickActions;

  /// No description provided for @requestFuel.
  ///
  /// In en, this message translates to:
  /// **'Request fuel'**
  String get requestFuel;

  /// No description provided for @tripHistory.
  ///
  /// In en, this message translates to:
  /// **'Trip history'**
  String get tripHistory;

  /// No description provided for @myVehicle.
  ///
  /// In en, this message translates to:
  /// **'My vehicle'**
  String get myVehicle;

  /// No description provided for @todayAtGlance.
  ///
  /// In en, this message translates to:
  /// **'Today at a glance'**
  String get todayAtGlance;

  /// No description provided for @todaysTrips.
  ///
  /// In en, this message translates to:
  /// **'Today\'s trips'**
  String get todaysTrips;

  /// No description provided for @activeTrips.
  ///
  /// In en, this message translates to:
  /// **'Active trips'**
  String get activeTrips;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @startTrip.
  ///
  /// In en, this message translates to:
  /// **'Start trip'**
  String get startTrip;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notifNewTripTitle.
  ///
  /// In en, this message translates to:
  /// **'New trip assigned'**
  String get notifNewTripTitle;

  /// No description provided for @notifNewTripSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Trip {id} starts at {time}'**
  String notifNewTripSubtitle(Object id, Object time);

  /// No description provided for @notifNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get notifNow;

  /// No description provided for @notifFuelApprovedTitle.
  ///
  /// In en, this message translates to:
  /// **'Fuel request approved'**
  String get notifFuelApprovedTitle;

  /// No description provided for @notifFuelApprovedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{liters} for {plate}'**
  String notifFuelApprovedSubtitle(Object liters, Object plate);

  /// No description provided for @notif2h.
  ///
  /// In en, this message translates to:
  /// **'2h'**
  String get notif2h;

  /// No description provided for @completedTripsTitle.
  ///
  /// In en, this message translates to:
  /// **'Completed trips'**
  String get completedTripsTitle;

  /// No description provided for @assignedVehicle.
  ///
  /// In en, this message translates to:
  /// **'ASSIGNED VEHICLE'**
  String get assignedVehicle;

  /// No description provided for @cementTruck.
  ///
  /// In en, this message translates to:
  /// **'Cement Truck'**
  String get cementTruck;

  /// No description provided for @vehicleAssignment.
  ///
  /// In en, this message translates to:
  /// **'Vehicle assignment'**
  String get vehicleAssignment;

  /// No description provided for @driverLabel.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get driverLabel;

  /// No description provided for @driverIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Driver ID'**
  String get driverIdLabel;

  /// No description provided for @vehicleActivity.
  ///
  /// In en, this message translates to:
  /// **'Vehicle activity'**
  String get vehicleActivity;

  /// No description provided for @assignedTripLabel.
  ///
  /// In en, this message translates to:
  /// **'Assigned trip · {id}'**
  String assignedTripLabel(Object id);

  /// No description provided for @fuelRequestsLabel.
  ///
  /// In en, this message translates to:
  /// **'Fuel requests'**
  String get fuelRequestsLabel;

  /// No description provided for @viewRequestsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View requests and fuel activity'**
  String get viewRequestsSubtitle;

  /// No description provided for @currentFuelLevel.
  ///
  /// In en, this message translates to:
  /// **'Current fuel level'**
  String get currentFuelLevel;

  /// No description provided for @latestRequest.
  ///
  /// In en, this message translates to:
  /// **'Latest request'**
  String get latestRequest;

  /// No description provided for @requestHistory.
  ///
  /// In en, this message translates to:
  /// **'Request history'**
  String get requestHistory;

  /// No description provided for @statusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get statusApproved;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get statusRejected;

  /// No description provided for @requestedAmount.
  ///
  /// In en, this message translates to:
  /// **'Requested amount'**
  String get requestedAmount;

  /// No description provided for @liters.
  ///
  /// In en, this message translates to:
  /// **'Liters'**
  String get liters;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @reasonCurrentTrip.
  ///
  /// In en, this message translates to:
  /// **'Current Trip'**
  String get reasonCurrentTrip;

  /// No description provided for @reasonNextTrip.
  ///
  /// In en, this message translates to:
  /// **'Next Trip'**
  String get reasonNextTrip;

  /// No description provided for @reasonLowFuel.
  ///
  /// In en, this message translates to:
  /// **'Low Fuel'**
  String get reasonLowFuel;

  /// No description provided for @reasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get reasonOther;

  /// No description provided for @optionalNote.
  ///
  /// In en, this message translates to:
  /// **'Optional note'**
  String get optionalNote;

  /// No description provided for @submitRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit request'**
  String get submitRequest;

  /// No description provided for @requestSubmittedTitle.
  ///
  /// In en, this message translates to:
  /// **'Request submitted'**
  String get requestSubmittedTitle;

  /// No description provided for @requestSubmittedBody.
  ///
  /// In en, this message translates to:
  /// **'Your fuel request has been sent to the Fuel Stock Manager.'**
  String get requestSubmittedBody;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @currentFuel.
  ///
  /// In en, this message translates to:
  /// **'Current fuel'**
  String get currentFuel;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your account and preferences'**
  String get profileSubtitle;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get personalInfo;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @activeDriver.
  ///
  /// In en, this message translates to:
  /// **'Active Driver'**
  String get activeDriver;

  /// No description provided for @activeAccount.
  ///
  /// In en, this message translates to:
  /// **'Active account'**
  String get activeAccount;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @licenseNumber.
  ///
  /// In en, this message translates to:
  /// **'License number'**
  String get licenseNumber;

  /// No description provided for @assignedVehicleLabel.
  ///
  /// In en, this message translates to:
  /// **'Assigned vehicle'**
  String get assignedVehicleLabel;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @personalInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your personal details'**
  String get personalInfoSubtitle;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @changePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep your account secure'**
  String get changePasswordSubtitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language'**
  String get languageSubtitle;

  /// No description provided for @toggleTheme.
  ///
  /// In en, this message translates to:
  /// **'Toggle theme'**
  String get toggleTheme;

  /// No description provided for @toggleThemeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Switch between light and dark mode'**
  String get toggleThemeSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhoneNumber;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enterValidEmail;

  /// No description provided for @personalInfoSavedMsg.
  ///
  /// In en, this message translates to:
  /// **'Personal information updated.'**
  String get personalInfoSavedMsg;

  /// No description provided for @currentPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPasswordLabel;

  /// No description provided for @enterCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password'**
  String get enterCurrentPassword;

  /// No description provided for @newPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPasswordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirmPasswordLabel;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @updatePasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Update password'**
  String get updatePasswordButton;

  /// No description provided for @passwordUpdatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Password updated'**
  String get passwordUpdatedTitle;

  /// No description provided for @passwordUpdatedBody.
  ///
  /// In en, this message translates to:
  /// **'Your password has been changed successfully.'**
  String get passwordUpdatedBody;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @logOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get logOutTitle;

  /// No description provided for @logOutBody.
  ///
  /// In en, this message translates to:
  /// **'You will need to sign in again to access your workspace.'**
  String get logOutBody;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageKhmer.
  ///
  /// In en, this message translates to:
  /// **'Khmer'**
  String get languageKhmer;

  /// No description provided for @notifNoneTitle.
  ///
  /// In en, this message translates to:
  /// **'No new notifications'**
  String get notifNoneTitle;

  /// No description provided for @createTrip.
  ///
  /// In en, this message translates to:
  /// **'Create trip'**
  String get createTrip;

  /// No description provided for @todaysTripControl.
  ///
  /// In en, this message translates to:
  /// **'Today\'s trip control'**
  String get todaysTripControl;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @inTransit.
  ///
  /// In en, this message translates to:
  /// **'In transit'**
  String get inTransit;

  /// No description provided for @needAction.
  ///
  /// In en, this message translates to:
  /// **'Need action'**
  String get needAction;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @showingLatestTrips.
  ///
  /// In en, this message translates to:
  /// **'Showing the latest active trips.'**
  String get showingLatestTrips;

  /// No description provided for @tripTools.
  ///
  /// In en, this message translates to:
  /// **'Trip tools'**
  String get tripTools;

  /// No description provided for @trackFleet.
  ///
  /// In en, this message translates to:
  /// **'Track fleet'**
  String get trackFleet;

  /// No description provided for @tripReports.
  ///
  /// In en, this message translates to:
  /// **'Trip reports'**
  String get tripReports;

  /// No description provided for @fleetOverview.
  ///
  /// In en, this message translates to:
  /// **'Fleet overview'**
  String get fleetOverview;

  /// No description provided for @moving.
  ///
  /// In en, this message translates to:
  /// **'Moving'**
  String get moving;

  /// No description provided for @idle.
  ///
  /// In en, this message translates to:
  /// **'Idle'**
  String get idle;

  /// No description provided for @parked.
  ///
  /// In en, this message translates to:
  /// **'Parked'**
  String get parked;

  /// No description provided for @fleetVehicles.
  ///
  /// In en, this message translates to:
  /// **'Fleet vehicles'**
  String get fleetVehicles;

  /// No description provided for @reportsOverview.
  ///
  /// In en, this message translates to:
  /// **'Reports overview'**
  String get reportsOverview;

  /// No description provided for @avgDeliveryTime.
  ///
  /// In en, this message translates to:
  /// **'Avg. delivery time'**
  String get avgDeliveryTime;

  /// No description provided for @recentReports.
  ///
  /// In en, this message translates to:
  /// **'Recent reports'**
  String get recentReports;

  /// No description provided for @filterDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get filterDay;

  /// No description provided for @filterMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get filterMonth;

  /// No description provided for @filterYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get filterYear;

  /// No description provided for @monthJan.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get monthJan;

  /// No description provided for @monthFeb.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get monthFeb;

  /// No description provided for @monthMar.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get monthMar;

  /// No description provided for @monthApr.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get monthApr;

  /// No description provided for @monthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get monthMay;

  /// No description provided for @monthJun.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get monthJun;

  /// No description provided for @monthJul.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get monthJul;

  /// No description provided for @monthAug.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get monthAug;

  /// No description provided for @monthSep.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get monthSep;

  /// No description provided for @monthOct.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get monthOct;

  /// No description provided for @monthNov.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get monthNov;

  /// No description provided for @monthDec.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get monthDec;

  /// No description provided for @planTheTrip.
  ///
  /// In en, this message translates to:
  /// **'Plan the trip'**
  String get planTheTrip;

  /// No description provided for @planTheTripSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Assign the vehicle and driver, then define the route and material.'**
  String get planTheTripSubtitle;

  /// No description provided for @vehicleAndDriver.
  ///
  /// In en, this message translates to:
  /// **'Vehicle & driver'**
  String get vehicleAndDriver;

  /// No description provided for @route.
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get route;

  /// No description provided for @pickupLocation.
  ///
  /// In en, this message translates to:
  /// **'Pickup location'**
  String get pickupLocation;

  /// No description provided for @deliveryLocation.
  ///
  /// In en, this message translates to:
  /// **'Delivery location'**
  String get deliveryLocation;

  /// No description provided for @material.
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get material;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @tons.
  ///
  /// In en, this message translates to:
  /// **'Tons'**
  String get tons;

  /// No description provided for @tripNoteOptional.
  ///
  /// In en, this message translates to:
  /// **'Trip note (optional)'**
  String get tripNoteOptional;

  /// No description provided for @saveTripChanges.
  ///
  /// In en, this message translates to:
  /// **'Save trip changes'**
  String get saveTripChanges;

  /// No description provided for @sendTripToDriver.
  ///
  /// In en, this message translates to:
  /// **'Send trip to driver'**
  String get sendTripToDriver;

  /// No description provided for @tripSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip sent to driver'**
  String get tripSentTitle;

  /// No description provided for @tripSentBody.
  ///
  /// In en, this message translates to:
  /// **'The driver can now see the assigned vehicle, route, material, and delivery instructions.'**
  String get tripSentBody;

  /// No description provided for @tripLabel.
  ///
  /// In en, this message translates to:
  /// **'Trip {id}'**
  String tripLabel(Object id);

  /// No description provided for @createATrip.
  ///
  /// In en, this message translates to:
  /// **'Create a trip'**
  String get createATrip;

  /// No description provided for @mainFuelStock.
  ///
  /// In en, this message translates to:
  /// **'MAIN FUEL STOCK'**
  String get mainFuelStock;

  /// No description provided for @availableReserve.
  ///
  /// In en, this message translates to:
  /// **'{percent}% available · Reserve threshold: {threshold}%'**
  String availableReserve(Object percent, Object threshold);

  /// No description provided for @fuelRequestsAwaiting.
  ///
  /// In en, this message translates to:
  /// **'Fuel requests awaiting action'**
  String get fuelRequestsAwaiting;

  /// No description provided for @todaysIssuingSummary.
  ///
  /// In en, this message translates to:
  /// **'Today\'s issuing summary'**
  String get todaysIssuingSummary;

  /// No description provided for @issuedToday.
  ///
  /// In en, this message translates to:
  /// **'Issued today'**
  String get issuedToday;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @recordFuelOut.
  ///
  /// In en, this message translates to:
  /// **'Record fuel out'**
  String get recordFuelOut;

  /// No description provided for @fuelIssueRecordedMsg.
  ///
  /// In en, this message translates to:
  /// **'Fuel issue recorded and stock updated.'**
  String get fuelIssueRecordedMsg;

  /// No description provided for @fuelApprovedMsg.
  ///
  /// In en, this message translates to:
  /// **'{liters} approved for {name}. Fuel stock will be updated on issue.'**
  String fuelApprovedMsg(Object liters, Object name);

  /// No description provided for @fuelRejectedMsg.
  ///
  /// In en, this message translates to:
  /// **'Fuel request rejected.'**
  String get fuelRejectedMsg;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @fuelReports.
  ///
  /// In en, this message translates to:
  /// **'Fuel reports'**
  String get fuelReports;

  /// No description provided for @totalIssued.
  ///
  /// In en, this message translates to:
  /// **'Total issued'**
  String get totalIssued;

  /// No description provided for @requestsApproved.
  ///
  /// In en, this message translates to:
  /// **'Requests approved'**
  String get requestsApproved;

  /// No description provided for @requestsRejected.
  ///
  /// In en, this message translates to:
  /// **'Requests rejected'**
  String get requestsRejected;

  /// No description provided for @recentFuelActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent fuel activity'**
  String get recentFuelActivity;

  /// No description provided for @helloGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello,'**
  String get helloGreeting;

  /// No description provided for @fuelTagline.
  ///
  /// In en, this message translates to:
  /// **'Stay fueled, keep moving'**
  String get fuelTagline;

  /// No description provided for @onTripStatus.
  ///
  /// In en, this message translates to:
  /// **'On Trip'**
  String get onTripStatus;

  /// No description provided for @fuelCapacity.
  ///
  /// In en, this message translates to:
  /// **'Fuel capacity'**
  String get fuelCapacity;

  /// No description provided for @remainingFuel.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remainingFuel;

  /// No description provided for @lowFuelWarning.
  ///
  /// In en, this message translates to:
  /// **'Fuel level is low. Please request refuel soon.'**
  String get lowFuelWarning;

  /// No description provided for @createNewRequest.
  ///
  /// In en, this message translates to:
  /// **'Create new request'**
  String get createNewRequest;

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationLabel;

  /// No description provided for @vehicleLabel.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get vehicleLabel;

  /// No description provided for @enterFuelAmountHint.
  ///
  /// In en, this message translates to:
  /// **'Enter fuel amount (e.g. 50 L)'**
  String get enterFuelAmountHint;

  /// No description provided for @selectLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Select location'**
  String get selectLocationHint;

  /// No description provided for @addNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Add a note (optional)'**
  String get addNoteHint;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @tryDifferentFilter.
  ///
  /// In en, this message translates to:
  /// **'Try a different filter.'**
  String get tryDifferentFilter;

  /// No description provided for @businessOverview.
  ///
  /// In en, this message translates to:
  /// **'Business overview'**
  String get businessOverview;

  /// No description provided for @activeVehicles.
  ///
  /// In en, this message translates to:
  /// **'Active vehicles'**
  String get activeVehicles;

  /// No description provided for @tripsThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Trips this month'**
  String get tripsThisMonth;

  /// No description provided for @onTimeRate.
  ///
  /// In en, this message translates to:
  /// **'On-time rate'**
  String get onTimeRate;

  /// No description provided for @deliveryPerformance.
  ///
  /// In en, this message translates to:
  /// **'Delivery performance'**
  String get deliveryPerformance;

  /// No description provided for @managementDashboard.
  ///
  /// In en, this message translates to:
  /// **'Management dashboard'**
  String get managementDashboard;

  /// No description provided for @onTimeCompletion.
  ///
  /// In en, this message translates to:
  /// **'On-time completion'**
  String get onTimeCompletion;

  /// No description provided for @thisWeekTarget.
  ///
  /// In en, this message translates to:
  /// **'This week · Target {percent}%'**
  String thisWeekTarget(Object percent);

  /// No description provided for @dayMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get dayMon;

  /// No description provided for @dayTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get dayTue;

  /// No description provided for @dayWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get dayWed;

  /// No description provided for @dayThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get dayThu;

  /// No description provided for @dayFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get dayFri;

  /// No description provided for @daySat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get daySat;

  /// No description provided for @daySun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get daySun;

  /// No description provided for @myTrips.
  ///
  /// In en, this message translates to:
  /// **'My trips'**
  String get myTrips;

  /// No description provided for @searchTripHint.
  ///
  /// In en, this message translates to:
  /// **'Search trip ID or destination'**
  String get searchTripHint;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get filterToday;

  /// No description provided for @noTripsFound.
  ///
  /// In en, this message translates to:
  /// **'No trips found'**
  String get noTripsFound;

  /// No description provided for @tryAnotherSearch.
  ///
  /// In en, this message translates to:
  /// **'Try another trip ID or destination.'**
  String get tryAnotherSearch;

  /// No description provided for @todaySectionLabel.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get todaySectionLabel;

  /// No description provided for @recentlyCompleted.
  ///
  /// In en, this message translates to:
  /// **'RECENTLY COMPLETED'**
  String get recentlyCompleted;

  /// No description provided for @completedTripTitle.
  ///
  /// In en, this message translates to:
  /// **'Completed trip'**
  String get completedTripTitle;

  /// No description provided for @deliverySummary.
  ///
  /// In en, this message translates to:
  /// **'Delivery summary'**
  String get deliverySummary;

  /// No description provided for @tripId.
  ///
  /// In en, this message translates to:
  /// **'Trip ID'**
  String get tripId;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @deliveryDocsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Delivery documents and recorded quantities are not available for this trip.'**
  String get deliveryDocsUnavailable;

  /// No description provided for @tripDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip details'**
  String get tripDetailsTitle;

  /// No description provided for @estimatedTime.
  ///
  /// In en, this message translates to:
  /// **'Estimated {time}'**
  String estimatedTime(Object time);

  /// No description provided for @assignedStatus.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get assignedStatus;

  /// No description provided for @inProgressStatus.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get inProgressStatus;

  /// No description provided for @activeTripTitle.
  ///
  /// In en, this message translates to:
  /// **'Active trip'**
  String get activeTripTitle;

  /// No description provided for @arrivedAtPickup.
  ///
  /// In en, this message translates to:
  /// **'Arrived at pickup'**
  String get arrivedAtPickup;

  /// No description provided for @startLoading.
  ///
  /// In en, this message translates to:
  /// **'Start loading'**
  String get startLoading;

  /// No description provided for @confirmLoading.
  ///
  /// In en, this message translates to:
  /// **'Confirm loading'**
  String get confirmLoading;

  /// No description provided for @continueTrip.
  ///
  /// In en, this message translates to:
  /// **'Continue trip'**
  String get continueTrip;

  /// No description provided for @tripProgress.
  ///
  /// In en, this message translates to:
  /// **'Trip progress'**
  String get tripProgress;

  /// No description provided for @pickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get pickup;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @loadingMaterialTitle.
  ///
  /// In en, this message translates to:
  /// **'Loading material'**
  String get loadingMaterialTitle;

  /// No description provided for @plannedQuantity.
  ///
  /// In en, this message translates to:
  /// **'Planned quantity: {qty}'**
  String plannedQuantity(Object qty);

  /// No description provided for @actualQuantity.
  ///
  /// In en, this message translates to:
  /// **'Actual quantity'**
  String get actualQuantity;

  /// No description provided for @deliveryProofTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery proof'**
  String get deliveryProofTitle;

  /// No description provided for @captureDeliveryDetails.
  ///
  /// In en, this message translates to:
  /// **'Capture delivery details'**
  String get captureDeliveryDetails;

  /// No description provided for @receiverName.
  ///
  /// In en, this message translates to:
  /// **'Receiver name'**
  String get receiverName;

  /// No description provided for @deliveryNote.
  ///
  /// In en, this message translates to:
  /// **'Delivery note'**
  String get deliveryNote;

  /// No description provided for @completeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Complete delivery'**
  String get completeDelivery;

  /// No description provided for @tripCompletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip completed!'**
  String get tripCompletedTitle;

  /// No description provided for @completedAtTime.
  ///
  /// In en, this message translates to:
  /// **'Completed at {time}'**
  String completedAtTime(Object time);

  /// No description provided for @completedAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Completed at'**
  String get completedAtLabel;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;

  /// No description provided for @stageStarted.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get stageStarted;

  /// No description provided for @stageGoingToPickup.
  ///
  /// In en, this message translates to:
  /// **'Going to pickup'**
  String get stageGoingToPickup;

  /// No description provided for @stageArrivedAtPickup.
  ///
  /// In en, this message translates to:
  /// **'Arrived at pickup'**
  String get stageArrivedAtPickup;

  /// No description provided for @stageLoadingMaterial.
  ///
  /// In en, this message translates to:
  /// **'Loading material'**
  String get stageLoadingMaterial;

  /// No description provided for @stageDelivering.
  ///
  /// In en, this message translates to:
  /// **'Delivering'**
  String get stageDelivering;

  /// No description provided for @stageArrivedAtDestination.
  ///
  /// In en, this message translates to:
  /// **'Arrived at destination'**
  String get stageArrivedAtDestination;

  /// No description provided for @stageCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get stageCompleted;

  /// No description provided for @semStateComplete.
  ///
  /// In en, this message translates to:
  /// **'complete'**
  String get semStateComplete;

  /// No description provided for @semStateCurrent.
  ///
  /// In en, this message translates to:
  /// **'current'**
  String get semStateCurrent;

  /// No description provided for @semStatePending.
  ///
  /// In en, this message translates to:
  /// **'pending'**
  String get semStatePending;

  /// No description provided for @semTimelineLabel.
  ///
  /// In en, this message translates to:
  /// **'{label}, {state}'**
  String semTimelineLabel(Object label, Object state);

  /// No description provided for @readyToDepart.
  ///
  /// In en, this message translates to:
  /// **'Ready to depart'**
  String get readyToDepart;

  /// No description provided for @tripCompletedNote.
  ///
  /// In en, this message translates to:
  /// **'Trip completed'**
  String get tripCompletedNote;

  /// No description provided for @routeDistance.
  ///
  /// In en, this message translates to:
  /// **'{distance} route'**
  String routeDistance(Object distance);

  /// No description provided for @tripAssignedSemantics.
  ///
  /// In en, this message translates to:
  /// **'Trip assigned, pickup and delivery pending'**
  String get tripAssignedSemantics;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait…'**
  String get pleaseWait;
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
      <String>['en', 'km'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'km':
      return AppLocalizationsKm();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
