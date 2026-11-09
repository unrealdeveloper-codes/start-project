import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CircularProgressGauge extends StatelessWidget {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final Color shadowColor;

  const CircularProgressGauge({
    super.key,
    required this.progress, // Value from 0 to 1 (e.g., 0.86 for 86%)
    this.backgroundColor = AppColor.greyTextColor,
    this.progressColor = AppColor.cardGreen,
    this.shadowColor = AppColor.cardGreen,
  });

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          startAngle: 150,
          // Start from the bottom-left (225 degrees)
          endAngle: 30,
          // End at the bottom-right (135 degrees) for 75% of a circle
          radiusFactor: AppSizer.width * 0.0033,

          // radiusFactor: 1.2,
          showTicks: false,
          showLabels: false,
          axisLineStyle: AxisLineStyle(
            // thickness: 0.02,
            thickness: AppSizer.width * 0.00012,
            color: backgroundColor.withOpacity(0.4),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: <GaugePointer>[
            RangePointer(
              // value: progress * 100,
              value: progress,
              // `progress` as percentage (0-100)
              // width: 0.07,
              width: AppSizer.width * 0.00016,
              sizeUnit: GaugeSizeUnit.factor,
              color: progressColor,
              cornerStyle: CornerStyle.bothCurve,
              gradient: SweepGradient(
                colors: [progressColor, progressColor],
                stops: [0.5, 1.0],
              ),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyManropeText(
                    text: "Consumed",
                    color: AppColor.greyTextColor,
                    fontSize: AppSizer.fontSize8,
                  ),
                  Center(
                    child: MyManropeText(
                      text: progress >= 100.0
                          ? "100%"
                          : progress == 0.0
                              ? "0%"
                              : "${progress.toStringAsFixed(1)}%",
                      color: AppColor.primaryColor1,
                      fontSize: AppSizer.fontSize22,
                      maxLines: 1,
                    ),
                  ),

                  // Center(
                  //     child: MyManropeText(
                  //       text: "${progress.toString()}%",
                  // //  text: "${(progress)}%",
                  //   color: AppColor.primaryColor1,
                  //   fontSize: AppSizer.fontSize22,
                  //   maxLines: 1,
                  // )),
                ],
              ),
              positionFactor: 0.02,
              angle: 90,
            ),
          ],
        ),
      ],
    );
  }
}
