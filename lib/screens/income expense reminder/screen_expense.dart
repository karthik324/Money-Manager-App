import 'package:flutter/material.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/screens/categories/screen_expense_categories.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final formKey = GlobalKey<FormState>();
  var selectedCategory;
  final amountController = TextEditingController();
  final newDate = DateTime.now();
  // ExpenseCategories? selectedVal;
  // String name = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense'),
        centerTitle: true,
        backgroundColor: redTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSubHead(text: 'Amount'),
            Form(
              key: formKey,
              child: CustomTextFieldExpense(
                controller: amountController,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: mediaQueryHeight * 0.02),
              child: CustomSubHead(text: 'Category'),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: mediaQueryWidth * 0.045, right: mediaQueryWidth * 0.5),
              child: DropdownButton<dynamic>(
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                isExpanded: true,
                value: selectedCategory,
                borderRadius: BorderRadius.circular(10),
                iconEnabledColor: redTheme,
                hint: const Text('Select Category'),
                items:
                    <String>['one', 'two', 'three', 'four'].map((String val) {
                  return DropdownMenuItem<dynamic>(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: mediaQueryWidth * 0.02),
              child: Row(
                children: [
                  TextButton(
                    style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all(redTheme)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExpenseCategory()));
                    },
                    child: Text(
                      'Add Category',
                      style: TextStyle(color: redTheme),
                    ),
                  ),
                ],
              ),
            ),
            CustomSubHead(text: 'Date'),
            CustomDatePicker(redCol: true, date: newDate),
            Divider(
              height: mediaQueryHeight * 0.03,
              thickness: 1,
              indent: mediaQueryWidth * 0.047,
              endIndent: mediaQueryWidth * 0.047,
              color: Colors.black,
            ),
            VerticalSpace(height: mediaQueryHeight * 0.37),
            CustomElevatedButtonExpense(
              text: 'Add Expense',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
