import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Utils/utils.dart';
import 'package:money_manager_app/db/database.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Box<Categories> categories = Hive.box<Categories>(categoryBox);
  Box<Transactions> transactions = Hive.box<Transactions>(transactionBox);
  Box<ReminderDb> reminder = Hive.box<ReminderDb>(reminderBox);
  Box<UserName> userBox = Hive.box<UserName>(loginBox);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenTheme,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.person,
              color: greenTheme,
            ),
            title: Text(userBox.values.first.userName),
          ),
          GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Warning!', style: TextStyle(color: redTheme)),
                  content: const Text('Do you want to Reset all Data?'),
                  actions: [
                    TextButton(
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        categories.clear();
                        transactions.clear();
                        reminder.clear();
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text(
                        'NO',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                );
              },
            ),
            child: ListTile(
              leading: Icon(
                Icons.remove_circle_sharp,
                color: greenTheme,
              ),
              title: const Text('Reset Data'),
            ),
          ),
          GestureDetector(
            onTap: () => Utils.openEmail(
              toEmail: 'karthikdileep003@gmail.com',
              subject: 'Feedback about FIN Trac',
            ),
            child: ListTile(
              leading: Icon(
                Icons.feedback,
                color: greenTheme,
              ),
              title: const Text('Feedback'),
            ),
          ),
          GestureDetector(
            onTap: () => Share.share(
                'You should definitely check this app out. Such a simple and cool Money Manager App.'),
            child: ListTile(
              leading: Icon(
                Icons.share,
                color: greenTheme,
              ),
              title: const Text('Share App'),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.star,
              color: greenTheme,
            ),
            title: const Text('Rate App'),
          ),
          ListTile(
            leading: Icon(
              Icons.privacy_tip,
              color: greenTheme,
            ),
            title: const Text('Privacy Policy'),
          ),
          GestureDetector(
            onTap: (() => Utils.openLink(
                url: 'https://karthik324.github.io/my-personalsite/')),
            child: ListTile(
              leading: Icon(
                Icons.info,
                color: greenTheme,
              ),
              title: const Text('About Me'),
            ),
          ),
          VerticalSpace(height: mediaQueryHeight * 0.33),
          const Text(
            'Version 1.0',
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
