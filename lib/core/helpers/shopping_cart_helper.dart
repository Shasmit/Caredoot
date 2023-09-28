import 'package:caredoot/features/home/data/models/cart_model.dart';
import 'package:caredoot/main.dart';

class ShoppingCartHelper {
  static addToCart(CartItem item) {
    shoppingCartBox.put(item.itemId, item);
  }

  static updateItem(String itemId, int qty) async {
    if (qty > 0) {
      final cartItems = await ShoppingCartHelper.getCart();
      print(cartItems);
      final item = shoppingCartBox.get(itemId);
      if (item != null) {
        item.qty = qty;
        item.save();
      }
    } else {
      removeFromCart(itemId);
    }
  }

  static getCart() {
    return shoppingCartBox.values.toList();
  }

  static removeFromCart(String itemId) {
    shoppingCartBox.delete(itemId);
  }

  static deleteCart() {
    shoppingCartBox.clear();
  }
}
