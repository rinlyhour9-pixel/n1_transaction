// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class AppLocalizationsKm extends AppLocalizations {
  AppLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get appTitle => 'N1 TRANSPORTATION';

  @override
  String get roleDriver => 'អ្នកបើកបរ';

  @override
  String get roleTripAdviser => 'អ្នកគ្រប់គ្រងដំណើរ';

  @override
  String get roleFuelStockManager => 'អ្នកគ្រប់គ្រងស្តុកប្រេង';

  @override
  String get roleCeo => 'នាយកប្រតិបត្តិ / ម្ចាស់';

  @override
  String get roleDriverShort => 'ប្រតិបត្តិការអ្នកបើកបរ';

  @override
  String get roleTripAdviserShort => 'ការគ្រោងដំណើរ';

  @override
  String get roleFuelStockManagerShort => 'ប្រតិបត្តិការប្រេងឥន្ធនៈ';

  @override
  String get roleCeoShort => 'ទិដ្ឋភាពទូទៅអាជីវកម្ម';

  @override
  String get roleDriverDesc =>
      'មើលដំណើរដែលបានចាត់តាំង ធ្វើបច្ចុប្បន្នភាពស្ថានភាពដឹកជញ្ជូន និងស្នើសុំប្រេងឥន្ធនៈ។';

  @override
  String get roleTripAdviserDesc =>
      'គ្រោងដំណើរ ចាត់តាំងយានយន្ត និងអ្នកបើកបរ រួចតាមដានវឌ្ឍនភាព។';

  @override
  String get roleFuelStockManagerDesc =>
      'អនុម័តសំណើសុំប្រេងឥន្ធនៈ និងរក្សាភាពត្រឹមត្រូវនៃស្តុកប្រេងឥន្ធនៈយានយន្ត។';

  @override
  String get roleCeoDesc =>
      'តាមដានសមត្ថភាពដឹកជញ្ជូន ការដឹកជញ្ជូន ប្រេងឥន្ធនៈ និងថ្លៃដើមប្រតិបត្តិការ។';

  @override
  String get roleDriverSignIn => 'លេខសម្គាល់អ្នកបើកបរ';

  @override
  String get roleTripAdviserSignIn => 'អ៊ីមែលការងារ';

  @override
  String get roleFuelStockManagerSignIn => 'លេខសម្គាល់បុគ្គលិក';

  @override
  String get roleCeoSignIn => 'អ៊ីមែលការងារ';

  @override
  String get welcomeHeadline => 'ដឹកជញ្ជូន ដោយ\nទំនុកចិត្តពេញលេញ។';

  @override
  String get welcomeSubtitle =>
      'កន្លែងធ្វើការមួយសម្រាប់ក្រុមយានយន្ត ប្រេងឥន្ធនៈ ដំណើរ និងសមត្ថភាពដឹកជញ្ជូនរបស់អ្នក។';

  @override
  String get openApp => 'បើក N1 TRANSPORTATION';

  @override
  String get operationsMadeSimple => 'ប្រតិបត្តិការឲ្យសាមញ្ញ';

  @override
  String get selectRoleTitle => 'ជ្រើសរើសតួនាទីរបស់អ្នក';

  @override
  String get selectRoleSubtitle =>
      'កន្លែងធ្វើការរបស់អ្នកត្រូវបានរៀបចំតាមការងាររបស់អ្នក។';

  @override
  String get selectRoleFooter =>
      'អ្នកអាចប្តូរតួនាទីពីទំព័រគ្រប់គ្រងនៅពេលក្រោយ។';

  @override
  String continueAsRole(Object role) {
    return 'បន្តជា $role';
  }

  @override
  String get onboardingWorkspaceEyebrow => 'កន្លែងធ្វើការរបស់អ្នក';

  @override
  String onboardingBuiltFor(Object role) {
    return 'រៀបចំសម្រាប់ $role។';
  }

  @override
  String get onboardingFlowEyebrow => 'លំហូរច្បាស់លាស់មួយ';

  @override
  String get onboardingReadyEyebrow => 'ត្រៀមខ្លួនរួចរាល់';

  @override
  String get onboardingReadyTitle => 'គ្រប់គ្រងបានគ្រប់ទីកន្លែង។';

  @override
  String get onboardingReadyBody =>
      'ព័ត៌មានសំខាន់ៗ ជំហានបន្ទាប់ច្បាស់លាស់ និងព័ត៌មានជាក់ស្តែង តែងតែនៅជិតដៃអ្នក។';

  @override
  String get onboardingAutoAdvance =>
      'កន្លែងធ្វើការរបស់អ្នកនឹងបើកដោយស្វ័យប្រវត្តិ';

  @override
  String get flowTitleDriver =>
      'ចាប់ពីដំណើរដែលបានចាត់តាំង រហូតដល់ភស្តុតាងដឹកជញ្ជូន។';

  @override
  String get flowTitleTripAdviser => 'បង្កើត ចាត់តាំង និងតាមដានរាល់ដំណើរ។';

  @override
  String get flowTitleFuelStockManager =>
      'អនុម័តប្រេងឥន្ធនៈ ជាមួយនឹងភាពមើលឃើញស្តុកផ្ទាល់។';

  @override
  String get flowTitleCeo => 'មើលឃើញអាជីវកម្ម មិនមែនត្រឹមតែលេខប៉ុណ្ណោះទេ។';

  @override
  String get flowBodyDriver =>
      'មើលឃើញសកម្មភាពបន្ទាប់ភ្លាមៗ៖ ចាប់ផ្តើម ដឹកនាំផ្លូវ ផ្ទុក ដឹកជញ្ជូន និងបញ្ចប់។';

  @override
  String get flowBodyTripAdviser =>
      'កំណត់យានយន្ត អ្នកបើកបរ ទីតាំងទទួល ដឹកជញ្ជូន សម្ភារៈ និងបរិមាណ ក្នុងលំហូរការងារច្បាស់លាស់តែមួយ។';

  @override
  String get flowBodyFuelStockManager =>
      'ទទួលសំណើមួយ អនុម័ត ឬបដិសេធ រួចកត់ត្រាប្រេងឥន្ធនៈដែលបានចាយ។';

  @override
  String get flowBodyCeo =>
      'ពិនិត្យមើលការដឹកជញ្ជូន ក្រុមយានយន្តសកម្ម ការប្រើប្រាស់ប្រេងឥន្ធនៈ ថ្លៃដើម និងសមត្ថភាពអ្នកបើកបរ ពីទំព័រគ្រប់គ្រងតែមួយ។';

  @override
  String get welcomeBack => 'សូមស្វាគមន៍ការត្រឡប់មកវិញ';

  @override
  String signInToWorkspace(Object role) {
    return 'ចូលប្រើកន្លែងធ្វើការ $role របស់អ្នក។';
  }

  @override
  String signingInAs(Object role) {
    return 'កំពុងចូលប្រើជា $role';
  }

  @override
  String get change => 'ប្តូរ';

  @override
  String get password => 'ពាក្យសម្ងាត់';

  @override
  String get showPassword => 'បង្ហាញពាក្យសម្ងាត់';

  @override
  String get hidePassword => 'លាក់ពាក្យសម្ងាត់';

  @override
  String enterYourField(Object field) {
    return 'សូមបញ្ចូល $field របស់អ្នក';
  }

  @override
  String get enterValidPassword => 'សូមបញ្ចូលពាក្យសម្ងាត់ត្រឹមត្រូវ';

  @override
  String get forgotPassword => 'ភ្លេចពាក្យសម្ងាត់?';

  @override
  String get forgotPasswordMessage =>
      'សូមទាក់ទងផ្នែកជំនួយ N1 TRANSPORTATION ដើម្បីកំណត់ពាក្យសម្ងាត់ឡើងវិញ។';

  @override
  String get signIn => 'ចូលប្រើប្រាស់';

  @override
  String get demoAccessNote => 'ការចូលប្រើសាកល្បង · មិនចាំបាច់បង្កើតគណនី';

  @override
  String get navHome => 'ទំព័រដើម';

  @override
  String get navTrips => 'ដំណើរ';

  @override
  String get navFuel => 'ប្រេងឥន្ធនៈ';

  @override
  String get navProfile => 'គណនី';

  @override
  String get navNotifications => 'ការជូនដំណឹង';

  @override
  String get goodMorning => 'អរុណសួស្តី,';

  @override
  String get onDuty => 'កំពុងបំពេញការងារ';

  @override
  String get todaysTrip => 'ដំណើរដែលបានចាត់តាំងថ្ងៃនេះ';

  @override
  String get quickActions => 'សកម្មភាពរហ័ស';

  @override
  String get requestFuel => 'ស្នើសុំប្រេងឥន្ធនៈ';

  @override
  String get tripHistory => 'ប្រវត្តិដំណើរ';

  @override
  String get myVehicle => 'យានយន្តរបស់ខ្ញុំ';

  @override
  String get todayAtGlance => 'ទិដ្ឋភាពថ្ងៃនេះ';

  @override
  String get todaysTrips => 'ដំណើរថ្ងៃនេះ';

  @override
  String get activeTrips => 'ដំណើរកំពុងដំណើរការ';

  @override
  String get completed => 'បានបញ្ចប់';

  @override
  String get startTrip => 'ចាប់ផ្តើមដំណើរ';

  @override
  String get notifications => 'ការជូនដំណឹង';

  @override
  String get notifNewTripTitle => 'ដំណើរថ្មីត្រូវបានចាត់តាំង';

  @override
  String notifNewTripSubtitle(Object id, Object time) {
    return 'ដំណើរ $id ចាប់ផ្តើមម៉ោង $time';
  }

  @override
  String get notifNow => 'ឥឡូវនេះ';

  @override
  String get notifFuelApprovedTitle => 'សំណើសុំប្រេងឥន្ធនៈត្រូវបានអនុម័ត';

  @override
  String notifFuelApprovedSubtitle(Object liters, Object plate) {
    return '$liters សម្រាប់ $plate';
  }

  @override
  String get notif2h => '២ម៉ោង';

  @override
  String get completedTripsTitle => 'ដំណើរដែលបានបញ្ចប់';

  @override
  String get assignedVehicle => 'យានយន្តដែលបានចាត់តាំង';

  @override
  String get cementTruck => 'ឡានស៊ីម៉ង់ត៍';

  @override
  String get vehicleAssignment => 'ការចាត់តាំងយានយន្ត';

  @override
  String get driverLabel => 'អ្នកបើកបរ';

  @override
  String get driverIdLabel => 'លេខសម្គាល់អ្នកបើកបរ';

  @override
  String get vehicleActivity => 'សកម្មភាពយានយន្ត';

  @override
  String assignedTripLabel(Object id) {
    return 'ដំណើរដែលបានចាត់តាំង · $id';
  }

  @override
  String get fuelRequestsLabel => 'សំណើសុំប្រេងឥន្ធនៈ';

  @override
  String get viewRequestsSubtitle => 'មើលសំណើ និងសកម្មភាពប្រេងឥន្ធនៈ';

  @override
  String get currentFuelLevel => 'កម្រិតប្រេងឥន្ធនៈបច្ចុប្បន្ន';

  @override
  String get latestRequest => 'សំណើចុងក្រោយ';

  @override
  String get requestHistory => 'ប្រវត្តិសំណើ';

  @override
  String get statusApproved => 'បានអនុម័ត';

  @override
  String get statusPending => 'កំពុងរង់ចាំ';

  @override
  String get statusRejected => 'បានបដិសេធ';

  @override
  String get requestedAmount => 'ចំនួនស្នើសុំ';

  @override
  String get liters => 'លីត្រ';

  @override
  String get reason => 'មូលហេតុ';

  @override
  String get reasonCurrentTrip => 'ដំណើរបច្ចុប្បន្ន';

  @override
  String get reasonNextTrip => 'ដំណើរបន្ទាប់';

  @override
  String get reasonLowFuel => 'ប្រេងជិតអស់';

  @override
  String get reasonOther => 'ផ្សេងទៀត';

  @override
  String get optionalNote => 'កំណត់ចំណាំ (មិនចាំបាច់)';

  @override
  String get submitRequest => 'ដាក់ស្នើសំណើ';

  @override
  String get requestSubmittedTitle => 'សំណើត្រូវបានដាក់ស្នើ';

  @override
  String get requestSubmittedBody =>
      'សំណើសុំប្រេងឥន្ធនៈរបស់អ្នកត្រូវបានផ្ញើទៅអ្នកគ្រប់គ្រងស្តុកប្រេង។';

  @override
  String get done => 'រួចរាល់';

  @override
  String get requestFor => 'ស្នើសុំសម្រាប់';

  @override
  String get currentFuel => 'ប្រេងបច្ចុប្បន្ន';

  @override
  String get profileTitle => 'គណនី';

  @override
  String get profileSubtitle => 'គ្រប់គ្រងគណនី និងចំណូលចិត្តរបស់អ្នក';

  @override
  String get editProfile => 'កែសម្រួលគណនី';

  @override
  String get personalInfo => 'ព័ត៌មានផ្ទាល់ខ្លួន';

  @override
  String get fullName => 'ឈ្មោះពេញ';

  @override
  String get enterYourName => 'សូមបញ្ចូលឈ្មោះរបស់អ្នក';

  @override
  String get cancel => 'បោះបង់';

  @override
  String get save => 'រក្សាទុក';

  @override
  String get activeDriver => 'អ្នកបើកបរសកម្ម';

  @override
  String get activeAccount => 'គណនីសកម្ម';

  @override
  String get phone => 'ទូរស័ព្ទ';

  @override
  String get licenseNumber => 'លេខអាជ្ញាបណ្ណបើកបរ';

  @override
  String get assignedVehicleLabel => 'យានយន្តដែលបានចាត់តាំង';

  @override
  String get settings => 'ការកំណត់';

  @override
  String get personalInfoSubtitle => 'ធ្វើបច្ចុប្បន្នភាពព័ត៌មានផ្ទាល់ខ្លួន';

  @override
  String get changePassword => 'ប្តូរពាក្យសម្ងាត់';

  @override
  String get changePasswordSubtitle => 'រក្សាគណនីរបស់អ្នកឱ្យមានសុវត្ថិភាព';

  @override
  String get language => 'ភាសា';

  @override
  String get languageSubtitle => 'ជ្រើសរើសភាសាដែលអ្នកចង់ប្រើ';

  @override
  String get toggleTheme => 'ប្តូររចនាបថ';

  @override
  String get toggleThemeSubtitle => 'ប្តូររវាងរបៀបភ្លឺ និងងងឹត';

  @override
  String get helpSupport => 'ជំនួយ និងគាំទ្រ';

  @override
  String get helpSupportSubtitle => 'ទទួលបានជំនួយ ឬទាក់ទងក្រុមការងាររបស់យើង';

  @override
  String get logOut => 'ចាកចេញ';

  @override
  String get logOutTitle => 'ចាកចេញ?';

  @override
  String get logOutBody =>
      'អ្នកនឹងត្រូវចូលម្តងទៀត ដើម្បីចូលប្រើកន្លែងធ្វើការរបស់អ្នក។';

  @override
  String get selectLanguage => 'ជ្រើសរើសភាសា';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageKhmer => 'ខ្មែរ';

  @override
  String get notifNoneTitle => 'មិនមានការជូនដំណឹងថ្មីទេ';

  @override
  String get createTrip => 'បង្កើតដំណើរ';

  @override
  String get todaysTripControl => 'ការគ្រប់គ្រងដំណើរថ្ងៃនេះ';

  @override
  String get scheduled => 'បានកំណត់ពេល';

  @override
  String get inTransit => 'កំពុងធ្វើដំណើរ';

  @override
  String get needAction => 'ត្រូវការសកម្មភាព';

  @override
  String get viewAll => 'មើលទាំងអស់';

  @override
  String get showingLatestTrips => 'កំពុងបង្ហាញដំណើរសកម្មចុងក្រោយបំផុត។';

  @override
  String get tripTools => 'ឧបករណ៍ដំណើរ';

  @override
  String get trackFleet => 'តាមដានក្រុមយានយន្ត';

  @override
  String get tripReports => 'របាយការណ៍ដំណើរ';

  @override
  String get fleetOverview => 'ទិដ្ឋភាពទូទៅក្រុមយានយន្ត';

  @override
  String get moving => 'កំពុងធ្វើដំណើរ';

  @override
  String get idle => 'ទំនេរ';

  @override
  String get parked => 'ចត';

  @override
  String get fleetVehicles => 'យានយន្តក្នុងក្រុម';

  @override
  String get reportsOverview => 'ទិដ្ឋភាពទូទៅរបាយការណ៍';

  @override
  String get avgDeliveryTime => 'រយៈពេលដឹកជញ្ជូនជាមធ្យម';

  @override
  String get recentReports => 'របាយការណ៍ថ្មីៗ';

  @override
  String get filterDay => 'ថ្ងៃ';

  @override
  String get filterMonth => 'ខែ';

  @override
  String get filterYear => 'ឆ្នាំ';

  @override
  String get monthJan => 'មករា';

  @override
  String get monthFeb => 'កុម្ភៈ';

  @override
  String get monthMar => 'មីនា';

  @override
  String get monthApr => 'មេសា';

  @override
  String get monthMay => 'ឧសភា';

  @override
  String get monthJun => 'មិថុនា';

  @override
  String get monthJul => 'កក្កដា';

  @override
  String get monthAug => 'សីហា';

  @override
  String get monthSep => 'កញ្ញា';

  @override
  String get monthOct => 'តុលា';

  @override
  String get monthNov => 'វិច្ឆិកា';

  @override
  String get monthDec => 'ធ្នូ';

  @override
  String get planTheTrip => 'គ្រោងដំណើរ';

  @override
  String get planTheTripSubtitle =>
      'ចាត់តាំងយានយន្ត និងអ្នកបើកបរ រួចកំណត់ផ្លូវ និងសម្ភារៈ។';

  @override
  String get vehicleAndDriver => 'យានយន្ត និងអ្នកបើកបរ';

  @override
  String get route => 'ផ្លូវ';

  @override
  String get pickupLocation => 'ទីតាំងទទួល';

  @override
  String get deliveryLocation => 'ទីតាំងដឹកជញ្ជូន';

  @override
  String get material => 'សម្ភារៈ';

  @override
  String get quantity => 'បរិមាណ';

  @override
  String get tons => 'តោន';

  @override
  String get tripNoteOptional => 'កំណត់ចំណាំដំណើរ (មិនចាំបាច់)';

  @override
  String get saveTripChanges => 'រក្សាទុកការផ្លាស់ប្តូរដំណើរ';

  @override
  String get sendTripToDriver => 'ផ្ញើដំណើរទៅអ្នកបើកបរ';

  @override
  String get tripSentTitle => 'ដំណើរត្រូវបានផ្ញើទៅអ្នកបើកបរ';

  @override
  String get tripSentBody =>
      'អ្នកបើកបរឥឡូវនេះអាចមើលឃើញយានយន្តដែលបានចាត់តាំង ផ្លូវ សម្ភារៈ និងការណែនាំដឹកជញ្ជូន។';

  @override
  String tripLabel(Object id) {
    return 'ដំណើរ $id';
  }

  @override
  String get createATrip => 'បង្កើតដំណើរថ្មី';

  @override
  String get mainFuelStock => 'ស្តុកប្រេងឥន្ធនៈសំខាន់';

  @override
  String availableReserve(Object percent, Object threshold) {
    return 'នៅសល់ $percent% · កម្រិតបម្រុង៖ $threshold%';
  }

  @override
  String get fuelRequestsAwaiting => 'សំណើសុំប្រេងឥន្ធនៈកំពុងរង់ចាំសកម្មភាព';

  @override
  String get todaysIssuingSummary => 'សេចក្តីសង្ខេបការចាយប្រេងថ្ងៃនេះ';

  @override
  String get issuedToday => 'បានចាយថ្ងៃនេះ';

  @override
  String get reject => 'បដិសេធ';

  @override
  String get approve => 'អនុម័ត';

  @override
  String get recordFuelOut => 'កត់ត្រាការចាយប្រេង';

  @override
  String get fuelIssueRecordedMsg =>
      'ការចាយប្រេងត្រូវបានកត់ត្រា ហើយស្តុកត្រូវបានធ្វើបច្ចុប្បន្នភាព។';

  @override
  String fuelApprovedMsg(Object liters, Object name) {
    return '$liters ត្រូវបានអនុម័តសម្រាប់ $name។ ស្តុកប្រេងនឹងត្រូវបានធ្វើបច្ចុប្បន្នភាពនៅពេលចេញប្រេង។';
  }

  @override
  String get fuelRejectedMsg => 'សំណើសុំប្រេងឥន្ធនៈត្រូវបានបដិសេធ។';

  @override
  String get undo => 'មិនធ្វើវិញ';

  @override
  String get fuelReports => 'របាយការណ៍ប្រេងឥន្ធនៈ';

  @override
  String get totalIssued => 'សរុបបានចាយ';

  @override
  String get requestsApproved => 'សំណើបានអនុម័ត';

  @override
  String get requestsRejected => 'សំណើបានបដិសេធ';

  @override
  String get recentFuelActivity => 'សកម្មភាពប្រេងឥន្ធនៈថ្មីៗ';

  @override
  String get noResultsFound => 'រកមិនឃើញលទ្ធផល';

  @override
  String get tryDifferentFilter => 'សូមសាកល្បងតម្រងផ្សេងទៀត។';

  @override
  String get businessOverview => 'ទិដ្ឋភាពទូទៅអាជីវកម្ម';

  @override
  String get activeVehicles => 'យានយន្តសកម្ម';

  @override
  String get tripsThisMonth => 'ដំណើរខែនេះ';

  @override
  String get onTimeRate => 'អត្រាទាន់ពេលវេលា';

  @override
  String get deliveryPerformance => 'សមត្ថភាពដឹកជញ្ជូន';

  @override
  String get managementDashboard => 'ទំព័រគ្រប់គ្រង';

  @override
  String get onTimeCompletion => 'បញ្ចប់ទាន់ពេលវេលា';

  @override
  String thisWeekTarget(Object percent) {
    return 'សប្តាហ៍នេះ · គោលដៅ $percent%';
  }

  @override
  String get dayMon => 'ច័ន្ទ';

  @override
  String get dayTue => 'អង្គារ';

  @override
  String get dayWed => 'ពុធ';

  @override
  String get dayThu => 'ព្រហស្បតិ៍';

  @override
  String get dayFri => 'សុក្រ';

  @override
  String get daySat => 'សៅរ៍';

  @override
  String get daySun => 'អាទិត្យ';

  @override
  String get myTrips => 'ដំណើររបស់ខ្ញុំ';

  @override
  String get searchTripHint => 'ស្វែងរកលេខសម្គាល់ដំណើរ ឬទីតាំង';

  @override
  String get filterAll => 'ទាំងអស់';

  @override
  String get filterToday => 'ថ្ងៃនេះ';

  @override
  String get noTripsFound => 'រកមិនឃើញដំណើរ';

  @override
  String get tryAnotherSearch => 'សូមសាកល្បងលេខសម្គាល់ ឬទីតាំងផ្សេងទៀត។';

  @override
  String get todaySectionLabel => 'ថ្ងៃនេះ';

  @override
  String get recentlyCompleted => 'បានបញ្ចប់ថ្មីៗ';

  @override
  String get completedTripTitle => 'ដំណើរដែលបានបញ្ចប់';

  @override
  String get deliverySummary => 'សេចក្តីសង្ខេបការដឹកជញ្ជូន';

  @override
  String get tripId => 'លេខសម្គាល់ដំណើរ';

  @override
  String get status => 'ស្ថានភាព';

  @override
  String get deliveryDocsUnavailable =>
      'ឯកសារដឹកជញ្ជូន និងបរិមាណដែលបានកត់ត្រា មិនមានសម្រាប់ដំណើរនេះទេ។';

  @override
  String get tripDetailsTitle => 'ព័ត៌មានលម្អិតដំណើរ';

  @override
  String estimatedTime(Object time) {
    return 'ប៉ាន់ស្មាន $time';
  }

  @override
  String get assignedStatus => 'បានចាត់តាំង';

  @override
  String get inProgressStatus => 'កំពុងដំណើរការ';

  @override
  String get startTripConfirmTitle => 'ចាប់ផ្តើមដំណើរនេះ?';

  @override
  String get startTripConfirmBody =>
      'សូមបញ្ជាក់នៅពេលអ្នករួចរាល់ធ្វើដំណើរទៅកាន់ទីតាំងទទួល។';

  @override
  String get yesStartTrip => 'បាទ/ចាស ចាប់ផ្តើមដំណើរ';

  @override
  String get activeTripTitle => 'ដំណើរសកម្ម';

  @override
  String get arrivedAtPickup => 'បានមកដល់ទីតាំងទទួល';

  @override
  String get startLoading => 'ចាប់ផ្តើមផ្ទុកទំនិញ';

  @override
  String get confirmLoading => 'បញ្ជាក់ការផ្ទុកទំនិញ';

  @override
  String get continueTrip => 'បន្តដំណើរ';

  @override
  String get tripProgress => 'វឌ្ឍនភាពដំណើរ';

  @override
  String get pickup => 'ទីតាំងទទួល';

  @override
  String get delivery => 'ដឹកជញ្ជូន';

  @override
  String get loadingMaterialTitle => 'កំពុងផ្ទុកសម្ភារៈ';

  @override
  String plannedQuantity(Object qty) {
    return 'បរិមាណគ្រោង៖ $qty';
  }

  @override
  String get actualQuantity => 'បរិមាណជាក់ស្តែង';

  @override
  String get deliveryProofTitle => 'ភស្តុតាងដឹកជញ្ជូន';

  @override
  String get captureDeliveryDetails => 'ថតកត់ត្រាព័ត៌មានដឹកជញ្ជូន';

  @override
  String get receiverName => 'ឈ្មោះអ្នកទទួល';

  @override
  String get deliveryNote => 'កំណត់ចំណាំដឹកជញ្ជូន';

  @override
  String get completeDelivery => 'បញ្ចប់ការដឹកជញ្ជូន';

  @override
  String get tripCompletedTitle => 'ដំណើរបានបញ្ចប់!';

  @override
  String get backToHome => 'ត្រឡប់ទៅទំព័រដើម';

  @override
  String get stageStarted => 'បានចាប់ផ្តើម';

  @override
  String get stageGoingToPickup => 'កំពុងទៅទីតាំងទទួល';

  @override
  String get stageArrivedAtPickup => 'បានមកដល់ទីតាំងទទួល';

  @override
  String get stageLoadingMaterial => 'កំពុងផ្ទុកសម្ភារៈ';

  @override
  String get stageDelivering => 'កំពុងដឹកជញ្ជូន';

  @override
  String get stageArrivedAtDestination => 'បានមកដល់ទីតាំងដឹកជញ្ជូន';

  @override
  String get stageUnloading => 'កំពុងបន្ថយទំនិញ';

  @override
  String get stageCompleted => 'បានបញ្ចប់';

  @override
  String get semStateComplete => 'បានបញ្ចប់';

  @override
  String get semStateCurrent => 'បច្ចុប្បន្ន';

  @override
  String get semStatePending => 'កំពុងរង់ចាំ';

  @override
  String semTimelineLabel(Object label, Object state) {
    return '$label, $state';
  }

  @override
  String get readyToDepart => 'ត្រៀមរួចរាល់ដើម្បីចេញដំណើរ';

  @override
  String get tripCompletedNote => 'ដំណើរបានបញ្ចប់';

  @override
  String routeDistance(Object distance) {
    return 'ផ្លូវចម្ងាយ $distance';
  }

  @override
  String get tripAssignedSemantics =>
      'ដំណើរត្រូវបានចាត់តាំង ការទទួល និងដឹកជញ្ជូនកំពុងរង់ចាំ';

  @override
  String get pleaseWait => 'សូមរង់ចាំ…';
}
