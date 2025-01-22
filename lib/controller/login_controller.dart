import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get_storage/get_storage.dart';
import 'package:shoping_client/model/user/user.dart';
import 'package:shoping_client/pages/home_page.dart';

class LoginController extends GetxController {
  GetStorage box = GetStorage(); // Local storage instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;
  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerNumberCtrl = TextEditingController();

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  User? loginUser;

  @override
  void onReady() {
    Map<String, dynamic>? user = box.read('loginUser');
    if (user != null) {
      loginUser = User.fromJson(user);
      Get.to(HomePage());
    }
    super.onReady();
  }

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  // Add user to Firestore
  addUser() async {
    try {
      if (registerNameCtrl.text.isEmpty || registerNumberCtrl.text.isEmpty) {
        Get.snackbar('Error', 'Please fill in all fields', colorText: Colors.red);
        return;
      }

      // Check if user already exists
      var usersSnapshot = await userCollection
          .where('number', isEqualTo: int.tryParse(registerNumberCtrl.text))
          .get();

      if (usersSnapshot.docs.isNotEmpty) {
        Get.snackbar('Error', 'User already exists. Please log in.', colorText: Colors.red);
        return;
      }

      // Add user to Firestore
      DocumentReference doc = userCollection.doc();
      User user = User(
        id: doc.id,
        name: registerNameCtrl.text,
        number: int.tryParse(registerNumberCtrl.text),
      );
      final userJson = user.toJson();
      await doc.set(userJson);

      Get.snackbar('Success', 'User registered successfully', colorText: Colors.green);
      registerNameCtrl.clear();
      registerNumberCtrl.clear();
    } catch (e) {
      Get.snackbar('Error', 'Registration failed', colorText: Colors.red);
      print(e);
    }
  }

  // Login user using phone number and store the login data in GetStorage
  login() async {
    try {
      if (registerNumberCtrl.text.isEmpty) {
        Get.snackbar('Error', 'Please enter your phone number', colorText: Colors.red);
        return;
      }

      // Check if user exists
      var usersSnapshot = await userCollection
          .where('number', isEqualTo: int.tryParse(registerNumberCtrl.text))
          .get();

      if (usersSnapshot.docs.isEmpty) {
        Get.snackbar('Error', 'User does not exist. Please register.', colorText: Colors.red);
        return;
      }

      // User exists, store the login information in GetStorage
      var userData = usersSnapshot.docs.first.data() as Map<String, dynamic>; // Cast to Map
      box.write('loginUser', {
        'id': userData['id'],
        'name': userData['name'],
        'number': userData['number'],
      });
      Get.to(HomePage());
      Get.snackbar('Success', 'Login successful', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', 'Login failed', colorText: Colors.red);
      print(e);
    }
  }

  // Function to retrieve stored login data
  Map<String, dynamic>? getStoredLoginData() {
    return box.read('loginUser');
  }

  // Function to check if the user is logged in
  bool isUserLoggedIn() {
    return box.hasData('loginUser');
  }

  // Function to clear stored login data (logout)
  void logoutUser() {
    box.remove('loginUser');
    Get.snackbar('Success', 'Logged out successfully', colorText: Colors.green);
  }
}
