// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'N1 TRANSPORTATION';

  @override
  String get roleDriver => 'Driver';

  @override
  String get roleTripAdviser => 'Trip Adviser';

  @override
  String get roleFuelStockManager => 'Fuel Stock Manager';

  @override
  String get roleCeo => 'CEO / Owner';

  @override
  String get roleDriverShort => 'Driver operations';

  @override
  String get roleTripAdviserShort => 'Trip planning';

  @override
  String get roleFuelStockManagerShort => 'Fuel operations';

  @override
  String get roleCeoShort => 'Business overview';

  @override
  String get roleDriverDesc =>
      'View assigned trips, update delivery status, and request fuel.';

  @override
  String get roleTripAdviserDesc =>
      'Plan trips, assign vehicles and drivers, then monitor progress.';

  @override
  String get roleFuelStockManagerDesc =>
      'Approve fuel requests and keep vehicle fuel stock accurate.';

  @override
  String get roleCeoDesc =>
      'Monitor logistics performance, delivery, fuel, and operating costs.';

  @override
  String get roleDriverSignIn => 'Driver ID';

  @override
  String get roleTripAdviserSignIn => 'Work email';

  @override
  String get roleFuelStockManagerSignIn => 'Employee ID';

  @override
  String get roleCeoSignIn => 'Work email';

  @override
  String get welcomeHeadline => 'Logistics that\nmove with confidence.';

  @override
  String get welcomeSubtitle =>
      'One operational workspace for your fleet, fuel, trips, and delivery performance.';

  @override
  String get openApp => 'Open N1 TRANSPORTATION';

  @override
  String get operationsMadeSimple => 'Operations made simple';

  @override
  String get selectRoleTitle => 'Select your role';

  @override
  String get selectRoleSubtitle =>
      'Your workspace is tailored to the work you do.';

  @override
  String get selectRoleFooter =>
      'You can switch roles from the dashboard later.';

  @override
  String continueAsRole(Object role) {
    return 'Continue as $role';
  }

  @override
  String get onboardingWorkspaceEyebrow => 'YOUR WORKSPACE';

  @override
  String onboardingBuiltFor(Object role) {
    return 'Built for $role.';
  }

  @override
  String get onboardingFlowEyebrow => 'ONE CLEAR FLOW';

  @override
  String get onboardingReadyEyebrow => 'READY WHEN YOU ARE';

  @override
  String get onboardingReadyTitle => 'Stay in control, anywhere.';

  @override
  String get onboardingReadyBody =>
      'Important updates, clear next steps, and practical information are always within reach.';

  @override
  String get onboardingAutoAdvance => 'Your workspace will open automatically';

  @override
  String get flowTitleDriver => 'From assigned trip to proof of delivery.';

  @override
  String get flowTitleTripAdviser => 'Create, assign, and monitor every trip.';

  @override
  String get flowTitleFuelStockManager =>
      'Approve fuel with live stock visibility.';

  @override
  String get flowTitleCeo => 'See the business, not just the numbers.';

  @override
  String get flowBodyDriver =>
      'See the next action immediately: start, navigate, load, deliver, and complete.';

  @override
  String get flowBodyTripAdviser =>
      'Set the vehicle, driver, pickup, delivery, material, and quantity in one clear workflow.';

  @override
  String get flowBodyFuelStockManager =>
      'Receive a request, approve or reject it, then record the fuel issued.';

  @override
  String get flowBodyCeo =>
      'Review delivery, active fleet, fuel usage, cost, and driver performance from one dashboard.';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String signInToWorkspace(Object role) {
    return 'Sign in to your $role workspace.';
  }

  @override
  String signingInAs(Object role) {
    return 'Signing in as $role';
  }

  @override
  String get change => 'Change';

  @override
  String get password => 'Password';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String enterYourField(Object field) {
    return 'Enter your $field';
  }

  @override
  String get enterValidPassword => 'Enter a valid password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get forgotPasswordMessage =>
      'Please contact N1 TRANSPORTATION support to reset your password.';

  @override
  String get signIn => 'Sign in';

  @override
  String get demoAccessNote => 'Demo access · No account creation required';

  @override
  String get navHome => 'Home';

  @override
  String get navTrips => 'Trips';

  @override
  String get navFuel => 'Fuel';

  @override
  String get navProfile => 'Profile';

  @override
  String get navNotifications => 'Notifications';

  @override
  String get goodMorning => 'Good morning,';

  @override
  String get onDuty => 'On duty';

  @override
  String get todaysTrip => 'Today\'s assigned trip';

  @override
  String get quickActions => 'Quick actions';

  @override
  String get requestFuel => 'Request fuel';

  @override
  String get tripHistory => 'Trip history';

  @override
  String get myVehicle => 'My vehicle';

  @override
  String get todayAtGlance => 'Today at a glance';

  @override
  String get todaysTrips => 'Today\'s trips';

  @override
  String get activeTrips => 'Active trips';

  @override
  String get completed => 'Completed';

  @override
  String get startTrip => 'Start trip';

  @override
  String get notifications => 'Notifications';

  @override
  String get notifNewTripTitle => 'New trip assigned';

  @override
  String notifNewTripSubtitle(Object id, Object time) {
    return 'Trip $id starts at $time';
  }

  @override
  String get notifNow => 'Now';

  @override
  String get notifFuelApprovedTitle => 'Fuel request approved';

  @override
  String notifFuelApprovedSubtitle(Object liters, Object plate) {
    return '$liters for $plate';
  }

  @override
  String get notif2h => '2h';

  @override
  String get completedTripsTitle => 'Completed trips';

  @override
  String get assignedVehicle => 'ASSIGNED VEHICLE';

  @override
  String get cementTruck => 'Cement Truck';

  @override
  String get vehicleAssignment => 'Vehicle assignment';

  @override
  String get driverLabel => 'Driver';

  @override
  String get driverIdLabel => 'Driver ID';

  @override
  String get vehicleActivity => 'Vehicle activity';

  @override
  String assignedTripLabel(Object id) {
    return 'Assigned trip · $id';
  }

  @override
  String get fuelRequestsLabel => 'Fuel requests';

  @override
  String get viewRequestsSubtitle => 'View requests and fuel activity';

  @override
  String get currentFuelLevel => 'Current fuel level';

  @override
  String get latestRequest => 'Latest request';

  @override
  String get requestHistory => 'Request history';

  @override
  String get statusApproved => 'Approved';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusRejected => 'Rejected';

  @override
  String get requestedAmount => 'Requested amount';

  @override
  String get liters => 'Liters';

  @override
  String get reason => 'Reason';

  @override
  String get reasonCurrentTrip => 'Current Trip';

  @override
  String get reasonNextTrip => 'Next Trip';

  @override
  String get reasonLowFuel => 'Low Fuel';

  @override
  String get reasonOther => 'Other';

  @override
  String get optionalNote => 'Optional note';

  @override
  String get submitRequest => 'Submit request';

  @override
  String get requestSubmittedTitle => 'Request submitted';

  @override
  String get requestSubmittedBody =>
      'Your fuel request has been sent to the Fuel Stock Manager.';

  @override
  String get done => 'Done';

  @override
  String get requestFor => 'REQUEST FOR';

  @override
  String get currentFuel => 'Current fuel';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileSubtitle => 'Manage your account and preferences';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get personalInfo => 'Personal information';

  @override
  String get fullName => 'Full name';

  @override
  String get enterYourName => 'Enter your name';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get activeDriver => 'Active Driver';

  @override
  String get activeAccount => 'Active account';

  @override
  String get phone => 'Phone';

  @override
  String get licenseNumber => 'License number';

  @override
  String get assignedVehicleLabel => 'Assigned vehicle';

  @override
  String get settings => 'Settings';

  @override
  String get personalInfoSubtitle => 'Update your personal details';

  @override
  String get changePassword => 'Change password';

  @override
  String get changePasswordSubtitle => 'Keep your account secure';

  @override
  String get language => 'Language';

  @override
  String get languageSubtitle => 'Select your preferred language';

  @override
  String get toggleTheme => 'Toggle theme';

  @override
  String get toggleThemeSubtitle => 'Switch between light and dark mode';

  @override
  String get helpSupport => 'Help & support';

  @override
  String get helpSupportSubtitle => 'Get help or contact our team';

  @override
  String get logOut => 'Log out';

  @override
  String get logOutTitle => 'Log out?';

  @override
  String get logOutBody =>
      'You will need to sign in again to access your workspace.';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageKhmer => 'Khmer';

  @override
  String get notifNoneTitle => 'No new notifications';

  @override
  String get createTrip => 'Create trip';

  @override
  String get todaysTripControl => 'Today\'s trip control';

  @override
  String get scheduled => 'Scheduled';

  @override
  String get inTransit => 'In transit';

  @override
  String get needAction => 'Need action';

  @override
  String get viewAll => 'View all';

  @override
  String get showingLatestTrips => 'Showing the latest active trips.';

  @override
  String get tripTools => 'Trip tools';

  @override
  String get trackFleet => 'Track fleet';

  @override
  String get tripReports => 'Trip reports';

  @override
  String get fleetOverview => 'Fleet overview';

  @override
  String get moving => 'Moving';

  @override
  String get idle => 'Idle';

  @override
  String get parked => 'Parked';

  @override
  String get fleetVehicles => 'Fleet vehicles';

  @override
  String get reportsOverview => 'Reports overview';

  @override
  String get avgDeliveryTime => 'Avg. delivery time';

  @override
  String get recentReports => 'Recent reports';

  @override
  String get filterDay => 'Day';

  @override
  String get filterMonth => 'Month';

  @override
  String get filterYear => 'Year';

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';

  @override
  String get planTheTrip => 'Plan the trip';

  @override
  String get planTheTripSubtitle =>
      'Assign the vehicle and driver, then define the route and material.';

  @override
  String get vehicleAndDriver => 'Vehicle & driver';

  @override
  String get route => 'Route';

  @override
  String get pickupLocation => 'Pickup location';

  @override
  String get deliveryLocation => 'Delivery location';

  @override
  String get material => 'Material';

  @override
  String get quantity => 'Quantity';

  @override
  String get tons => 'Tons';

  @override
  String get tripNoteOptional => 'Trip note (optional)';

  @override
  String get saveTripChanges => 'Save trip changes';

  @override
  String get sendTripToDriver => 'Send trip to driver';

  @override
  String get tripSentTitle => 'Trip sent to driver';

  @override
  String get tripSentBody =>
      'The driver can now see the assigned vehicle, route, material, and delivery instructions.';

  @override
  String tripLabel(Object id) {
    return 'Trip $id';
  }

  @override
  String get createATrip => 'Create a trip';

  @override
  String get mainFuelStock => 'MAIN FUEL STOCK';

  @override
  String availableReserve(Object percent, Object threshold) {
    return '$percent% available · Reserve threshold: $threshold%';
  }

  @override
  String get fuelRequestsAwaiting => 'Fuel requests awaiting action';

  @override
  String get todaysIssuingSummary => 'Today\'s issuing summary';

  @override
  String get issuedToday => 'Issued today';

  @override
  String get reject => 'Reject';

  @override
  String get approve => 'Approve';

  @override
  String get recordFuelOut => 'Record fuel out';

  @override
  String get fuelIssueRecordedMsg => 'Fuel issue recorded and stock updated.';

  @override
  String fuelApprovedMsg(Object liters, Object name) {
    return '$liters approved for $name. Fuel stock will be updated on issue.';
  }

  @override
  String get fuelRejectedMsg => 'Fuel request rejected.';

  @override
  String get undo => 'Undo';

  @override
  String get fuelReports => 'Fuel reports';

  @override
  String get totalIssued => 'Total issued';

  @override
  String get requestsApproved => 'Requests approved';

  @override
  String get requestsRejected => 'Requests rejected';

  @override
  String get recentFuelActivity => 'Recent fuel activity';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get tryDifferentFilter => 'Try a different filter.';

  @override
  String get businessOverview => 'Business overview';

  @override
  String get activeVehicles => 'Active vehicles';

  @override
  String get tripsThisMonth => 'Trips this month';

  @override
  String get onTimeRate => 'On-time rate';

  @override
  String get deliveryPerformance => 'Delivery performance';

  @override
  String get managementDashboard => 'Management dashboard';

  @override
  String get onTimeCompletion => 'On-time completion';

  @override
  String thisWeekTarget(Object percent) {
    return 'This week · Target $percent%';
  }

  @override
  String get dayMon => 'Mon';

  @override
  String get dayTue => 'Tue';

  @override
  String get dayWed => 'Wed';

  @override
  String get dayThu => 'Thu';

  @override
  String get dayFri => 'Fri';

  @override
  String get daySat => 'Sat';

  @override
  String get daySun => 'Sun';

  @override
  String get myTrips => 'My trips';

  @override
  String get searchTripHint => 'Search trip ID or destination';

  @override
  String get filterAll => 'All';

  @override
  String get filterToday => 'Today';

  @override
  String get noTripsFound => 'No trips found';

  @override
  String get tryAnotherSearch => 'Try another trip ID or destination.';

  @override
  String get todaySectionLabel => 'TODAY';

  @override
  String get recentlyCompleted => 'RECENTLY COMPLETED';

  @override
  String get completedTripTitle => 'Completed trip';

  @override
  String get deliverySummary => 'Delivery summary';

  @override
  String get tripId => 'Trip ID';

  @override
  String get status => 'Status';

  @override
  String get deliveryDocsUnavailable =>
      'Delivery documents and recorded quantities are not available for this trip.';

  @override
  String get tripDetailsTitle => 'Trip details';

  @override
  String estimatedTime(Object time) {
    return 'Estimated $time';
  }

  @override
  String get assignedStatus => 'Assigned';

  @override
  String get inProgressStatus => 'In progress';

  @override
  String get startTripConfirmTitle => 'Start this trip?';

  @override
  String get startTripConfirmBody =>
      'Confirm when you are ready to head to the pickup location.';

  @override
  String get yesStartTrip => 'Yes, start trip';

  @override
  String get activeTripTitle => 'Active trip';

  @override
  String get arrivedAtPickup => 'Arrived at pickup';

  @override
  String get startLoading => 'Start loading';

  @override
  String get confirmLoading => 'Confirm loading';

  @override
  String get continueTrip => 'Continue trip';

  @override
  String get tripProgress => 'Trip progress';

  @override
  String get pickup => 'Pickup';

  @override
  String get delivery => 'Delivery';

  @override
  String get loadingMaterialTitle => 'Loading material';

  @override
  String plannedQuantity(Object qty) {
    return 'Planned quantity: $qty';
  }

  @override
  String get actualQuantity => 'Actual quantity';

  @override
  String get deliveryProofTitle => 'Delivery proof';

  @override
  String get captureDeliveryDetails => 'Capture delivery details';

  @override
  String get receiverName => 'Receiver name';

  @override
  String get deliveryNote => 'Delivery note';

  @override
  String get completeDelivery => 'Complete delivery';

  @override
  String get tripCompletedTitle => 'Trip completed!';

  @override
  String get backToHome => 'Back to home';

  @override
  String get stageStarted => 'Started';

  @override
  String get stageGoingToPickup => 'Going to pickup';

  @override
  String get stageArrivedAtPickup => 'Arrived at pickup';

  @override
  String get stageLoadingMaterial => 'Loading material';

  @override
  String get stageDelivering => 'Delivering';

  @override
  String get stageArrivedAtDestination => 'Arrived at destination';

  @override
  String get stageUnloading => 'Unloading';

  @override
  String get stageCompleted => 'Completed';

  @override
  String get semStateComplete => 'complete';

  @override
  String get semStateCurrent => 'current';

  @override
  String get semStatePending => 'pending';

  @override
  String semTimelineLabel(Object label, Object state) {
    return '$label, $state';
  }

  @override
  String get readyToDepart => 'Ready to depart';

  @override
  String get tripCompletedNote => 'Trip completed';

  @override
  String routeDistance(Object distance) {
    return '$distance route';
  }

  @override
  String get tripAssignedSemantics =>
      'Trip assigned, pickup and delivery pending';

  @override
  String get pleaseWait => 'Please wait…';
}
