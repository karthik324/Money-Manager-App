import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/db/database.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';

// ignore: must_be_immutable
class SetReminderScreen extends StatefulWidget {
  int? currentKey;
  SetReminderScreen({Key? key, this.currentKey}) : super(key: key);

  @override
  State<SetReminderScreen> createState() => _SetReminderScreenState();
}

class _SetReminderScreenState extends State<SetReminderScreen> {
  late Box<ReminderDb> reminder;
  final formKey = GlobalKey<FormState>();
  final amountKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool redCol = true;

  @override
  void initState() {
    reminder = Hive.box<ReminderDb>(reminderBox);
    titleController.text = widget.currentKey != null
        ? reminder.get(widget.currentKey)!.title.toString()
        : "";
    amountController.text = widget.currentKey != null
        ? reminder.get(widget.currentKey)!.amount.toString()
        : "";
    date = widget.currentKey != null
        ? reminder.get(widget.currentKey)!.dateTime
        : date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: widget.currentKey == null
            ? const Text('Reminder')
            : const Text('Edit Reminder'),
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
                    controller: titleController,
                    maxLength: 20,
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
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
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              VerticalSpace(height: mediaQueryHeight * 0),
              CustomSubHead(text: 'Amount'),
              Form(
                key: amountKey,
                child: CustomTextFieldExpense(
                  controller: amountController,
                ),
              ),
              VerticalSpace(height: mediaQueryHeight * 0.02),
              CustomSubHead(text: 'Due Date'),
              VerticalSpace(height: mediaQueryHeight * 0.02),
              SizedBox(
                height: mediaQueryHeight * 0.04,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2035),
                          builder: (context, child) => Theme(
                            child: child!,
                            data: ThemeData().copyWith(
                                colorScheme: const ColorScheme.light(
                              primary: Colors.red,
                            )),
                          ),
                        );
                        if (newDate == null) return;
                        setState(() => date = newDate);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: mediaQueryWidth * 0.043),
                        child: Row(
                          children: [
                            Text(
                              DateFormat('dd/MM/yyyy').format(date),
                            ),
                          ],
                        ),
                      ),
                    ),
                    HorizontalSpace(width: mediaQueryWidth * 0.552),
                    IconButton(
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2035),
                          builder: (context, child) => Theme(
                            child: child!,
                            data: ThemeData().copyWith(
                                colorScheme: const ColorScheme.light(
                              primary: Colors.red,
                            )),
                          ),
                        );
                        if (newDate == null) return;
                        setState(() => date = newDate);
                      },
                      icon: Icon(
                        Icons.date_range,
                        color: redCol ? redTheme : greenTheme,
                      ),
                    ),
                  ],
                ),
              ),
              // CustomDatePicker(redCol: true, date: date),
              Divider(
                thickness: 1,
                color: Colors.black,
                indent: mediaQueryWidth * 0.043,
                endIndent: mediaQueryWidth * 0.048,
              ),
              VerticalSpace(height: mediaQueryHeight * 0.38),
              CustomElevatedButtonExpense(
                text: widget.currentKey == null
                    ? 'Add Reminder'
                    : 'Update Reminder',
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      amountKey.currentState!.validate()) {
                    final parseAmount = double.tryParse(amountController.text);
                    if (parseAmount == null) {
                      return;
                    }
                    ReminderDb newReminder = ReminderDb(
                        title: titleController.text,
                        amount: parseAmount,
                        dateTime: date);
                    widget.currentKey == null
                        ? reminder.add(newReminder)
                        : reminder.put(widget.currentKey, newReminder);

                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
