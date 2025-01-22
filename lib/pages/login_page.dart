import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping_client/controller/login_controller.dart';
import 'package:shoping_client/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the LoginController
    return GetBuilder<LoginController>(
      init: LoginController(),
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
                  'Login to your Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.deepPurple,
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
                // Login Button
                ElevatedButton(
                  onPressed: () {
                    // Trigger the login function
                    ctrl.login(); // Changed method name
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(height: 10),
                // Navigate to Register Page
                TextButton(
                  onPressed: () {
                    Get.to(() => const RegisterPage()); // Navigate to RegisterPage
                  },
                  child: const Text('Register new account'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
