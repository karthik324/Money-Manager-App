import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Utils/utils.dart';
import 'package:money_manager_app/db/database.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

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
              'You should definitely check this app out. Such a simple and cool Money Manager App.\n https://play.google.com/store/apps/details?id=in.brototype.money_manager_app',
            ),
            child: ListTile(
              leading: Icon(
                Icons.share,
                color: greenTheme,
              ),
              title: const Text('Share App'),
            ),
          ),
          GestureDetector(
            onTap: () {
              StoreRedirect.redirect(
                androidAppId: 'in.brototype.money_manager_app',
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.star,
                color: greenTheme,
              ),
              title: const Text('Rate App'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Utils.openLink(
                  url:
                      'https://www.freeprivacypolicy.com/live/cd781538-d5d8-46e4-bfe1-2cc49b2791c4');
            },
            child: ListTile(
              leading: Icon(
                Icons.privacy_tip,
                color: greenTheme,
              ),
              title: const Text('Privacy Policy'),
            ),
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
