import 'package:flutter/material.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';

class SetReminderScreen extends StatefulWidget {
  const SetReminderScreen({Key? key}) : super(key: key);

  @override
  State<SetReminderScreen> createState() => _SetReminderScreenState();
}

class _SetReminderScreenState extends State<SetReminderScreen> {
  final formKey = GlobalKey<FormState>();
  final amountKey = GlobalKey<FormState>();
  final date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder'),
        centerTitle: true,
        backgroundColor: redTheme,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              CustomSubHead(text: 'Title'),
              Padding(
                padding: EdgeInsets.only(
                    left: mediaQueryWidth * 0.04,
                    right: mediaQueryWidth * 0.04),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value == null || value == '') {
                        return 'Enter the title';
                      }
                      return null;
                    },
                    cursorColor: redTheme,
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.title_outlined,
                          color: redTheme,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
              ),
              VerticalSpace(height: mediaQueryHeight * 0.02),
              CustomSubHead(text: 'Amount'),
              Form(key: amountKey, child: CustomTextFieldExpense()),
              VerticalSpace(height: mediaQueryHeight * 0.02),
              CustomSubHead(text: 'Due Date'),
              CustomDatePicker(
                redCol: true,
                date: date,
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
                indent: mediaQueryWidth * 0.043,
                endIndent: mediaQueryWidth * 0.048,
              ),
              VerticalSpace(height: mediaQueryHeight * 0.40),
              CustomElevatedButtonExpense(
                text: 'Add Reminder',
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  } else if (!amountKey.currentState!.validate()) {
                    return;
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
