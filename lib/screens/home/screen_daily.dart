import 'package:flutter/material.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/widgets/custom_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DailyScreen extends StatefulWidget {
  const DailyScreen({Key? key}) : super(key: key);

  @override
  State<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
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
      // physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
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
                  ),
                ),
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
                            fontWeight: bold, fontSize: customFontSizeTitle)),
                    const VerticalDivider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Text('Expenses',
                        style: TextStyle(
                            fontWeight: bold, fontSize: customFontSizeTitle)),
                    const VerticalDivider(thickness: 1, color: Colors.black),
                    Text(
                      'Balance',
                      style: TextStyle(
                          fontWeight: bold, fontSize: customFontSizeTitle),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '',
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
                    '',
                    style: TextStyle(
                        fontWeight: bold,
                        fontSize: customFontSizeTitle,
                        color: redTheme),
                  ),
                  const VerticalDivider(thickness: 1, color: Colors.black),
                  Text(
                    '',
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
                      style:
                          TextStyle(color: Colors.black, fontFamily: 'Prompt'),
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
                            CustomCard(
                              dueDate: '05-12-2021',
                              circleAvatarText: 'KB',
                              title: 'Electricity bill',
                              payMent: 2000,
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
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CustomTransactionCard(
                    amount: '55',
                    category: 'food',
                    date: '5/55/555',
                  );
                },
                itemCount: 5,
                separatorBuilder: (context, index) {
                  return Divider();
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
      ),
    );
  }

  List<Data> getChartData() {
    final List<Data> chartData = [
      Data('Income', 2000),
      Data('Expense', 1000),
      Data('Balance', 1000)
    ];
    return chartData;
  }
}

class Data {
  Data(this.datas, this.values);
  final String datas;
  final int values;
}
