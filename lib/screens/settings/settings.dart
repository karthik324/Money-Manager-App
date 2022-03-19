import 'package:flutter/material.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenTheme,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomSubHead(text: "User's Name"),
          SwitchListTile(
            activeColor: greenTheme,
            title: Text(
              'Notifications',
              style: TextStyle(fontSize: customFontSizeTitle, fontWeight: bold),
            ),
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: mediaQueryWidth * 0.05),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'License',
                      style: TextStyle(
                          fontSize: customFontSizeTitle, fontWeight: bold),
                    ),
                  ],
                ),
                VerticalSpace(height: mediaQueryHeight * 0.015),
                Row(
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                          fontSize: customFontSizeTitle, fontWeight: bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          VerticalSpace(height: mediaQueryHeight * 0.65),
          const Text(
            'Version 1.0.0',
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
