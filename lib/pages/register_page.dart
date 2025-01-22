import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping_client/controller/login_controller.dart';
import 'package:shoping_client/pages/login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(), // Initialize the controller
      builder: (ctrl) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create your Account !!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 20),
                // Name Input Field
                TextField(
                  keyboardType: TextInputType.name,
                  controller: ctrl.registerNameCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'Your Name',
                    hintText: 'Enter your name',
                  ),
                ),
                const SizedBox(height: 20),
                // Mobile Number Input Field
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: ctrl.registerNumberCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.phone_android),
                    labelText: 'Mobile Number',
                    hintText: 'Enter your mobile number',
                  ),
                ),
                const SizedBox(height: 20),
                // Register Button
                ElevatedButton(
                  onPressed: () {
                    ctrl.addUser(); // Register the user
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Register'),
                ),
                const SizedBox(height: 10),
                // Login Button (Navigate to Login Page)
                TextButton(
                  onPressed: () {
                    Get.to(LoginPage()); // Navigate to login page
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
