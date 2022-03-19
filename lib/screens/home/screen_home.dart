import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/screens/home/screen_calander.dart';
import 'package:money_manager_app/screens/home/screen_daily.dart';
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
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    TabController _tabController = TabController(length: 4, vsync: this);
    return Scaffold(
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
                icon: Icon(Icons.settings),
              )),
        ],
      ),
      body: SingleChildScrollView(
        // primary: false,
        child: Column(
          children: [
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
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
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: mediaQueryWidth * 0.04,
                  top: mediaQueryHeight * 0.02,
                  right: mediaQueryWidth * 0.04),
              child: Container(
                width: double.maxFinite,
                height: mediaQueryHeight,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    DailyScreen(),
                    MonthlyScreen(),
                    YearlyScreen(),
                    CalanderScreen()
                  ],
                ),
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
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const IncomeScreen()))),
          SpeedDialChild(
              label: 'Add Expense',
              labelBackgroundColor: redTheme,
              labelStyle: const TextStyle(color: Colors.white),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ExpenseScreen()))),
          SpeedDialChild(
              label: 'Set Reminder',
              labelBackgroundColor: redTheme,
              labelStyle: const TextStyle(color: Colors.white),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SetReminderScreen())))
        ],
      ),
    );
  }
}
