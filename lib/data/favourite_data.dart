List<Map<String, dynamic>> favouriteItems = [];
void toggleFavorite(Map<String, dynamic> product) {
  bool isAlreadyFav = favouriteItems.any(
    (item) => item["name"] == product["name"],
  );

  if (isAlreadyFav) {
    favouriteItems.removeWhere((item) => item["name"] == product["name"]);
  } else {
    favouriteItems.add(product);
  }
}
