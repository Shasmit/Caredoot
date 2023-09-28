import 'package:caredoot/features/bookings/presentation/pages/booking_page.dart';
import 'package:caredoot/features/cart/presentation/pages/add_address_page.dart';
import 'package:caredoot/features/cart/presentation/pages/cart_page.dart';
import 'package:caredoot/features/cart/presentation/pages/select_slot_page.dart';
import 'package:caredoot/features/cart/presentation/pages/summary_page.dart';
import 'package:caredoot/features/home/presentation/pages/home_page.dart';
import 'package:caredoot/features/onboarding/presentation/pages/login_page.dart';
import 'package:caredoot/features/onboarding/presentation/pages/splash.dart';
import 'package:caredoot/features/onboarding/presentation/pages/verify_otp_page.dart';
import 'package:caredoot/features/profile/presentation/pages/coins_page.dart';

import '../core/app_imports.dart';
import '../features/bookings/presentation/pages/booking_details.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/home/presentation/pages/services_page.dart';
import '../features/home/presentation/pages/sub_service_page.dart';
import 'app_pages.dart';

final kNavigatorKey = GlobalKey<NavigatorState>();

class CustomNavigator {
  static Route<dynamic> controller(RouteSettings settings) {
    //use settings.arguments to pass arguments in pages
    switch (settings.name) {
      case AppPages.appEntry:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
      case AppPages.login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
          settings: settings,
        );
      case AppPages.verifyOtp:
        return MaterialPageRoute(
          builder: (context) => VerifyOtpPage(
            arguments: settings.arguments as Map<String, dynamic>,
          ),
          settings: settings,
        );
      case AppPages.dashboardPage:
        return MaterialPageRoute(
          builder: (context) => const DashboardPage(),
          settings: settings,
        );
      case AppPages.homePage:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
          settings: settings,
        );
      case AppPages.servicesPage:
        return MaterialPageRoute(
          builder: (context) => ServicesPage(
            arguments: settings.arguments as Map<String, dynamic>,
          ),
          settings: settings,
        );
      case AppPages.subServicePage:
        return MaterialPageRoute(
          builder: (context) => SubServicePage(
            arguements: settings.arguments as Map<String, dynamic>,
          ),
          settings: settings,
        );

      case AppPages.cartPage:
        return MaterialPageRoute(
          builder: (context) => const CartPage(),
          settings: settings,
        );
      case AppPages.addAddressPage:
        return MaterialPageRoute(
          builder: (context) => const AddAddressPage(),
          settings: settings,
        );
      case AppPages.selectSlotPage:
        return MaterialPageRoute(
          builder: (context) => const SelectSlotPage(),
          settings: settings,
        );
      case AppPages.summaryPage:
        return MaterialPageRoute(
          builder: (context) => const SummaryPage(),
          settings: settings,
        );
      case AppPages.bookingPage:
        return MaterialPageRoute(
          builder: (context) => const BookingsPageEmpty(),
          settings: settings,
        );
      case AppPages.bookingDetails:
        return MaterialPageRoute(
          builder: (context) => const BookingDetails(),
          settings: settings,
        );
      case AppPages.coinsPage:
        return MaterialPageRoute(
            builder: (context) => const CoinsPage(
                // arguements: settings.arguments as Map<String, dynamic>,
                ));
      default:
        throw ('This route name does not exit');
    }
  }

  // Pushes to the route specified
  static Future<T?> pushTo<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.of(context, rootNavigator: true)
        .pushNamed(strPageName, arguments: arguments);
  }

  // Pop the top view
  static void pop(BuildContext context, {Object? result}) {
    Navigator.pop(context, result);
  }

  // Pops to a particular view
  static Future<T?> popTo<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.popAndPushNamed(
      context,
      strPageName,
      arguments: arguments,
    );
  }

  static void popUntilFirst(BuildContext context) {
    Navigator.popUntil(context, (page) => page.isFirst);
  }

  static void popUntilRoute(BuildContext context, String route, {var result}) {
    Navigator.popUntil(context, (page) {
      if (page.settings.name == route && page.settings.arguments != null) {
        (page.settings.arguments as Map<String, dynamic>)["result"] = result;
        return true;
      }
      return false;
    });
  }

  static Future<T?> pushReplace<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.pushReplacementNamed(
      context,
      strPageName,
      arguments: arguments,
    );
  }
}
