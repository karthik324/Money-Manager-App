import 'package:flutter/material.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/screens/login/screen_login.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          VerticalSpace(height: mediaQueryHeight * 0.08),
          SafeArea(
            child: Image.asset(
              'assets/images/undraw_Pay_online_re_aqe6.png',
              width: mediaQueryWidth,
              height: mediaQueryHeight * 0.4,
            ),
          ),
          VerticalSpace(height: mediaQueryHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'All your finance in one place',
                style: TextStyle(
                  fontSize: customFontSizeHead,
                  fontWeight: bold,
                ),
              ),
            ],
          ),
          VerticalSpace(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'See the bigger picture by having all your',
                style: TextStyle(fontWeight: bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'finance in one place',
                style: TextStyle(fontWeight: bold),
              ),
            ],
          ),
          VerticalSpace(
            height: mediaQueryHeight * 0.26,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                text: 'Skip',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                },
              ),
              CustomElevatedButton(
                text: 'Next',
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OnboardingScreen2())),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          VerticalSpace(height: mediaQueryHeight * 0.08),
          SafeArea(
            child: Image.asset(
              'assets/images/undraw_Mobile_pay_re_sjb8.png',
              height: mediaQueryHeight * 0.4,
              width: mediaQueryWidth,
            ),
          ),
          VerticalSpace(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Know where your money',
                style: TextStyle(
                  fontSize: customFontSizeHead,
                  fontWeight: bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'goes',
                style: TextStyle(
                  fontSize: customFontSizeHead,
                  fontWeight: bold,
                ),
              )
            ],
          ),
          VerticalSpace(height: 15),
          // const VerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '''With categories and more''',
                style: TextStyle(fontWeight: bold),
              ),
            ],
          ),
          SizedBox(
            height: mediaQueryHeight * 0.23,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                text: 'Next',
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OnboardingScreen3())),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          VerticalSpace(height: mediaQueryHeight * 0.08),
          SafeArea(
              child: Image.asset(
            'assets/images/undraw_Success_factors_re_ce93.png',
            height: mediaQueryHeight * 0.4,
            width: mediaQueryWidth,
          )),
          VerticalSpace(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Track your spending',
                style: TextStyle(
                  fontSize: customFontSizeHead,
                  fontWeight: bold,
                ),
              ),
            ],
          ),
          VerticalSpace(height: 15),
          // const VerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '''Keep track of your expenses manually''',
                style: TextStyle(fontWeight: bold),
              ),
            ],
          ),
          VerticalSpace(
            height: mediaQueryHeight * 0.275,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                text: 'Next',
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OnboardingScreen4())),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class OnboardingScreen4 extends StatelessWidget {
  const OnboardingScreen4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          VerticalSpace(height: mediaQueryHeight * 0.08),
          SafeArea(
            child: Image.asset(
              'assets/images/undraw_Key_points_re_u903.png',
              height: mediaQueryHeight * 0.4,
              width: mediaQueryWidth,
            ),
          ),
          VerticalSpace(height: 15),
          Text(
            'Set Reminder',
            style: TextStyle(
              fontSize: customFontSizeHead,
              fontWeight: bold,
            ),
          ),
          VerticalSpace(height: 15),
          // const VerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Set reminder of your upcoming payments or',
                style: TextStyle(fontWeight: bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'incomes',
                style: TextStyle(fontWeight: bold),
              )
            ],
          ),
          VerticalSpace(
            height: mediaQueryHeight * 0.25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                text: 'Get Started',
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen())),
              ),
            ],
          )
        ],
      ),
    );
  }
}
