import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/screens/home/screen_calander.dart';
import 'package:money_manager_app/screens/home/screen_transactions.dart';
import 'package:money_manager_app/screens/income expense reminder/screen_expense.dart';
import 'package:money_manager_app/screens/income expense reminder/screen_income.dart';
import 'package:money_manager_app/screens/home/screen_monthly.dart';
import 'package:money_manager_app/screens/home/screen_yearly.dart';
import 'package:money_manager_app/screens/income expense reminder/screen_set_reminder.dart';
import 'package:money_manager_app/screens/settings/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed();
    super.initState();
  }

  DateTime? timeBackButton;

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    TabController _tabController = TabController(length: 4, vsync: this);
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (timeBackButton == null ||
            now.difference(timeBackButton!) > const Duration(seconds: 2)) {
          timeBackButton = now;
          final snackBar = SnackBar(
            duration: const Duration(seconds: 1),
            content: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.2, color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Tap again to exit',
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 100,
            behavior: SnackBarBehavior.fixed,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return Future.value(false);
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: greenTheme,
          automaticallyImplyLeading: false,
          title: Text(
            'Home',
            style: TextStyle(fontWeight: bold),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: mediaQueryWidth * 0.005),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
                },
                icon: const Icon(Icons.settings),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                indicatorColor: greenTheme,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                controller: _tabController,
                labelPadding: EdgeInsets.only(
                    left: mediaQueryWidth * 0.06,
                    right: mediaQueryWidth * 0.06),
                tabs: const [
                  Tab(text: "Transactions"),
                  Tab(text: "Monthly"),
                  Tab(text: 'Yearly'),
                  Tab(text: 'Calander')
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    AllTransactions(),
                    MonthlyScreen(),
                    YearlyScreen(),
                    CalanderScreen()
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          backgroundColor: greenTheme,
          activeIcon: Icons.close,
          icon: Icons.add,
          overlayColor: Colors.black87,
          overlayOpacity: 0.5,
          spacing: 10,
          spaceBetweenChildren: 5,
          animationSpeed: 100,
          children: [
            SpeedDialChild(
              label: 'Add Income ',
              labelBackgroundColor: greenTheme,
              labelStyle: const TextStyle(color: Colors.white),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => IncomeScreen(),
                ),
              ),
            ),
            SpeedDialChild(
              label: 'Add Expense',
              labelBackgroundColor: redTheme,
              labelStyle: const TextStyle(color: Colors.white),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExpenseScreen(),
                ),
              ),
            ),
            SpeedDialChild(
              label: 'Set Reminder',
              labelBackgroundColor: redTheme,
              labelStyle: const TextStyle(color: Colors.white),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SetReminderScreen(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
