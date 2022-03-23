import 'package:flutter/material.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // String? _name = '';
  // Future<void> setName() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   final name = sharedPreferences.getString('name');
  //   setState(() {
  //     _name = name!;
  //     // print(_name);
  //   });
  // }

  bool _value = false;

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    // double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenTheme,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ListTile(
            //   leading: Icon(
            //     Icons.person,
            //     color: greenTheme,
            //   ),
            //   title: Text(_name ?? 'hai'),
            // ),
            SwitchListTile(
              activeColor: greenTheme,
              secondary: Icon(
                Icons.notifications,
                color: greenTheme,
              ),
              title: const Text(
                'Notifications',
              ),
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                  // print(_name);
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.clear_all,
                color: greenTheme,
              ),
              title: const Text('Reset Data'),
            ),
            ListTile(
              leading: Icon(
                Icons.feedback,
                color: greenTheme,
              ),
              title: const Text('Feedback'),
            ),
            ListTile(
              leading: Icon(
                Icons.share,
                color: greenTheme,
              ),
              title: const Text('Share App'),
            ),
            ListTile(
              leading: Icon(
                Icons.star,
                color: greenTheme,
              ),
              title: const Text('Rate Us'),
            ),
            ListTile(
              leading: Icon(
                Icons.privacy_tip,
                color: greenTheme,
              ),
              title: const Text('Privacy Policy'),
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: greenTheme,
              ),
              title: const Text('About Me'),
            ),

            VerticalSpace(height: mediaQueryHeight * 0.55),
            const Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
