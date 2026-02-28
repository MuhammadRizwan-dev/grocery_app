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
    double total = 0;
    for (var item in cartItems) {
      double price = double.parse(
        item["price"].toString().replaceAll("\$", ""),
      );
      total += price* item["qty"];
    }
    return total;
  }
}
