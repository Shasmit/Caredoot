import 'package:caredoot/features/home/data/models/cart_model.dart';
import 'package:caredoot/main.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalDatabaseHelper {
  static Future<void> initialize() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(CartItemAdapter());
    shoppingCartBox = await Hive.openBox<CartItem>('cartItem');
  }

  static Box<CartItem> getData() => Hive.box<CartItem>('cartItem');
}
