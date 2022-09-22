import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:shopify_admin/class/model/chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineCharts extends StatelessWidget {
  final List<ChartData> data;
  final double width;
  const LineCharts({
    Key? key,
    required this.data,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: width,
        height: 50,
        color: Colors.white,
        child: SfCartesianChart(
          //title: ChartTitle(text: "Expense trends in day"),
          enableAxisAnimation: true,
          plotAreaBorderColor: Colors.transparent,
          series: <ChartSeries>[
            LineSeries<ChartData, int>(
              yAxisName: "Earning",
              xAxisName: "Date",
              name: 'Total sales',
              dataSource: data,
              xValueMapper: (ChartData chartData, _) => chartData.date.day,
              yValueMapper: (ChartData chartData, _) => chartData.earning,
              dataLabelSettings: DataLabelSettings(
                  isVisible: true, color: Colors.red.shade600, angle: 50),
            ),
          ],
          primaryXAxis: CategoryAxis(
            placeLabelsNearAxisLine: false,
            isVisible: true,
            plotOffset: 10,
          ),
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.simpleCurrency(
                decimalDigits: 0, name: "₦", locale: "en-us"),
            labelAlignment: LabelAlignment.center,
            axisLine: const AxisLine(
                color: Colors.transparent, dashArray: [2.0, 1.0]),
            axisBorderType: AxisBorderType.withoutTopAndBottom,
            isVisible: true,
          ),
        ),
      ),
    );
  }
}
