import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/db/database.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/screens/income%20expense%20reminder/screen_expense.dart';
import 'package:money_manager_app/screens/income%20expense%20reminder/screen_income.dart';
import 'package:money_manager_app/screens/income%20expense%20reminder/screen_set_reminder.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

List<double> amountType(List<Transactions> list) {
  double incomeAmount = 0;
  double expenseAmount = 0;
  List<double> amountList = [];
  // print(list.length);
  for (int i = 0; i < list.length; i++) {
    // print(list[i].amount);
    // print(list[i].categoryType.type);
    if (list[i].categoryType.type == true) {
      // print(list[i].amount);
      incomeAmount += list[i].amount;
      // print(incomeAmount);
    } else {
      expenseAmount += list[i].amount;
    }
  }
  amountList.add(incomeAmount);
  amountList.add(expenseAmount);
  return amountList;
}

class DailyScreen extends StatefulWidget {
  const DailyScreen({Key? key}) : super(key: key);

  @override
  State<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  //  List<Data> _chartData ;
  late Box<Categories> categories;
  late Box<Transactions> transactions;
  late Box<ReminderDb> reminder;
  Icon myIcon = const Icon(Icons.search);
  Widget myField = const Text("All Transactions");
  String searchInput = "";

  @override
  void initState() {
    categories = Hive.box<Categories>(categoryBox);
    transactions = Hive.box<Transactions>(transactionBox);
    reminder = Hive.box<ReminderDb>(reminderBox);
    // _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      // physics: const NeverScrollableScrollPhysics(),
      child: ValueListenableBuilder(
        valueListenable: transactions.listenable(),
        builder: (context, Box<Transactions> tra, _) {
          List<Transactions> boxList = tra.values.toList();
          double incomeAmount = amountType(boxList)[0];
          double expenseAmount = amountType(boxList)[1];
          // print(incomeAmount);
          return boxList.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: mediaQueryHeight * 0.4),
                  child: Column(
                    children: const [
                      Text('No Transactions Yet'),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Container(
                      height: mediaQueryHeight * 0.35,
                      width: double.maxFinite,
                      child: Padding(
                        padding: EdgeInsets.only(top: mediaQueryHeight * 0.03),
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
                              // startAngle: 100,
                              // endAngle: 10,
                              radius: '90',
                              innerRadius: '60',
                              dataSource: getChartData(
                                expenseAmount,
                                ((incomeAmount) - (expenseAmount)),
                              ),
                              xValueMapper: (Data data, _) => data.datas,
                              yValueMapper: (Data data, _) => data.values,
                              dataLabelSettings: const DataLabelSettings(
                                labelPosition: ChartDataLabelPosition.outside,
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
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        Card(
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Theme(
                            data: ThemeData(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              title: const Text(
                                'Remind me a Payment',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Prompt'),
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: mediaQueryWidth * 0.025,
                                      right: mediaQueryWidth * 0.025),
                                  child: Column(
                                    children: [
                                      // const Text('Today'),
                                      // HorizontalSpace(width: mediaQueryWidth * 0.24),
                                      // Text(
                                      //   'Income',
                                      //   style: TextStyle(color: greenTheme),
                                      // ),
                                      // HorizontalSpace(width: mediaQueryWidth * 0.19),
                                      // Text(
                                      //   'Expense',
                                      //   style: TextStyle(color: redTheme),
                                      // ),
                                      ValueListenableBuilder(
                                        valueListenable: reminder.listenable(),
                                        builder: (context,
                                            Box<ReminderDb> reminder, _) {
                                          final remList =
                                              reminder.values.toList();
                                          return remList.isEmpty
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      top: mediaQueryHeight *
                                                          0.02,
                                                      bottom: mediaQueryHeight *
                                                          0.02),
                                                  child: Text(
                                                    'No Reminders Added',
                                                    style: TextStyle(
                                                        fontWeight: bold),
                                                  ),
                                                )
                                              : ListView.separated(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    return GestureDetector(
                                                      onLongPress: () =>
                                                          showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Warning!',
                                                                style: TextStyle(
                                                                    color:
                                                                        redTheme)),
                                                            content: const Text(
                                                                'Do you want to delete?'),
                                                            actions: [
                                                              TextButton(
                                                                  child:
                                                                      const Text(
                                                                    'Yes',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    reminder.delete(
                                                                        remList[index]
                                                                            .key);
                                                                    Navigator.pop(
                                                                        context);
                                                                  }),
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                  'NO',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context),
                                                              )
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                      onTap: () =>
                                                          Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              SetReminderScreen(
                                                            currentKey:
                                                                remList[index]
                                                                    .key,
                                                          ),
                                                        ),
                                                      ),
                                                      child: CustomCard(
                                                        dueDate: DateFormat(
                                                                'dd/MM/yyyy')
                                                            .format(
                                                                remList[index]
                                                                    .dateTime),
                                                        circleAvatarText: remList[
                                                                    index]
                                                                .title[0] +
                                                            remList[index]
                                                                .title
                                                                .substring(remList[
                                                                            index]
                                                                        .title
                                                                        .length -
                                                                    1),
                                                        title: remList[index]
                                                            .title,
                                                        payMent: remList[index]
                                                            .amount
                                                            .toInt(),
                                                      ),
                                                    );
                                                  }),
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const SizedBox
                                                        .shrink();
                                                  },
                                                  itemCount: remList.length);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                // const Divider(
                                //   thickness: 1,
                                //   color: Colors.black,
                                // ),
                                // Row(
                                //   children: [
                                //     HorizontalSpace(width: mediaQueryWidth * 0.395),
                                //     Text(
                                //       '2000',
                                //       style: TextStyle(color: greenTheme),
                                //     ),
                                //     HorizontalSpace(width: mediaQueryWidth * 0.24),
                                //     Text(
                                //       '1000',
                                //       style: TextStyle(color: redTheme),
                                //     ),
                                //   ],
                                // ),
                                // Card(
                                //   child: Theme(
                                //     data: ThemeData(dividerColor: Colors.transparent),
                                //     child: ExpansionTile(
                                //       title: Text(
                                //         'Details',
                                //         style: TextStyle(
                                //             color: Colors.black, fontFamily: 'Prompt'),
                                //       ),
                                //       children: [
                                //         CustomListTile(
                                //             title: 'Shopping',
                                //             leading: Icon(
                                //               Icons.shopping_cart,
                                //               color: Colors.blue,
                                //             ),
                                //             value: '- 400'),
                                //         CustomListTile(
                                //             title: 'Food and Drinks',
                                //             leading: Icon(
                                //               Icons.local_restaurant_outlined,
                                //               color: Colors.red,
                                //             ),
                                //             value: '- 300'),
                                //         CustomListTile(
                                //             title: 'Transportation',
                                //             leading: Icon(
                                //               Icons.local_taxi,
                                //               color: Colors.black,
                                //             ),
                                //             value: '- 300'),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        VerticalSpace(height: mediaQueryHeight * 0.01),
                        Container(
                          width: double.maxFinite,
                          height: mediaQueryHeight * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          myField = Container(
                                            width: double.maxFinite,
                                            height: mediaQueryHeight * 0.07,
                                            child: TextField(
                                              onChanged: (value) {
                                                searchInput = value;
                                                setState(() {});
                                              },
                                              decoration: const InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                hintText: 'Search here',
                                                hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          );
                                        } else {
                                          setState(() {
                                            searchInput = '';
                                          });
                                          myIcon = const Icon(Icons.search);
                                          myField =
                                              const Text('All Transactions');
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
                            // final catList = cat.values.toList();
                            final traList = tra.values
                                .toList()
                                .where((element) => element
                                    .categoryType.category
                                    .toLowerCase()
                                    .contains(searchInput.toLowerCase()))
                                .toList();
                            return traList.isEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        top: mediaQueryHeight * 0.165),
                                    child:
                                        const Text('No Transactions found :('),
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
                                                style:
                                                    TextStyle(color: redTheme),
                                              ),
                                              content: const Text(
                                                  'Do you want to delete?'),
                                              actions: [
                                                TextButton(
                                                    child: const Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      tra.delete(
                                                          traList[index].key);
                                                      Navigator.pop(context);
                                                    }),
                                                TextButton(
                                                  child: const Text(
                                                    'NO',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                        onTap: traList[index].categoryType.type
                                            ? () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        IncomeScreen(
                                                      currentKey:
                                                          traList[index].key,
                                                    ),
                                                  ),
                                                )
                                            : () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ExpenseScreen(
                                                      currentKey:
                                                          traList[index].key,
                                                    ),
                                                  ),
                                                ),
                                        child: CustomTransactionCard(
                                          color:
                                              traList[index].categoryType.type
                                                  ? greenTheme
                                                  : redTheme,
                                          amount: '₹${traList[index].amount}',
                                          category: traList[index]
                                              .categoryType
                                              .category,
                                          date: DateFormat('EEEE, d MMM')
                                              .format(traList[index].dateTime),
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
                      // ),
                      // ListView.separated(
                      //   physics: NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   itemBuilder: (context, index) {
                      //     return CustomTransactionCard(
                      //       amount: values[index].amount.toString(),
                      //       category: values[index].categories.expenseCategory,
                      //       date: values[index].dateTime.toString(),
                      //     );
                      //   },
                      //   itemCount: values.length,
                      //   separatorBuilder: (context, index) {
                      //     return Divider();
                      //   },
                      // ),
                      // Container(
                      //   width: double.maxFinite,
                      //   height: mediaQueryHeight * 0.30,
                      //   child: CustomCard(
                      //     dueDate: '05-12-2021',
                      //     circleAvatarText: 'KB',
                      //     title: 'Electricity bill',
                      //     payMent: 2000,
                      //   ),
                    )
                  ],
                );
        },
      ),
    );
  }

  List<Data> getChartData(double income, double expense) {
    final List<Data> chartData = [
      // Data('Income', 2000),
      Data('Expense', income),
      Data('Balance', expense)
    ];
    return chartData;
  }
}

class Data {
  Data(this.datas, this.values);
  final String datas;
  final double values;
}
