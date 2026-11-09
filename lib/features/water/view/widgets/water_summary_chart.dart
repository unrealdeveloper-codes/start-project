import 'package:desa/features/water/controllers/water_intake_graph_controller.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WaterSummaryChart extends StatelessWidget {
  const WaterSummaryChart({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final controller = WaterIntakeGraphController.intance;
    final chartConfig = controller.waterIntake.chartConfig;
    final maxY = double.parse(chartConfig!.maxY.toString());
    final intervalVal = double.parse(chartConfig.interval.toString());
    final yAxisLabels = generateYAxisLabels(maxY, intervalVal);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: AspectRatio(
        aspectRatio: 1.3,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: maxY,
            backgroundColor: AppColor.cardBackGroundBlueColor.withOpacity(0.4),
            barTouchData: BarTouchData(enabled: false),
            titlesData: FlTitlesData(
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: width * 0.14,
                  interval: intervalVal,
                  getTitlesWidget: (value, meta) {
                    final int intValue = value.toInt();
                    return (intValue % chartConfig.interval! == 0 &&
                            intValue <= chartConfig.maxY!)
                        ? buildText(
                            yAxisLabels[intValue ~/ chartConfig.interval!])
                        : Container();
                  },
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    final data = chartConfig.data![index].day!.substring(0, 3);
                    return index >= 0 && index < chartConfig.data!.length
                        ? buildBelowText(data)
                        : Container();
                  },
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              horizontalInterval: intervalVal,
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                width: 2,
                color: AppColor.cardBackGroundBlueColor.withOpacity(0.2),
              ),
            ),
            barGroups: List.generate(
              chartConfig.data!.length,
              (index) => makeGroupData(
                index,
                double.parse(chartConfig.data![index].totalMl.toString()),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppColor.primaryColor3,
          width: 26,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: AppSizer.fontSize12,
        color: AppColor.bodyTextColor.withOpacity(0.6),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildBelowText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: AppSizer.fontSize12,
          color: AppColor.bodyTextColor.withOpacity(0.6),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper method to generate Y-axis labels
  List<String> generateYAxisLabels(double maxY, double interval) {
    List<String> labels = [];
    for (double i = 0; i <= maxY; i += interval) {
      labels.add('${i / 1000} L'); // Convert to "L" format
    }
    return labels;
  }
}
