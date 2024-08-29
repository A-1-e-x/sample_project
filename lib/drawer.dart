import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sample_project/profile.dart';
import 'package:sample_project/settings.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "Logro App",
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: const Text(
              "logro@gmail.com",
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 208, 162, 247),
              child: ClipOval(
                child: Image.asset(
                  '\LOGRO.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 241, 234, 255),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.black),
            title: Text("Profile".tr, style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          Divider(
            thickness: 1,
            color: Color.fromARGB(255, 220, 191, 255),
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text("Settings".tr, style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),
          Divider(
            thickness: 1,
            color: Color.fromARGB(255, 220, 191, 255),
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.black),
            title: Text("Privacy Policy".tr,
                style: TextStyle(color: Colors.black)),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationIcon: Image.asset(
                  '\LOGRO.png',
                  height: 40,
                ),
                applicationName: 'Privacy Policy',
                applicationVersion: '0.0.1',
                applicationLegalese: 'Developed by D4A',
              );
            },
          ),
          Divider(
            thickness: 1,
            color: Color.fromARGB(255, 220, 191, 255),
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.black),
            title: Text("About".tr, style: TextStyle(color: Colors.black)),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Color.fromARGB(255, 151, 127, 187),
                  title: Text('About'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Developed by :',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(' Dev Nand'),
                        ],
                      ),
                      Text('                          Arun Dev'),
                      Text('                          Akshay'),
                      Text('                          Alex Antony'),
                      Text('                          Alfin Charley'),
                      SizedBox(height: 8),
                      Text('Version: 0.0.1'),
                      SizedBox(height: 16),
                      Text(
                        'This app is designed to help you manage your tasks efficiently. It features a simple and intuitive interface for adding, updating, and deleting tasks.',
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back'),
                    ),
                  ],
                ),
              );
            },
          ),
          Divider(
            thickness: 1,
            color: Color.fromARGB(255, 220, 191, 255),
            height: 2,
          ),
        ],
      ),
    );
  }
}
