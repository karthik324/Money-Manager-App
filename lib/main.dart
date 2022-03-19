import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager_app/db/database.dart';
import 'package:money_manager_app/screens/splash%20screen/screen_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';

const categoryBox = 'categorybox';
const transactionBox = 'transactionbox';
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CategoriesAdapter());
  Hive.registerAdapter(TransactionsAdapter());
  await Hive.openBox<Categories>(categoryBox);
  await Hive.openBox<Transactions>(transactionBox);
  runApp(const MyApp());
}

double customFontSizeHead = 23;
double customFontSizePara = 16;
double customFontSizeTitle = 17;
int greenThemeInt = 0x239265;
int redThemeInt = 0xF44336;
int blueThemeInt = 0x0000FF;
Color greenTheme = const Color.fromARGB(200, 35, 146, 101);
Color redTheme = const Color.fromARGB(255, 193, 57, 43);
Color blueTheme = const Color.fromARGB(255, 0, 0, 255);
FontWeight bold = FontWeight.bold;
MaterialColor greenMaterial = const MaterialColor(0x239265, color);
const Map<int, Color> color = {
  50: Color.fromARGB(200, 35, 146, 101),
  100: Color.fromARGB(199, 3, 158, 96),
  200: Color.fromARGB(198, 6, 134, 83),
  300: Color.fromARGB(199, 9, 100, 64),
  400: Color.fromARGB(199, 9, 85, 55),
  500: Color.fromARGB(199, 2, 85, 52),
  600: Color.fromARGB(200, 35, 146, 101),
  700: Color.fromARGB(199, 9, 75, 49),
  800: Color.fromARGB(199, 8, 58, 38),
  900: Color.fromARGB(199, 8, 44, 30),
};

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
