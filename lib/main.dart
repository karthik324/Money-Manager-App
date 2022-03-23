import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager_app/db/database.dart';
import 'package:money_manager_app/screens/splash%20screen/screen_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';

const categoryBox = 'categorybox';
const transactionBox = 'transactionbox';
const reminderBox = 'reminderbox';
const loginBox = 'loginbox';
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CategoriesAdapter());
  Hive.registerAdapter(TransactionsAdapter());
  Hive.registerAdapter(ReminderDbAdapter());
  await Hive.openBox<Categories>(categoryBox);
  await Hive.openBox<Transactions>(transactionBox);
  await Hive.openBox<ReminderDb>(reminderBox);
  runApp(const MyApp());
}

double customFontSizeHead = 23;
double customFontSizePara = 16;
double customFontSizeTitle = 17;
Color greenTheme = Colors.green;
Color redTheme = const Color.fromARGB(255, 193, 57, 43);
Color blueTheme = const Color.fromARGB(255, 0, 0, 255);
FontWeight bold = FontWeight.bold;
// MaterialColor greenMaterial = Colors.green;
// const Map<int, Color> color = {
//   50: Color.fromARGB(200, 35, 146, 101),
//   100: Color.fromARGB(200, 35, 146, 101),
//   200: Color.fromARGB(200, 35, 146, 101),
//   300: Color.fromARGB(200, 35, 146, 101),
//   400: Color.fromARGB(200, 35, 146, 101),
//   500: Color.fromARGB(200, 35, 146, 101),
//   600: Color.fromARGB(200, 35, 146, 101),
//   700: Color.fromARGB(200, 35, 146, 101),
//   800: Color.fromARGB(200, 35, 146, 101),
//   900: Color.fromARGB(200, 35, 146, 101),
// };

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FIN Trac',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(fontFamily: 'Prompt', primarySwatch: Colors.green),
    );
  }
}
