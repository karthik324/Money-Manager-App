import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CalanderScreen extends StatefulWidget {
  const CalanderScreen({Key? key}) : super(key: key);

  @override
  State<CalanderScreen> createState() => _CalanderScreenState();
}

class _CalanderScreenState extends State<CalanderScreen> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );
  late List<Data> _chartData;
  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    final start = dateRange.start;
    final end = dateRange.end;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[200])),
                  onPressed: () {
                    pickDateRange();
                  },
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(start),
                    style: const TextStyle(color: Colors.black),
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[200])),
                  onPressed: () {
                    pickDateRange();
                  },
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(end),
                    style: const TextStyle(color: Colors.black),
                  ))
            ],
          ),
          Container(
            height: mediaQueryHeight * 0.3,
            width: double.maxFinite,
            child: Padding(
              padding: EdgeInsets.only(top: mediaQueryHeight * 0.03),
              child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(
                    enable: true,
                    textStyle: const TextStyle(
                      fontFamily: 'Prompt',
                    )),
                palette: [greenTheme, redTheme, blueTheme],
                legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    textStyle: const TextStyle(
                      fontFamily: 'Prompt',
                      fontSize: 13,
                    )),
                series: <CircularSeries>[
                  DoughnutSeries<Data, String>(
                      // startAngle: 100,
                      // endAngle: 10,
                      radius: '90',
                      innerRadius: '60',
                      dataSource: _chartData,
                      xValueMapper: (Data data, _) => data.datas,
                      yValueMapper: (Data data, _) => data.values,
                      dataLabelSettings: const DataLabelSettings(
                          labelPosition: ChartDataLabelPosition.outside,
                          isVisible: true,
                          textStyle: TextStyle(
                            fontFamily: 'Prompt',
                            fontSize: 11,
                          )))
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
                            fontWeight: bold, fontSize: customFontSizeTitle)),
                    const VerticalDivider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Text('Expenses',
                        style: TextStyle(
                            fontWeight: bold, fontSize: customFontSizeTitle)),
                    const VerticalDivider(thickness: 1, color: Colors.black),
                    Text('Balance',
                        style: TextStyle(
                            fontWeight: bold, fontSize: customFontSizeTitle)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('600000',
                      style: TextStyle(
                          fontWeight: bold,
                          fontSize: customFontSizeTitle,
                          color: greenTheme)),
                  const VerticalDivider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Text('200000',
                      style: TextStyle(
                          fontWeight: bold,
                          fontSize: customFontSizeTitle,
                          color: redTheme)),
                  const VerticalDivider(thickness: 1, color: Colors.black),
                  Text('400000',
                      style: TextStyle(
                          fontWeight: bold,
                          fontSize: customFontSizeTitle,
                          color: blueTheme)),
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
                    title: Text(
                      'Income, Expenses details from ${DateFormat('dd/MM/yyyy').format(start)} to ${DateFormat('dd/MM/yyyy').format(end)}',
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'Prompt'),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: mediaQueryHeight * 0.01,
                            left: mediaQueryWidth * 0.025,
                            right: mediaQueryWidth * 0.025),
                        child: Row(
                          children: [
                            const Text('Selected Range'),
                            HorizontalSpace(width: mediaQueryWidth * 0.1),
                            Text(
                              'Income',
                              style: TextStyle(color: greenTheme),
                            ),
                            HorizontalSpace(width: mediaQueryWidth * 0.145),
                            Text(
                              'Expense',
                              style: TextStyle(color: redTheme),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          HorizontalSpace(width: mediaQueryWidth * 0.41),
                          Text(
                            '600000',
                            style: TextStyle(color: greenTheme),
                          ),
                          HorizontalSpace(width: mediaQueryWidth * 0.14),
                          Text(
                            '200000',
                            style: TextStyle(color: redTheme),
                          ),
                        ],
                      ),
                      Card(
                        child: Theme(
                          data: ThemeData(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            title: Text(
                              'Details',
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'Prompt'),
                            ),
                            children: [
                              CustomListTile(
                                  title: 'Shopping',
                                  leading: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.blue,
                                  ),
                                  value: '- 40000'),
                              CustomListTile(
                                  title: 'Food and Drinks',
                                  leading: Icon(
                                    Icons.local_restaurant_outlined,
                                    color: Colors.red,
                                  ),
                                  value: '- 30000'),
                              CustomListTile(
                                  title: 'Transportation',
                                  leading: Icon(
                                    Icons.local_taxi,
                                    color: Colors.black,
                                  ),
                                  value: '- 15000'),
                              CustomListTile(
                                  title: 'Entertainment',
                                  leading: Icon(
                                    Icons.celebration_sharp,
                                    color: Colors.orange,
                                  ),
                                  value: '- 350000'),
                              CustomListTile(
                                  title: 'Debt Payments',
                                  leading: Icon(
                                    Icons.money_off_csred_sharp,
                                    color: Colors.green,
                                  ),
                                  value: '- 40000'),
                              CustomListTile(
                                  title: 'Personal Care',
                                  leading: Icon(
                                    Icons.emoji_emotions_outlined,
                                    color: Colors.yellow,
                                  ),
                                  value: '- 30000'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.maxFinite,
            height: mediaQueryHeight * 0.25,
            child: CustomCard(
              dueDate: '05-12-2021',
              circleAvatarText: 'KB',
              title: 'Electricity bill',
              payMent: 2000,
            ),
          ),
        ],
      ),
    );
  }

  List<Data> getChartData() {
    final List<Data> chartData = [
      Data('Income', 600000),
      Data('Expense', 200000),
      Data('Balance', 400000)
    ];
    return chartData;
  }

  pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (newDateRange == null) return;
    setState(() => dateRange = newDateRange);
  }
}

class Data {
  Data(this.datas, this.values);
  final String datas;
  final int values;
}
