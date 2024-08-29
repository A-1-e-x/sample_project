import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_project/lang.dart';
import 'package:sample_project/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final locale = await _loadLocale();
  runApp(MyApp(locale: locale));
}

Future<Locale> _loadLocale() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString('language');
    return Locale(languageCode ?? 'en');
  } catch (e) {
    print('Error loading locale: $e');
    return Locale('en');
  }
}

class MyApp extends StatelessWidget {
  final Locale locale;

  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: locale,
      translations: LocalString(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
