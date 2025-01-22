import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoping_client/controller/home_controller.dart';
import 'package:shoping_client/controller/login_controller.dart';
import 'package:shoping_client/pages/home_page.dart';
import 'package:shoping_client/pages/login_page.dart';
import 'package:shoping_client/pages/register_page.dart';
import 'firebase_option.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  Get.put(LoginController()); // Initialize the LoginController
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shopping App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor:Colors.blue ,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black),
        ),

        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        appBarTheme: AppBarTheme(backgroundColor:Colors.grey[850], iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white),),

      ),
      themeMode: ThemeMode.system,
      // Add initial route based on user authentication state
      home: LoginPage(),
    );
  }
}
