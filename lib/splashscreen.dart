import 'package:flutter/material.dart';
import 'package:sample_project/db_functions/functions.dart';
import 'package:sample_project/home.dart';
import 'package:sample_project/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    nextpage();
  }

  Future<void> nextpage() async {
    await Future.delayed(Duration(seconds: 2));
    var result = await getBooldata();
    if (result == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color.fromARGB(255, 233, 208, 255),
      child: Center(
        child: Image.asset(
          '\LOGRO.png',
          height: 130,
        ),
      ),
    ));
  }
}
