import 'package:caredoot/features/home/data/models/cart_model.dart';
import 'package:flutter/services.dart';
import '../../ui/injection_container.dart' as di;
import '../../ui/cart_init.dart' as cart;

import '../helpers/local_dp_helper.dart';
import 'shared_preference_manager.dart';

class AppManager {
  static Future<void> initialize() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await LocalDatabaseHelper.initialize();
    await SharedPreferencesManager.init();
    await di.init();
    await cart.init();
  }
}
