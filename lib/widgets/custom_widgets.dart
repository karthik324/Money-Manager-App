import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/main.dart';
// import 'package:money_manager_app/screens/categories/categories_db.dart';

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

class CustomInputField extends StatelessWidget {
  TextEditingController? controller;
  CustomInputField({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    TextEditingController? nameController = TextEditingController();
    return Padding(
      padding: EdgeInsets.only(
          left: mediaQueryHeight * 0.02, right: mediaQueryHeight * 0.02),
      child: TextFormField(
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
    double mediaQueryWidth = MediaQuery.of(context).size.width;
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
          // Padding(
          //   padding: EdgeInsets.only(
          //       left: mediaQueryWidth * 0.045, top: mediaQueryHeight * 0.015),
          //   child: Row(
          //     children: [
          //       CircleAvatar(
          //         backgroundColor: Colors.brown,
          //         radius: 20,
          //         child: Text(
          //           circleAvatarText,
          //           style: const TextStyle(
          //               fontFamily: 'Prompt', color: Colors.white),
          //         ),
          //       ),
          //       HorizontalSpace(width: mediaQueryWidth * 0.02),
          //       Text(
          //         title,
          //         style:
          //             TextStyle(fontSize: customFontSizePara, fontWeight: bold),
          //       ),
          //     ],
          //   ),
          // ),
          // Row(
          //   children: [
          //     Text(
          //       'Due date - $dueDate',
          //       style: TextStyle(fontSize: 11, fontWeight: bold),
          //     ),
          //     // HorizontalSpace(width: mediaQueryWidth * 0.11),
          //     Flexible(
          //       child: Text(
          //         '₹$payMent',
          //         style: TextStyle(color: redTheme),
          //       ),
          //     ),
          //   ],
          // ),
          VerticalSpace(height: mediaQueryHeight * 0.01),
          Padding(
            padding: EdgeInsets.only(bottom: mediaQueryHeight * 0.01),
            child: CustomElevatedButton(
              text: 'Notify Me',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

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

class CustomTextField extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  CustomTextField({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
          left: mediaQueryWidth * 0.04, right: mediaQueryWidth * 0.04),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty || value == null || value == '') {
            return 'Enter the amount';
          }
        },
        keyboardType: TextInputType.number,
        controller: controller,
        // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.monetization_on,
              color: greenTheme,
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
  CustomSubHead({Key? key, required this.text}) : super(key: key);

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

// class CustomDatePicker extends StatefulWidget {
//   bool redCol = false;
//   DateTime? date;
//   CustomDatePicker({Key? key, required this.redCol, required this.date})
//       : super(key: key);

//   @override
//   State<CustomDatePicker> createState() => _CustomDatePickerState();
// }

// class _CustomDatePickerState extends State<CustomDatePicker> {
//   @override
//   Widget build(BuildContext context) {
//     double mediaQueryHeight = MediaQuery.of(context).size.height;
//     double mediaQueryWidth = MediaQuery.of(context).size.width;

//     return Padding(
//       padding: EdgeInsets.only(
//           left: mediaQueryWidth * 0.042, right: mediaQueryWidth * 0.04),
//       child:
//     );
//   }
// }

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

class CustomTextFieldExpense extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  CustomTextFieldExpense({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    int? amount;
    return Padding(
      padding: EdgeInsets.only(
          left: mediaQueryWidth * 0.04, right: mediaQueryWidth * 0.04),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty || value == null || value == '') {
            return 'Enter the amount';
          }
        },
        onChanged: (val) {
          amount = int.parse(val);
        },
        cursorColor: redTheme,
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.monetization_on,
              color: redTheme,
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
  CustomSubHeadReminder({Key? key, required this.text}) : super(key: key);

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

class CustomDatePickerReminder extends StatefulWidget {
  bool redCol = false;
  CustomDatePickerReminder({Key? key, required this.redCol}) : super(key: key);

  @override
  State<CustomDatePickerReminder> createState() =>
      _CustomDatePickerReminderState();
}

class _CustomDatePickerReminderState extends State<CustomDatePickerReminder> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
          left: mediaQueryWidth * 0.042, right: mediaQueryWidth * 0.04),
      child: Container(
        height: mediaQueryHeight * 0.04,
        child: Row(
          children: [
            GestureDetector(
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030));
                  if (newDate == null) return;
                  setState(() => date = newDate);
                },
                child: Text(
                  DateFormat('dd/MM/yyyy').format(date),
                )),
            HorizontalSpace(width: mediaQueryWidth * 0.33),
            IconButton(
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (newDate == null) return;
                  setState(() => date = newDate);
                },
                icon: Icon(
                  Icons.date_range,
                  color: widget.redCol ? redTheme : greenTheme,
                ))
          ],
        ),
      ),
    );
  }
}

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
    return Container(
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
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.maxFinite,
      height: mediaQueryHeight * 0.1,
      child: Card(
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: greenTheme,
              child: Text(
                date,
                style: TextStyle(fontSize: 10, color: Colors.white),
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
