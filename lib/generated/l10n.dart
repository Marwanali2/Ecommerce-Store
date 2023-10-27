// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Enjoy Our Products`
  String get appBarTitle {
    return Intl.message(
      'Enjoy Our Products',
      name: 'appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search Products...`
  String get searchText {
    return Intl.message(
      'Search Products...',
      name: 'searchText',
      desc: '',
      args: [],
    );
  }

  /// `Select Category`
  String get categorySelection {
    return Intl.message(
      'Select Category',
      name: 'categorySelection',
      desc: '',
      args: [],
    );
  }

  /// `New Offers And Discounts`
  String get bannerText {
    return Intl.message(
      'New Offers And Discounts',
      name: 'bannerText',
      desc: '',
      args: [],
    );
  }

  /// `Electronic Devices`
  String get catTap1 {
    return Intl.message(
      'Electronic Devices',
      name: 'catTap1',
      desc: '',
      args: [],
    );
  }

  /// `Prevent Corona`
  String get catTap2 {
    return Intl.message(
      'Prevent Corona',
      name: 'catTap2',
      desc: '',
      args: [],
    );
  }

  /// `Sports`
  String get catTap3 {
    return Intl.message(
      'Sports',
      name: 'catTap3',
      desc: '',
      args: [],
    );
  }

  /// `Lighting`
  String get catTap4 {
    return Intl.message(
      'Lighting',
      name: 'catTap4',
      desc: '',
      args: [],
    );
  }

  /// `Clothes`
  String get catTap5 {
    return Intl.message(
      'Clothes',
      name: 'catTap5',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get selectLang {
    return Intl.message(
      'Change Language',
      name: 'selectLang',
      desc: '',
      args: [],
    );
  }

  /// `Change Theme`
  String get changeTheme {
    return Intl.message(
      'Change Theme',
      name: 'changeTheme',
      desc: '',
      args: [],
    );
  }

  /// `Added to Favourites successfully`
  String get snackAddFav {
    return Intl.message(
      'Added to Favourites successfully',
      name: 'snackAddFav',
      desc: '',
      args: [],
    );
  }

  /// `Removed From Favourites successfully`
  String get snackDelFav {
    return Intl.message(
      'Removed From Favourites successfully',
      name: 'snackDelFav',
      desc: '',
      args: [],
    );
  }

  /// `Added to carts successfully`
  String get snackAddCard {
    return Intl.message(
      'Added to carts successfully',
      name: 'snackAddCard',
      desc: '',
      args: [],
    );
  }

  /// `Removed From Carts successfully`
  String get snackDelCard {
    return Intl.message(
      'Removed From Carts successfully',
      name: 'snackDelCard',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get bottomNavHome {
    return Intl.message(
      'Home',
      name: 'bottomNavHome',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get bottomNavFav {
    return Intl.message(
      'Favourites',
      name: 'bottomNavFav',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get bottomNavCard {
    return Intl.message(
      'Card',
      name: 'bottomNavCard',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get ProfileDisplayName {
    return Intl.message(
      'Your Name',
      name: 'ProfileDisplayName',
      desc: '',
      args: [],
    );
  }

  /// `Your Phone`
  String get ProfileDisplayPhone {
    return Intl.message(
      'Your Phone',
      name: 'ProfileDisplayPhone',
      desc: '',
      args: [],
    );
  }

  /// `Your Email`
  String get ProfileDisplayEmail {
    return Intl.message(
      'Your Email',
      name: 'ProfileDisplayEmail',
      desc: '',
      args: [],
    );
  }

  /// `Your Location`
  String get ProfileDisplayLocation {
    return Intl.message(
      'Your Location',
      name: 'ProfileDisplayLocation',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get profileEdit {
    return Intl.message(
      'Edit',
      name: 'profileEdit',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get profileEditName {
    return Intl.message(
      'Name',
      name: 'profileEditName',
      desc: '',
      args: [],
    );
  }

  /// `phone`
  String get profileEditPhone {
    return Intl.message(
      'phone',
      name: 'profileEditPhone',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get profileEditEmail {
    return Intl.message(
      'Email',
      name: 'profileEditEmail',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get profileEditLocation {
    return Intl.message(
      'Location',
      name: 'profileEditLocation',
      desc: '',
      args: [],
    );
  }

  /// `Save Edit`
  String get profileSave {
    return Intl.message(
      'Save Edit',
      name: 'profileSave',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get profileLogout {
    return Intl.message(
      'Log Out',
      name: 'profileLogout',
      desc: '',
      args: [],
    );
  }

  /// `Select From:`
  String get profileBottomSheetSelection {
    return Intl.message(
      'Select From:',
      name: 'profileBottomSheetSelection',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get profileBottomSheetGallery {
    return Intl.message(
      'Gallery',
      name: 'profileBottomSheetGallery',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get profileBottomSheetCamera {
    return Intl.message(
      'Camera',
      name: 'profileBottomSheetCamera',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get favouritesViewAppBarTitle {
    return Intl.message(
      'Favourites',
      name: 'favouritesViewAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `No Favorites Products`
  String get favouritesNoProducts {
    return Intl.message(
      'No Favorites Products',
      name: 'favouritesNoProducts',
      desc: '',
      args: [],
    );
  }

  /// `No Carts Products`
  String get cardsNoProducts {
    return Intl.message(
      'No Carts Products',
      name: 'cardsNoProducts',
      desc: '',
      args: [],
    );
  }

  /// `Carts`
  String get cardViewAppBarTitle {
    return Intl.message(
      'Carts',
      name: 'cardViewAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Total Cost`
  String get cardViewTotalCost {
    return Intl.message(
      'Total Cost',
      name: 'cardViewTotalCost',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get Checkout {
    return Intl.message(
      'Checkout',
      name: 'Checkout',
      desc: '',
      args: [],
    );
  }

  /// `My Cart`
  String get CheckoutViewTitle {
    return Intl.message(
      'My Cart',
      name: 'CheckoutViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get CheckoutSubtotal {
    return Intl.message(
      'Subtotal',
      name: 'CheckoutSubtotal',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Cost`
  String get CheckoutDeliveryCost {
    return Intl.message(
      'Delivery Cost',
      name: 'CheckoutDeliveryCost',
      desc: '',
      args: [],
    );
  }

  /// `Select your Location First`
  String get CheckoutSelectLocation {
    return Intl.message(
      'Select your Location First',
      name: 'CheckoutSelectLocation',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get CheckoutPay {
    return Intl.message(
      'Pay',
      name: 'CheckoutPay',
      desc: '',
      args: [],
    );
  }

  /// `Contact Information`
  String get ContactInformation {
    return Intl.message(
      'Contact Information',
      name: 'ContactInformation',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get ContactInformationName {
    return Intl.message(
      'Name',
      name: 'ContactInformationName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get ContactInformationEmail {
    return Intl.message(
      'Email',
      name: 'ContactInformationEmail',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get ContactInformationPhone {
    return Intl.message(
      'Phone',
      name: 'ContactInformationPhone',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get ContactInformationAddress {
    return Intl.message(
      'Address',
      name: 'ContactInformationAddress',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get productsNum {
    return Intl.message(
      'Items',
      name: 'productsNum',
      desc: '',
      args: [],
    );
  }

  /// `Sale`
  String get productSale {
    return Intl.message(
      'Sale',
      name: 'productSale',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLang {
    return Intl.message(
      'Change Language',
      name: 'changeLang',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
