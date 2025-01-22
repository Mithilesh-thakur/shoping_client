import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/product/product.dart';
import '../model/product_category/product_category.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;

  List<Product> products = [];
  List<Product> productShowInUi = [];
  List<ProductCategory> productCategory = [];

  // Observable for dark mode
  RxBool isDarkMode = false.obs;

  @override
  void onInit() async {
    // Initialize collections
    productCollection = firestore.collection('products');
    categoryCollection = firestore.collection('category');
    await fetchCategory();
    await fetchProducts();
    super.onInit();
  }

  // Fetch products from Firestore
  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedProducts);
      productShowInUi.assignAll(products);  // Initialize UI with all products
      Get.snackbar('Success', 'Products fetched successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  // Fetch categories from Firestore
  fetchCategory() async {
    try {
      QuerySnapshot categorySnapshot = await categoryCollection.get();
      final List<ProductCategory> retrievedCategories = categorySnapshot.docs
          .map((doc) => ProductCategory.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // Add "All" category manually
      productCategory.clear();
      productCategory.add(ProductCategory(name: 'All'));
      productCategory.addAll(retrievedCategories);  // Add all other categories
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  // Filter products by category
  filterByCategory(String category) {
    if (category == 'All' || category.isEmpty) {
      // Show all products when "All" is selected
      productShowInUi.assignAll(products);
    } else {
      // Filter products by category
      productShowInUi = products.where((product) => product.category == category).toList();
    }
    update();
  }

  // Filter products by selected brands
  filterByBrand(List<String> brands) {
    if (brands.isEmpty) {
      // If no brands are selected, show all products
      productShowInUi = products;
    } else {
      // Convert brand names to lowercase for case-insensitive matching
      List<String> lowerCaseBrands = brands.map((brand) => brand.toLowerCase()).toList();

      // Filter products by matching the brand (if not null) with the selected brands
      productShowInUi = products.where((product) =>
      product.brand != null &&
          lowerCaseBrands.contains(product.brand!.toLowerCase())).toList();
    }
    update();
  }

  // Sort products by price in ascending or descending order
  sortByPrice(bool, {required bool ascending}) {
    List<Product> sortedProducts = List<Product>.from(productShowInUi);
    sortedProducts.sort((a, b) => ascending ? a.price!.compareTo(b.price!) : b.price!.compareTo(a.price!));
    productShowInUi = sortedProducts;
    update();
  }

  // Toggle between dark mode and light mode
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(
      isDarkMode.value ? ThemeData.dark() : ThemeData.light(),
    );
  }
}
