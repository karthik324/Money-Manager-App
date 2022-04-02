import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/db/database.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/screens/home/screen_transactions.dart';
import 'package:money_manager_app/screens/income%20expense%20reminder/screen_expense.dart';
import 'package:money_manager_app/screens/income%20expense%20reminder/screen_income.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

List<Transactions> dateRange(
    List<Transactions> list, DateTime startDate, DateTime endDate) {
  List<Transactions> rangeList = [];
  for (int i = 0; i < list.length; i++) {
    if ((list[i].dateTime.day == startDate.day ||
            list[i].dateTime.isAfter(startDate)) &&
        (list[i].dateTime.day == endDate.day ||
            list[i].dateTime.isBefore(endDate))) {
      rangeList.add(list[i]);
    }
  }
  return rangeList;
}

class CalanderScreen extends StatefulWidget {
  const CalanderScreen({Key? key}) : super(key: key);

  @override
  State<CalanderScreen> createState() => _CalanderScreenState();
}

class _CalanderScreenState extends State<CalanderScreen> {
  late Box<Categories> categories;
  late Box<Transactions> transactions;
  Icon myIcon = const Icon(Icons.search);
  Widget myField = const Text('All Transactions');
  String searchInput = '';
  double? totalIncome;
  double? totalExpense;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  void initState() {
    categories = Hive.box<Categories>(categoryBox);
    transactions = Hive.box<Transactions>(transactionBox);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: ValueListenableBuilder(
        valueListenable: transactions.listenable(),
        builder: (context, Box<Transactions> tra, _) {
          List<Transactions> boxList =
              dateRange(tra.values.toList(), startDate, endDate);
          double incomeAmount = amountType(boxList)[0];
          double expenseAmount = amountType(boxList)[1];
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[200]),
                    ),
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                        builder: (context, child) => Theme(
                          child: child!,
                          data: ThemeData().copyWith(
                              colorScheme: const ColorScheme.light(
                            primary: Colors.green,
                          )),
                        ),
                      );
                      if (newDate == null) {
                        startDate = DateTime.now();
                      }
                      setState(() => startDate = newDate!);
                    },
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(startDate),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[200]),
                    ),
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                        builder: (context, child) => Theme(
                          child: child!,
                          data: ThemeData().copyWith(
                              colorScheme: const ColorScheme.light(
                            primary: Colors.green,
                          )),
                        ),
                      );
                      if (newDate == null) {
                        endDate = DateTime.now();
                      }
                      setState(() => endDate = newDate!);
                    },
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(endDate),
                      style: const TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              boxList.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: mediaQueryHeight * 0.335),
                      child: const Text('No Transactions'),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: mediaQueryHeight * 0.35,
                          width: double.maxFinite,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: mediaQueryHeight * 0.03),
                            child: SfCircularChart(
                              tooltipBehavior: TooltipBehavior(
                                enable: true,
                                textStyle: const TextStyle(
                                  fontFamily: 'Prompt',
                                ),
                              ),
                              palette: [redTheme, blueTheme],
                              legend: Legend(
                                isVisible: true,
                                position: LegendPosition.bottom,
                                textStyle: const TextStyle(
                                  fontFamily: 'Prompt',
                                  fontSize: 13,
                                ),
                              ),
                              series: <CircularSeries>[
                                DoughnutSeries<Data, String>(
                                  radius: '90',
                                  innerRadius: '60',
                                  dataSource: getChartData(
                                    expenseAmount,
                                    ((incomeAmount) - (expenseAmount)),
                                  ),
                                  xValueMapper: (Data data, _) => data.datas,
                                  yValueMapper: (Data data, _) => data.values,
                                  dataLabelSettings: const DataLabelSettings(
                                    labelPosition:
                                        ChartDataLabelPosition.outside,
                                    isVisible: true,
                                    textStyle: TextStyle(
                                      fontFamily: 'Prompt',
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        VerticalSpace(height: mediaQueryHeight * 0.04),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Income',
                                      style: TextStyle(
                                          fontWeight: bold,
                                          fontSize: customFontSizeTitle)),
                                  const VerticalDivider(
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                  Text('Expenses',
                                      style: TextStyle(
                                          fontWeight: bold,
                                          fontSize: customFontSizeTitle)),
                                  const VerticalDivider(
                                      thickness: 1, color: Colors.black),
                                  Text(
                                    'Balance',
                                    style: TextStyle(
                                        fontWeight: bold,
                                        fontSize: customFontSizeTitle),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '₹$incomeAmount',
                                  style: TextStyle(
                                      fontWeight: bold,
                                      fontSize: customFontSizeTitle,
                                      color: greenTheme),
                                ),
                                const VerticalDivider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                Text(
                                  '₹$expenseAmount',
                                  style: TextStyle(
                                      fontWeight: bold,
                                      fontSize: customFontSizeTitle,
                                      color: redTheme),
                                ),
                                const VerticalDivider(
                                    thickness: 1, color: Colors.black),
                                Text(
                                  '₹${((incomeAmount) - (expenseAmount))}',
                                  style: TextStyle(
                                      fontWeight: bold,
                                      fontSize: customFontSizeTitle,
                                      color: blueTheme),
                                ),
                              ],
                            ),
                            VerticalSpace(height: mediaQueryHeight * 0.02),
                            Container(
                              width: double.maxFinite,
                              height: mediaQueryHeight * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: mediaQueryWidth * 0.055),
                                    child: myField,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: mediaQueryWidth * 0.03),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (myIcon.icon == Icons.search) {
                                              myIcon = const Icon(Icons.clear);
                                              myField = SizedBox(
                                                width: mediaQueryWidth * 0.7,
                                                height: mediaQueryHeight * 0.07,
                                                child: TextField(
                                                  onChanged: (value) {
                                                    searchInput = value;
                                                    setState(() {});
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Search here',
                                                    hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              setState(() {
                                                searchInput = '';
                                              });
                                              myIcon = const Icon(Icons.search);
                                              myField = const Text(
                                                  'All Transactions');
                                            }
                                          });
                                        },
                                        icon: myIcon),
                                  )
                                ],
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: categories.listenable(),
                              builder: (context, Box<Categories> cat, _) {
                                final traList = boxList
                                    .where((element) => element
                                        .categoryType.category
                                        .toLowerCase()
                                        .contains(searchInput.toLowerCase()))
                                    .toList();
                                return traList.isEmpty
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            top: mediaQueryHeight * 0.165),
                                        child: const Text(
                                            'No Transactions found :('),
                                      )
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onLongPress: () => showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    'Warning!',
                                                    style: TextStyle(
                                                        color: redTheme),
                                                  ),
                                                  content: const Text(
                                                      'Do you want to delete?'),
                                                  actions: [
                                                    TextButton(
                                                        child: const Text(
                                                          'Yes',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        onPressed: () {
                                                          tra.delete(
                                                              traList[index]
                                                                  .key);
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                    TextButton(
                                                      child: const Text(
                                                        'NO',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                            onTap:
                                                traList[index].categoryType.type
                                                    ? () => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                IncomeScreen(
                                                              currentKey:
                                                                  traList[index]
                                                                      .key,
                                                            ),
                                                          ),
                                                        )
                                                    : () => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ExpenseScreen(
                                                              currentKey:
                                                                  traList[index]
                                                                      .key,
                                                            ),
                                                          ),
                                                        ),
                                            child: CustomTransactionCard(
                                              color: traList[index]
                                                      .categoryType
                                                      .type
                                                  ? greenTheme
                                                  : redTheme,
                                              amount:
                                                  '₹${traList[index].amount}',
                                              category: traList[index]
                                                  .categoryType
                                                  .category,
                                              date: DateFormat('EEEE, d MMM')
                                                  .format(
                                                      traList[index].dateTime),
                                            ),
                                          );
                                        },
                                        itemCount: traList.length,
                                        separatorBuilder: (context, index) {
                                          return const SizedBox.shrink();
                                        },
                                      );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
            ],
          );
        },
      ),
    );
  }

  List<Data> getChartData(double totalIncome, double totalExpense) {
    final List<Data> chartData = [
      // Data('Income', 50000),
      Data('Expense', totalIncome),
      Data('Balance', totalExpense)
    ];
    return chartData;
  }
}
