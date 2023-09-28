import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/core/loaded_widget.dart';
import 'package:caredoot/features/home/data/models/cart_model.dart';
import 'package:caredoot/features/onboarding/presentation/pages/splash.dart';
import 'package:caredoot/route/custom_navigator.dart';
import 'package:hive/hive.dart';

import 'core/managers/app_manager.dart';

late Box<CartItem> shoppingCartBox;
List<CartItemModel> cart = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          const Size(VALUE_FIGMA_DESIGN_WIDTH, VALUE_FIGMA_DESIGN_HEIGHT),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CareDoot',
        initialRoute: '/',
        onGenerateRoute: CustomNavigator.controller,
        themeMode: ThemeMode.light,
        builder: OverlayManager.transitionBuilder(),
        theme: AppThemes.light,
        home: const SplashScreen(),
      ),
    );
  }
}
