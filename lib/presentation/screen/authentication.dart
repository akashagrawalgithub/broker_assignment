import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'home.dart';

class UserLogin extends StatefulWidget {
  final String logo;
  final String name;
  const UserLogin({super.key, required this.logo, required this.name});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  bool isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> _simulateLogin(
    String username,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    bool isValidCredentials =
        username == '${widget.name.toLowerCase()}_123' &&
        password == '${widget.name.toLowerCase()}123';
    final random = Random();
    final probability = random.nextDouble();

    if (!isValidCredentials) {
      return {'status': 400, 'message': 'Invalid credentials'};
    }
    if (probability < 0.7) {
      return {'status': 200, 'message': 'Login successful'};
    } else if (probability < 0.9) {
      return {'status': 400, 'message': 'Invalid credentials'};
    } else {
      return {'status': 500, 'message': 'Server error, please try again later'};
    }
  }

  void _handleLogin() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter both username and password',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await _simulateLogin(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      switch (response['status']) {
        case 200:
          Get.snackbar(
            'Success',
            'Login successful',
            backgroundColor: Colors.green.shade100,
            colorText: Colors.green.shade900,
            snackPosition: SnackPosition.TOP,
          );
          Get.off(() => const HomeScreen());
          break;
        case 400:
          Get.snackbar(
            'Error',
            response['message'],
            backgroundColor: Colors.red.shade100,
            colorText: Colors.red.shade900,
            snackPosition: SnackPosition.TOP,
          );
          break;
        case 500:
          Get.snackbar(
            'Error',
            response['message'],
            backgroundColor: Colors.orange.shade100,
            colorText: Colors.orange.shade900,
            snackPosition: SnackPosition.TOP,
          );
          break;
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(widget.logo, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Login to ${widget.name}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                "Enter your credentials to continue",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 36),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText:
                      "Enter username (e.g. ${widget.name.toLowerCase()}_123)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                  prefixIcon: const Icon(
                    Icons.person_outline_rounded,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText:
                      "Enter password (e.g. ${widget.name.toLowerCase()}123)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007AFF),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:
                      isLoading
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Logging in...',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                          : const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: const Text(
                    'Back to Broker',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
