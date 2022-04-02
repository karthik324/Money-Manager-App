import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/db/database.dart';
import 'package:money_manager_app/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Box<UserName> userBox = Hive.box<UserName>(loginBox);

// ignore: must_be_immutable
class VerticalSpace extends StatelessWidget {
  double height;
  VerticalSpace({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

// ignore: must_be_immutable
class HorizontalSpace extends StatelessWidget {
  double width;
  HorizontalSpace({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

// ignore: must_be_immutable
class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({Key? key, required this.text, this.onPressed})
      : super(key: key);
  String text;
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
          primary: greenTheme,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
          minimumSize: Size(mediaQueryHeight * 0.19, mediaQueryWidth * 0.13),
          maximumSize: Size(mediaQueryHeight * 0.19, mediaQueryWidth * 0.13)),
    );
  }
}

// ignore: must_be_immutable
class CustomInputField extends StatelessWidget {
  TextEditingController? controller;
  Function(String)? onChanged;
  CustomInputField({Key? key, this.controller, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          left: mediaQueryHeight * 0.02, right: mediaQueryHeight * 0.02),
      child: TextFormField(
          textCapitalization: TextCapitalization.words,
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              filled: true,
              fillColor: const Color.fromARGB(255, 241, 241, 241),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          validator: (value) {
            if (value!.isEmpty ||
                !RegExp(r'^[a-zA-Z][a-z A-Z]+$').hasMatch(value)) {
              return "Enter correct name";
            }
            return null;
          }),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final String value;
  final Icon leading;
  const CustomListTile(
      {Key? key,
      required this.title,
      required this.leading,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontFamily: 'Prompt'),
      ),
      leading: leading,
      trailing: Text(
        value,
        style: TextStyle(color: redTheme, fontFamily: 'Prompt'),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  String circleAvatarText;
  String dueDate;
  String title;
  int payMent;
  CustomCard(
      {Key? key,
      required this.circleAvatarText,
      required this.title,
      required this.dueDate,
      required this.payMent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: mediaQueryWidth * 0.045, top: mediaQueryHeight * 0.01),
            child: Row(
              children: [
                Text(
                  'Upcoming Payments',
                  style: TextStyle(
                      fontSize: customFontSizeTitle, fontWeight: bold),
                ),
              ],
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: redTheme,
              radius: 20,
              child: Text(
                circleAvatarText,
                style:
                    const TextStyle(fontFamily: 'Prompt', color: Colors.white),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: customFontSizePara, fontWeight: bold),
            ),
            subtitle: Text(
              'Due date - $dueDate',
              style: TextStyle(
                  fontSize: 11, fontWeight: bold, color: Colors.black),
            ),
            trailing: Text(
              '₹$payMent',
              style: TextStyle(color: redTheme),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomElevatedButtonRed extends StatelessWidget {
  CustomElevatedButtonRed({Key? key, required this.text, this.onPressed})
      : super(key: key);
  String text;
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
          primary: redTheme,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
          minimumSize: Size(mediaQueryHeight * 0.19, mediaQueryWidth * 0.13),
          maximumSize: Size(mediaQueryHeight * 0.19, mediaQueryWidth * 0.13)),
    );
  }
}

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  CustomTextField({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
          left: mediaQueryWidth * 0.04, right: mediaQueryWidth * 0.04),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty || value == '') {
            return 'Enter the amount';
          }
          return null;
        },
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: FaIcon(
              FontAwesomeIcons.indianRupeeSign,
              color: greenTheme,
              size: 20,
            ),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black))),
      ),
    );
  }
}

class CustomSubHead extends StatelessWidget {
  final String text;
  const CustomSubHead({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: mediaQueryHeight * 0.01,
              left: mediaQueryWidth * 0.04,
              right: mediaQueryWidth * 0.04),
          child: Text(
            text,
            style: TextStyle(fontSize: customFontSizeTitle, fontWeight: bold),
          ),
        ),
      ],
    );
  }
}

class CategoryItems extends StatefulWidget {
  final String title;
  const CategoryItems({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        ChoiceChip(
          label: Text(widget.title),
          selected: isSelected,
          onSelected: (bool value) {
            isSelected = value;
            setState(() {});
          },
          selectedColor: Colors.blueGrey,
        ),
        HorizontalSpace(width: mediaQueryWidth * 0.01),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomElevatedButtonIncome extends StatelessWidget {
  CustomElevatedButtonIncome({Key? key, required this.text, this.onPressed})
      : super(key: key);
  String text;
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
          primary: greenTheme,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
          minimumSize: Size(mediaQueryHeight * 0.35, mediaQueryWidth * 0.13),
          maximumSize: Size(mediaQueryHeight * 0.35, mediaQueryWidth * 0.13)),
    );
  }
}

// ignore: must_be_immutable
class CustomElevatedButtonExpense extends StatelessWidget {
  CustomElevatedButtonExpense({Key? key, required this.text, this.onPressed})
      : super(key: key);
  String text;
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
          primary: redTheme,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
          minimumSize: Size(mediaQueryHeight * 0.35, mediaQueryWidth * 0.13),
          maximumSize: Size(mediaQueryHeight * 0.35, mediaQueryWidth * 0.13)),
    );
  }
}

// ignore: must_be_immutable
class CustomTextFieldExpense extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  CustomTextFieldExpense({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: mediaQueryWidth * 0.04,
        right: mediaQueryWidth * 0.04,
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty || value == '') {
            return 'Enter the amount';
          }
          return null;
        },
        onChanged: (val) {},
        cursorColor: redTheme,
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            suffixIcon: FaIcon(
              FontAwesomeIcons.indianRupeeSign,
              color: redTheme,
              size: 20,
            ),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black))),
      ),
    );
  }
}

class CustomSubHeadReminder extends StatelessWidget {
  final String text;
  const CustomSubHeadReminder({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: mediaQueryHeight * 0.01,
              left: mediaQueryWidth * 0.04,
              right: mediaQueryWidth * 0.04),
          child: Text(
            text,
            style: TextStyle(fontSize: customFontSizePara, fontWeight: bold),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomTransactionCard extends StatelessWidget {
  String date;
  String category;
  String amount;
  Color color;
  CustomTransactionCard(
      {Key? key,
      required this.amount,
      required this.category,
      required this.color,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.maxFinite,
      height: mediaQueryHeight * 0.1,
      child: Card(
        child: Center(
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(20.0), //or 15.0
              child: Container(
                height: mediaQueryHeight * 0.7,
                width: mediaQueryWidth * 0.32,
                color: color,
                child: Center(
                  child: Text(
                    date,
                    style: const TextStyle(fontSize: 11, color: Colors.white),
                  ),
                ),
              ),
            ),
            title: Text(category),
            trailing: Text(
              amount,
              style: TextStyle(color: color),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomTransactionCardIncome extends StatelessWidget {
  String date;
  String category;
  String amount;
  CustomTransactionCardIncome(
      {Key? key,
      required this.amount,
      required this.category,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.maxFinite,
      height: mediaQueryHeight * 0.1,
      child: Card(
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: greenTheme,
              child: Text(
                date,
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
              radius: 40,
            ),
            title: Text(category),
            trailing: Text(
              amount,
              style: TextStyle(color: greenTheme),
            ),
          ),
        ),
      ),
    );
  }
}
