import 'package:auto_route/annotations.dart';
import 'package:idify/views/about.dart';
import 'package:idify/views/bank_acc.dart';
import 'package:idify/views/driver_license.dart';
import 'package:idify/views/forget_password.dart';
import 'package:idify/views/live_chat_view.dart';
import 'package:idify/views/profile.dart';
import 'package:idify/views/qr_scanner.dart';
import 'package:idify/views/reglocations.dart';
import 'package:idify/views/servey.dart';
import 'package:idify/views/test.dart';
import '../ui/view/HomeDetailView.dart';
import '../views/add_card.dart';
import '../views/home_view.dart';
import '../views/on_boarding/on_boarding.dart';
import '../views/sign_in.dart';
import '../views/user_account/user_account.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SignIn, initial: true, path: "/"),
    // AutoRoute(page: HomeDetailView, path: "/detail"),
    // AutoRoute(page: SignIn, path: "/SignIn"),
    AutoRoute(page: HomeDetailView, path: "/detail/:id"),
    AutoRoute(page: OnBoarding, path: "/OnBoarding"),
    AutoRoute(page: HomeView, path: "/HomeView/:jsondata"),
    AutoRoute(page: UserAccount, path: "/UserAccount/:user_data"),
    // AutoRoute(page: AddCard, path: "/AddCard"),
    AutoRoute(page: AddCard, path: "/AddCard"),
    AutoRoute(page: Profile, path: "/Profile"),
    AutoRoute(page: DriverLicense, path: "/DriverLicense"),
    AutoRoute(page: LiveChatView, path: "/LiveChatView"),
    AutoRoute(page: About, path: "/About"),
    AutoRoute(page: QRScanner, path: "/QRScanner"),
    AutoRoute(page: BankAccounts, path: "/Bankacc"),
    AutoRoute(page: RegLocations, path: "/RegLocations"),
    AutoRoute(page: SurveyForm, path: "/SurveyForm"),
    AutoRoute(page: Survey, path: "/Survey"),
    AutoRoute(
      page: ForgetPassword,
      path: "/ForgetPassword",
    ),
  ],
)
class $AppRouter {}
