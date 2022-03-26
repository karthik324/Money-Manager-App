import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/db/database.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/screens/categories/screen_income_categories.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';

// ignore: must_be_immutable
class IncomeScreen extends StatefulWidget {
  int? currentKey;
  IncomeScreen({Key? key, this.currentKey}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final formKey = GlobalKey<FormState>();
  Categories? selectedCategory;
  TextEditingController amountController = TextEditingController();
  late Box<Categories> categories;
  late Box<Transactions> transactions;
  bool redCol = false;
  DateTime? date;

  @override
  void initState() {
    categories = Hive.box<Categories>(categoryBox);
    transactions = Hive.box<Transactions>(transactionBox);
    amountController.text = widget.currentKey != null
        ? transactions.get(widget.currentKey)!.amount.toString()
        : "";
    date = widget.currentKey != null
        ? transactions.get(widget.currentKey)!.dateTime
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
            ? const Text('Income')
            : const Text('Edit Income'),
        centerTitle: true,
        backgroundColor: greenTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSubHead(text: 'Amount'),
            Form(
              key: formKey,
              child: CustomTextField(
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
              child: ValueListenableBuilder(
                valueListenable: categories.listenable(),
                builder: (context, Box<Categories> categoryList, _) {
                  return DropdownButton<dynamic>(
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                    isExpanded: true,
                    value: selectedCategory,
                    borderRadius: BorderRadius.circular(10),
                    iconEnabledColor: greenTheme,
                    hint: const Text('Select Category'),
                    items: type(categoryList.values.toList())[0].map(
                      (Categories e) {
                        return DropdownMenuItem(
                          child: Text(e.category),
                          value: e,
                          onTap: () {
                            selectedCategory = e;
                          },
                        );
                      },
                    ).toList(),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: mediaQueryWidth * 0.02),
              child: Row(
                children: [
                  TextButton(
                    style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all(greenTheme)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IncomeCategory()));
                    },
                    child: Text(
                      'Add Category',
                      style: TextStyle(color: greenTheme),
                    ),
                  ),
                ],
              ),
            ),
            CustomSubHead(text: 'Date'),
            SizedBox(
              height: mediaQueryHeight * 0.04,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (newDate == null) return;
                      setState(() => date = newDate);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: mediaQueryWidth * 0.043),
                      child: Row(
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy')
                                .format(date ?? DateTime.now()),
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
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
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
            Divider(
              height: mediaQueryHeight * 0.03,
              thickness: 1,
              indent: mediaQueryWidth * 0.047,
              endIndent: mediaQueryWidth * 0.047,
              color: Colors.black,
            ),
            VerticalSpace(height: mediaQueryHeight * 0.37),
            CustomElevatedButtonIncome(
              text: widget.currentKey == null ? 'Add Income' : 'Update Income',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final parseAmont = double.tryParse(amountController.text);
                  if (selectedCategory == null) {
                    return;
                  }
                  date ??= DateTime.now();
                  Transactions newTransaction = Transactions(
                      amount: parseAmont!,
                      categoryType: selectedCategory!,
                      dateTime: date!);
                  widget.currentKey == null
                      ? transactions.add(newTransaction)
                      : transactions.put(widget.currentKey, newTransaction);

                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
