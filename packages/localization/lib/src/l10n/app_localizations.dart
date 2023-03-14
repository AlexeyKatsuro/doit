import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('ru')];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Doit'**
  String get title;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get languageSystem;

  /// No description provided for @languageRu.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get languageRu;

  /// No description provided for @languageEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEn;

  /// No description provided for @errorCommon.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorCommon;

  /// No description provided for @errorActionRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get errorActionRetry;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @homeNewReminder.
  ///
  /// In en, this message translates to:
  /// **'New Reminder'**
  String get homeNewReminder;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get homeSearchHint;

  /// No description provided for @homeMyListsHeader.
  ///
  /// In en, this message translates to:
  /// **'My Lists'**
  String get homeMyListsHeader;

  /// No description provided for @homeAddList.
  ///
  /// In en, this message translates to:
  /// **'Add List'**
  String get homeAddList;

  /// No description provided for @homeMenuEditLists.
  ///
  /// In en, this message translates to:
  /// **'Edit Lists'**
  String get homeMenuEditLists;

  /// No description provided for @homeMenuTemplates.
  ///
  /// In en, this message translates to:
  /// **'Templates'**
  String get homeMenuTemplates;

  /// No description provided for @homeMenuLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get homeMenuLogout;

  /// No description provided for @newReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'New Reminder'**
  String get newReminderTitle;

  /// No description provided for @newReminderAddAction.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get newReminderAddAction;

  /// No description provided for @newReminderTitleInputHint.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get newReminderTitleInputHint;

  /// No description provided for @newReminderNotesInputHint.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get newReminderNotesInputHint;

  /// No description provided for @newReminderDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get newReminderDetails;

  /// No description provided for @newReminderList.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get newReminderList;

  /// No description provided for @allTaskListsTitle.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allTaskListsTitle;

  /// No description provided for @taskNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get taskNoteHint;

  /// No description provided for @emailVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Email verification'**
  String get emailVerificationTitle;

  /// No description provided for @emailVerificationHint.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email using the link sent to {email}'**
  String emailVerificationHint(String email);

  /// No description provided for @emailVerificationCheck.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get emailVerificationCheck;

  /// No description provided for @emailVerificationCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get emailVerificationCancel;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
