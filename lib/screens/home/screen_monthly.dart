import 'package:flutter/material.dart';
import 'package:money_manager_app/main.dart';
// import 'package:money_manager_app/screens/home/screen_daily.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthlyScreen extends StatefulWidget {
  const MonthlyScreen({Key? key}) : super(key: key);

  @override
  State<MonthlyScreen> createState() => _MonthlyScreenState();
}

class _MonthlyScreenState extends State<MonthlyScreen> {
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: mediaQueryHeight * 0.03),
            child: Container(
              height: mediaQueryHeight * 0.3,
              width: double.maxFinite,
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
                  Text('50000',
                      style: TextStyle(
                          fontWeight: bold,
                          fontSize: customFontSizeTitle,
                          color: greenTheme)),
                  const VerticalDivider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Text('20000',
                      style: TextStyle(
                          fontWeight: bold,
                          fontSize: customFontSizeTitle,
                          color: redTheme)),
                  const VerticalDivider(thickness: 1, color: Colors.black),
                  Text('30000',
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
                    title: const Text(
                      'Income, Expenses details of this month',
                      style:
                          TextStyle(color: Colors.black, fontFamily: 'Prompt'),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: mediaQueryHeight * 0.01,
                            left: mediaQueryWidth * 0.025,
                            right: mediaQueryWidth * 0.025),
                        child: Row(
                          children: [
                            Text('January'),
                            HorizontalSpace(width: mediaQueryWidth * 0.22),
                            Text(
                              'Income',
                              style: TextStyle(color: greenTheme),
                            ),
                            HorizontalSpace(width: mediaQueryWidth * 0.17),
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
                          HorizontalSpace(width: mediaQueryWidth * 0.395),
                          Text(
                            '50000',
                            style: TextStyle(color: greenTheme),
                          ),
                          HorizontalSpace(width: mediaQueryWidth * 0.20),
                          Text(
                            '20000',
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
                                  value: '- 5000'),
                              CustomListTile(
                                  title: 'Food and Drinks',
                                  leading: Icon(
                                    Icons.local_restaurant_outlined,
                                    color: Colors.red,
                                  ),
                                  value: '- 3000'),
                              CustomListTile(
                                  title: 'Transportation',
                                  leading: Icon(
                                    Icons.local_taxi,
                                    color: Colors.black,
                                  ),
                                  value: '- 1500'),
                              CustomListTile(
                                  title: 'Entertainment',
                                  leading: Icon(
                                    Icons.celebration_sharp,
                                    color: Colors.orange,
                                  ),
                                  value: '- 3500'),
                              CustomListTile(
                                  title: 'Debt Payments',
                                  leading: Icon(
                                    Icons.money_off_csred_sharp,
                                    color: Colors.green,
                                  ),
                                  value: '- 4000'),
                              CustomListTile(
                                  title: 'Personal Care',
                                  leading: Icon(
                                    Icons.emoji_emotions_outlined,
                                    color: Colors.yellow,
                                  ),
                                  value: '- 3000'),
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
      Data('Income', 50000),
      Data('Expense', 20000),
      Data('Balance', 30000)
    ];
    return chartData;
  }
}

class Data {
  Data(this.datas, this.values);
  final String datas;
  final int values;
}
