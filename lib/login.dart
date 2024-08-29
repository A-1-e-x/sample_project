import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_project/db_functions/functions.dart';
import 'package:sample_project/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String userName = 'user';
  String passWord = '12345';

  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _saveChanges();
  }

  Future<void> _saveChanges() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? 'user';
      passWord = prefs.getString('password') ?? '12345';
    });
  }

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 241, 234, 255), // Light background color
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 202, 142, 255), // AppBar color
          title: Text(
            'LoGrO',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Color.fromARGB(255, 255, 255, 255), // App title color
            ),
          ),
          centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task_alt,
              size: 80,
              color: Color.fromARGB(255, 63, 0, 158), // Icon color
            ),
            SizedBox(height: 20),
            Text(
              'Login'.tr,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 63, 0, 158), // Login text color
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: userNameController,
                decoration: InputDecoration(
                  hintText: "Enter your User Name".tr,
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  fillColor: Color.fromARGB(
                      255, 241, 234, 255), // TextField background color
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: passWordController,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  hintText: "Enter your Password".tr,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  fillColor: Color.fromARGB(
                      255, 241, 234, 255), // TextField background color
                  filled: true,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final enteredUserName = userNameController.text;
                final enteredPassword = passWordController.text;
                print(userNameController.text);
                print(passWordController.text);
                if (userName == enteredUserName &&
                    passWord == enteredPassword) {
                  await saveBoolData(true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                } else {
                  final snackBar = SnackBar(
                    content: Text('Invalid Credentials'),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text(
                'Login'.tr,
                style: TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 208, 162, 247)), // Button color
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
