// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;

import '../ui/view/HomeDetailView.dart' as _i2;
import '../views/about.dart' as _i10;
import '../views/add_card.dart' as _i6;
import '../views/bank_acc.dart' as _i12;
import '../views/driver_license.dart' as _i8;
import '../views/forget_password.dart' as _i16;
import '../views/home_view.dart' as _i4;
import '../views/live_chat_view.dart' as _i9;
import '../views/on_boarding/on_boarding.dart' as _i3;
import '../views/profile.dart' as _i7;
import '../views/qr_scanner.dart' as _i11;
import '../views/reglocations.dart' as _i13;
import '../views/servey.dart' as _i15;
import '../views/sign_in.dart' as _i1;
import '../views/test.dart' as _i14;
import '../views/user_account/user_account.dart' as _i5;

class AppRouter extends _i17.RootStackRouter {
  AppRouter([_i18.GlobalKey<_i18.NavigatorState> navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    SignIn.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SignIn(),
      );
    },
    HomeDetailView.name: (routeData) {
      final args = routeData.argsAs<HomeDetailViewArgs>(
          orElse: () => const HomeDetailViewArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.HomeDetailView(
          key: args.key,
          id: args.id,
        ),
      );
    },
    OnBoarding.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.OnBoarding(),
      );
    },
    HomeView.name: (routeData) {
      final args =
          routeData.argsAs<HomeViewArgs>(orElse: () => const HomeViewArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.HomeView(
          key: args.key,
          jsonData: args.jsonData,
          isAuthority: args.isAuthority,
        ),
      );
    },
    UserAccount.name: (routeData) {
      final args = routeData.argsAs<UserAccountArgs>(
          orElse: () => const UserAccountArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.UserAccount(
          key: args.key,
          userdata: args.userdata,
        ),
      );
    },
    AddCard.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.AddCard(),
      );
    },
    Profile.name: (routeData) {
      final args =
          routeData.argsAs<ProfileArgs>(orElse: () => const ProfileArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.Profile(
          key: args.key,
          jsonData: args.jsonData,
          isAuthority: args.isAuthority,
        ),
      );
    },
    DriverLicense.name: (routeData) {
      final args = routeData.argsAs<DriverLicenseArgs>(
          orElse: () => const DriverLicenseArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.DriverLicense(
          key: args.key,
          jsonData: args.jsonData,
        ),
      );
    },
    LiveChatView.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.LiveChatView(),
      );
    },
    About.name: (routeData) {
      final args = routeData.argsAs<AboutArgs>(orElse: () => const AboutArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.About(
          key: args.key,
          uid: args.uid,
        ),
      );
    },
    QRScanner.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.QRScanner(),
      );
    },
    BankAccounts.name: (routeData) {
      final args = routeData.argsAs<BankAccountsArgs>(
          orElse: () => const BankAccountsArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.BankAccounts(
          key: args.key,
          uid: args.uid,
        ),
      );
    },
    RegLocations.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.RegLocations(),
      );
    },
    SurveyForm.name: (routeData) {
      final args = routeData.argsAs<SurveyFormArgs>(
          orElse: () => const SurveyFormArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.SurveyForm(key: args.key),
      );
    },
    Survey.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.Survey(),
      );
    },
    ForgetPassword.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.ForgetPassword(),
      );
    },
  };

  @override
  List<_i17.RouteConfig> get routes => [
        _i17.RouteConfig(
          SignIn.name,
          path: '/',
        ),
        _i17.RouteConfig(
          HomeDetailView.name,
          path: '/detail/:id',
        ),
        _i17.RouteConfig(
          OnBoarding.name,
          path: '/OnBoarding',
        ),
        _i17.RouteConfig(
          HomeView.name,
          path: '/HomeView/:jsondata',
        ),
        _i17.RouteConfig(
          UserAccount.name,
          path: '/UserAccount/:user_data',
        ),
        _i17.RouteConfig(
          AddCard.name,
          path: '/AddCard',
        ),
        _i17.RouteConfig(
          Profile.name,
          path: '/Profile',
        ),
        _i17.RouteConfig(
          DriverLicense.name,
          path: '/DriverLicense',
        ),
        _i17.RouteConfig(
          LiveChatView.name,
          path: '/LiveChatView',
        ),
        _i17.RouteConfig(
          About.name,
          path: '/About',
        ),
        _i17.RouteConfig(
          QRScanner.name,
          path: '/QRScanner',
        ),
        _i17.RouteConfig(
          BankAccounts.name,
          path: '/Bankacc',
        ),
        _i17.RouteConfig(
          RegLocations.name,
          path: '/RegLocations',
        ),
        _i17.RouteConfig(
          SurveyForm.name,
          path: '/SurveyForm',
        ),
        _i17.RouteConfig(
          Survey.name,
          path: '/Survey',
        ),
        _i17.RouteConfig(
          ForgetPassword.name,
          path: '/ForgetPassword',
        ),
      ];
}

/// generated route for
/// [_i1.SignIn]
class SignIn extends _i17.PageRouteInfo<void> {
  const SignIn()
      : super(
          SignIn.name,
          path: '/',
        );

  static const String name = 'SignIn';
}

/// generated route for
/// [_i2.HomeDetailView]
class HomeDetailView extends _i17.PageRouteInfo<HomeDetailViewArgs> {
  HomeDetailView({
    _i18.Key key,
    int id,
  }) : super(
          HomeDetailView.name,
          path: '/detail/:id',
          args: HomeDetailViewArgs(
            key: key,
            id: id,
          ),
        );

  static const String name = 'HomeDetailView';
}

class HomeDetailViewArgs {
  const HomeDetailViewArgs({
    this.key,
    this.id,
  });

  final _i18.Key key;

  final int id;

  @override
  String toString() {
    return 'HomeDetailViewArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i3.OnBoarding]
class OnBoarding extends _i17.PageRouteInfo<void> {
  const OnBoarding()
      : super(
          OnBoarding.name,
          path: '/OnBoarding',
        );

  static const String name = 'OnBoarding';
}

/// generated route for
/// [_i4.HomeView]
class HomeView extends _i17.PageRouteInfo<HomeViewArgs> {
  HomeView({
    _i18.Key key,
    List<dynamic> jsonData,
    bool isAuthority,
  }) : super(
          HomeView.name,
          path: '/HomeView/:jsondata',
          args: HomeViewArgs(
            key: key,
            jsonData: jsonData,
            isAuthority: isAuthority,
          ),
        );

  static const String name = 'HomeView';
}

class HomeViewArgs {
  const HomeViewArgs({
    this.key,
    this.jsonData,
    this.isAuthority,
  });

  final _i18.Key key;

  final List<dynamic> jsonData;

  final bool isAuthority;

  @override
  String toString() {
    return 'HomeViewArgs{key: $key, jsonData: $jsonData, isAuthority: $isAuthority}';
  }
}

/// generated route for
/// [_i5.UserAccount]
class UserAccount extends _i17.PageRouteInfo<UserAccountArgs> {
  UserAccount({
    _i18.Key key,
    List<dynamic> userdata,
  }) : super(
          UserAccount.name,
          path: '/UserAccount/:user_data',
          args: UserAccountArgs(
            key: key,
            userdata: userdata,
          ),
        );

  static const String name = 'UserAccount';
}

class UserAccountArgs {
  const UserAccountArgs({
    this.key,
    this.userdata,
  });

  final _i18.Key key;

  final List<dynamic> userdata;

  @override
  String toString() {
    return 'UserAccountArgs{key: $key, userdata: $userdata}';
  }
}

/// generated route for
/// [_i6.AddCard]
class AddCard extends _i17.PageRouteInfo<void> {
  const AddCard()
      : super(
          AddCard.name,
          path: '/AddCard',
        );

  static const String name = 'AddCard';
}

/// generated route for
/// [_i7.Profile]
class Profile extends _i17.PageRouteInfo<ProfileArgs> {
  Profile({
    _i18.Key key,
    List<dynamic> jsonData,
    bool isAuthority,
  }) : super(
          Profile.name,
          path: '/Profile',
          args: ProfileArgs(
            key: key,
            jsonData: jsonData,
            isAuthority: isAuthority,
          ),
        );

  static const String name = 'Profile';
}

class ProfileArgs {
  const ProfileArgs({
    this.key,
    this.jsonData,
    this.isAuthority,
  });

  final _i18.Key key;

  final List<dynamic> jsonData;

  final bool isAuthority;

  @override
  String toString() {
    return 'ProfileArgs{key: $key, jsonData: $jsonData, isAuthority: $isAuthority}';
  }
}

/// generated route for
/// [_i8.DriverLicense]
class DriverLicense extends _i17.PageRouteInfo<DriverLicenseArgs> {
  DriverLicense({
    _i18.Key key,
    List<dynamic> jsonData,
  }) : super(
          DriverLicense.name,
          path: '/DriverLicense',
          args: DriverLicenseArgs(
            key: key,
            jsonData: jsonData,
          ),
        );

  static const String name = 'DriverLicense';
}

class DriverLicenseArgs {
  const DriverLicenseArgs({
    this.key,
    this.jsonData,
  });

  final _i18.Key key;

  final List<dynamic> jsonData;

  @override
  String toString() {
    return 'DriverLicenseArgs{key: $key, jsonData: $jsonData}';
  }
}

/// generated route for
/// [_i9.LiveChatView]
class LiveChatView extends _i17.PageRouteInfo<void> {
  const LiveChatView()
      : super(
          LiveChatView.name,
          path: '/LiveChatView',
        );

  static const String name = 'LiveChatView';
}

/// generated route for
/// [_i10.About]
class About extends _i17.PageRouteInfo<AboutArgs> {
  About({
    _i18.Key key,
    String uid,
  }) : super(
          About.name,
          path: '/About',
          args: AboutArgs(
            key: key,
            uid: uid,
          ),
        );

  static const String name = 'About';
}

class AboutArgs {
  const AboutArgs({
    this.key,
    this.uid,
  });

  final _i18.Key key;

  final String uid;

  @override
  String toString() {
    return 'AboutArgs{key: $key, uid: $uid}';
  }
}

/// generated route for
/// [_i11.QRScanner]
class QRScanner extends _i17.PageRouteInfo<void> {
  const QRScanner()
      : super(
          QRScanner.name,
          path: '/QRScanner',
        );

  static const String name = 'QRScanner';
}

/// generated route for
/// [_i12.BankAccounts]
class BankAccounts extends _i17.PageRouteInfo<BankAccountsArgs> {
  BankAccounts({
    _i18.Key key,
    String uid,
  }) : super(
          BankAccounts.name,
          path: '/Bankacc',
          args: BankAccountsArgs(
            key: key,
            uid: uid,
          ),
        );

  static const String name = 'BankAccounts';
}

class BankAccountsArgs {
  const BankAccountsArgs({
    this.key,
    this.uid,
  });

  final _i18.Key key;

  final String uid;

  @override
  String toString() {
    return 'BankAccountsArgs{key: $key, uid: $uid}';
  }
}

/// generated route for
/// [_i13.RegLocations]
class RegLocations extends _i17.PageRouteInfo<void> {
  const RegLocations()
      : super(
          RegLocations.name,
          path: '/RegLocations',
        );

  static const String name = 'RegLocations';
}

/// generated route for
/// [_i14.SurveyForm]
class SurveyForm extends _i17.PageRouteInfo<SurveyFormArgs> {
  SurveyForm({_i18.Key key})
      : super(
          SurveyForm.name,
          path: '/SurveyForm',
          args: SurveyFormArgs(key: key),
        );

  static const String name = 'SurveyForm';
}

class SurveyFormArgs {
  const SurveyFormArgs({this.key});

  final _i18.Key key;

  @override
  String toString() {
    return 'SurveyFormArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.Survey]
class Survey extends _i17.PageRouteInfo<void> {
  const Survey()
      : super(
          Survey.name,
          path: '/Survey',
        );

  static const String name = 'Survey';
}

/// generated route for
/// [_i16.ForgetPassword]
class ForgetPassword extends _i17.PageRouteInfo<void> {
  const ForgetPassword()
      : super(
          ForgetPassword.name,
          path: '/ForgetPassword',
        );

  static const String name = 'ForgetPassword';
}
