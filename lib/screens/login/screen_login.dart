import 'package:flutter/material.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/screens/home/screen_home.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  String finalName = '';
  @override
  void initState() {
    super.initState();
  }

  setValidationData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('name', nameController.text);
    // print(finalName);
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            VerticalSpace(height: mediaQueryHeight * 0.08),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(right: mediaQueryHeight * 0.01),
                child: Image.asset(
                  'assets/images/undraw_Access_account_re_8spm.png',
                  width: mediaQueryWidth,
                  height: mediaQueryHeight * 0.4,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: mediaQueryHeight * 0.03),
                  child: Text(
                    'Enter your name',
                    style: TextStyle(
                      fontSize: customFontSizeTitle,
                      fontWeight: bold,
                    ),
                  ),
                ),
                VerticalSpace(height: mediaQueryHeight * 0.01),
                Form(
                  key: formKey,
                  child: CustomInputField(
                    controller: nameController,
                  ),
                ),
              ],
            ),
            VerticalSpace(height: mediaQueryHeight * 0.23),
            CustomElevatedButton(
              text: "Let's go",
              onPressed: () async {
                if (formKey.currentState!.validate() &&
                    nameController.text != '') {
                  setValidationData();
                  // print(nameController.text);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
