import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class UserProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var firebaseProducts = <ProductModel>[].obs;

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() {
    try {
      isLoading(true);
      _firestore.collection('products').snapshots().listen((snapshot) {
        firebaseProducts.value = snapshot.docs.map((doc) {
          return ProductModel.fromMap(doc.data(), doc.id);
        }).toList();

        isLoading(false);
      });
    } catch (e) {
      isLoading(false);
      print("Error fetching products: $e");
    }
  }
}