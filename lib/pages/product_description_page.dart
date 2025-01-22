import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping_client/model/product/product.dart';
class ProductDescriptionPage extends StatelessWidget {
  const ProductDescriptionPage({super.key, required Product product});

  @override
  Widget build(BuildContext context) {
    Product product=Get.arguments['data'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.image??'',fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
              
            ),
            SizedBox(height: 20,),
            Text(product.name??'',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20,),
            Text(product.description??'',
              style: TextStyle(fontSize: 16,height: 1.5),
            ),
            SizedBox(height: 20,),
            Text('Rs: ${product.price??''}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                labelText: 'Enter Your Billing Address'
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.indigo
                ),
                  onPressed: (){},
                  child: Text('Buy Now',
                  style: TextStyle(fontSize: 18,color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }
}
