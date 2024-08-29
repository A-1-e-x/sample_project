import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_project/db_functions/functions.dart';
import 'package:sample_project/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Settings'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 208, 162, 247), // AppBar color
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Icon(Icons.language,
                  color: Color.fromARGB(255, 208, 162, 247)),
            ),
            title: Text(
              "Language Preference".tr,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            tileColor:
                Color.fromARGB(255, 241, 234, 255), // Tile background color
            onTap: () {
              _showLanguageDialog(context);
            },
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Icon(Icons.logout_outlined,
                  color: Color.fromARGB(255, 208, 162, 247)),
            ),
            title: Text(
              "Logout".tr,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            tileColor:
                Color.fromARGB(255, 241, 234, 255), // Tile background color
            onTap: () {
              _logout(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Your Language'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('English'),
                onTap: () {
                  Navigator.of(context).pop();
                  _updateLanguage(context, 'en', 'English');
                },
              ),
              ListTile(
                title: Text('മലയാളം'),
                onTap: () {
                  Navigator.of(context).pop();
                  _updateLanguage(context, 'ml', 'Malayalam');
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateLanguage(
      BuildContext context, String languageCode, String language) async {
    var locale = Locale(languageCode);
    Get.updateLocale(locale);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);

    _showSelectedLanguage(context, language);
  }

  void _showSelectedLanguage(BuildContext context, String language) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Language Selected'),
          content: Text('You have selected $language'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    saveBoolData(false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}
