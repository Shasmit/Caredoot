// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import '../../../../route/app_pages.dart';
import '../../../../route/custom_navigator.dart';

import '../../../../core/app_imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      CustomNavigator.pushReplace(context, AppPages.dashboardPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppIcons.appLogo,
        ),
      ),
    );
  }
}
