import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _saveChanges() async {
    if (_formKey.currentState?.validate() ?? false) {
      final newUsername = _usernameController.text;
      final newPassword = _passwordController.text;

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('username', newUsername);
      await prefs.setString('password', newPassword);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 234, 255),
      appBar: AppBar(
        title: Text('Profile'.tr),
        backgroundColor: Color.fromARGB(255, 208, 162, 247),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username'.tr,
                  labelStyle: TextStyle(color: Colors.black), // Label color
                  filled: true,
                  fillColor:
                      Color.fromARGB(255, 229, 212, 255), // Background color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded borders
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color:
                            Color.fromARGB(255, 220, 191, 255)), // Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Color.fromARGB(
                            255, 208, 162, 247)), // Focused border color
                  ),
                ),
                style: TextStyle(color: Colors.black), // Text color
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new username'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'New Password'.tr,
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor:
                      Color.fromARGB(255, 229, 212, 255), // Background color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 220, 191, 255)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 208, 162, 247)),
                  ),
                ),
                obscureText: true,
                style: TextStyle(color: Colors.black),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password'.tr,
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor:
                      Color.fromARGB(255, 229, 212, 255), // Background color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 220, 191, 255)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 208, 162, 247)),
                  ),
                ),
                obscureText: true,
                style: TextStyle(color: Colors.black),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text('Save Changes'.tr),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 208, 162, 247),
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
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
