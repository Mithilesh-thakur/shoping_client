import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoping_client/controller/home_controller.dart';
import 'package:shoping_client/pages/login_page.dart';
import 'package:shoping_client/pages/product_description_page.dart';
import 'package:shoping_client/widgets/drop_down_btn.dart';
import 'package:shoping_client/widgets/multi_select_drop_down.dart';
import 'package:shoping_client/widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (ctrl) {
        return RefreshIndicator(
          onRefresh: () async {
            await ctrl.fetchProducts(); // Trigger refresh of product data
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Get.isDarkMode ? Colors.grey[850] : Colors.white,
              elevation: 1,
              title: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Products',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Get.isDarkMode ? Colors.grey[800] : Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    GetStorage box = GetStorage();
                    box.erase(); // Clear the storage and log out
                    Get.offAll(LoginPage());
                  },
                  icon: Icon(Icons.person, color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
                IconButton(
                  onPressed: ctrl.toggleTheme, // Toggle theme
                  icon: Icon(
                    Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                // Category filter chips with "All" option
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ctrl.productCategory.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ctrl.filterByCategory(
                            ctrl.productCategory[index].name ?? '',
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                          child: Chip(
                            backgroundColor: Get.isDarkMode ? Colors.grey[700] : Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            label: Text(
                              ctrl.productCategory[index].name ?? 'Error',
                              style: TextStyle(
                                color: Get.isDarkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Sorting and filters
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: DropDownBtn(
                          items: const ['Rs: Low to High', 'Rs: High to Low'],
                          selectedItemText: 'Sort',
                          onSelected: (selected) {
                            ctrl.sortByPrice(bool, ascending: selected == 'Rs: Low to High');
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: MultiSelectDropDown(
                          items: const ['Sketchers', 'Adidas', 'Puma', 'Clarks'],
                          onSelectionChanged: (selectedItems) {
                            ctrl.filterByBrand(selectedItems); // Filter by brand
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Product grid
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: ctrl.productShowInUi.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        name: ctrl.productShowInUi[index].name ?? 'No name',
                        imgUrl: ctrl.productShowInUi[index].image ?? 'url',
                        price: ctrl.productShowInUi[index].price ?? 0,
                        offerTag: '30% off',
                        onTap: () {
                          Get.to(
                            ProductDescriptionPage(
                              product: ctrl.productShowInUi[index], // Pass the actual product object
                            ),
                            arguments: {'data': ctrl.productShowInUi[index]},
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
