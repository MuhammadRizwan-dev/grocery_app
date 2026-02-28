import 'package:get/get.dart';

class FavouriteController extends GetxController {
  var favouriteItems = <Map<String, dynamic>>[].obs;
  void toggleFavourite(Map<String, dynamic> product) {
    int index = favouriteItems.indexWhere(
      (item) => item["name"] == product["name"],
    );
    if (index > 0) {
      favouriteItems.removeAt(index);
    } else {
      favouriteItems.add(product);
    }
  }

  bool isFavourite(String name) {
    return favouriteItems.any((item) => item["name"] == name);
  }
}
