import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
  void addToCart(Map<String, dynamic> product) {
    int index = cartItems.indexWhere((item) => item["name"] == product["name"]);
    int inComingQty = product["qty"] ?? 1;
    if (index >= 0) {
      cartItems[index]["qty"] += inComingQty;
      cartItems.refresh();
    } else {
      product["qty"] = inComingQty;
      cartItems.add(product);
    }
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
  }

  void addQuantity(int index) {
    cartItems[index]["qty"]++;
    cartItems.refresh();
  }

  void decreaseQuantity(int index) {
    if (cartItems[index]["qty"] > 1) {
      cartItems[index]["qty"]--;
      cartItems.refresh();
    }
  }

  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) {
      double price = double.tryParse(item["price"].toString().replaceAll("\$", "")) ?? 0.0;
      return sum + (price * item["qty"]);
    });
  }
}
