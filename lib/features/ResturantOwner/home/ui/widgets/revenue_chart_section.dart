import 'package:delveria/core/helper/lists.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RevenueChartSection extends StatelessWidget {
  const RevenueChartSection({super.key, required this.data});
  final List<int> data;

  List<FlSpot> _buildSpots() {
    if (data.isNotEmpty) {
      // Map each int to FlSpot, using its index as x and value as y
      return List<FlSpot>.generate(
        data.length,
        (index) => FlSpot(index.toDouble(), data[index].toDouble()),
      );
    } else {
      // Default demo data
      return [
        FlSpot(-1, 2),
        FlSpot(0, 3),
        FlSpot(1, 2.5),
        FlSpot(2, 4),
        FlSpot(3, 3.5),
        FlSpot(4, 5),
        FlSpot(5, 4),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('revenue'.tr(), style: TextStyles.bimini16W700),
                  SizedBox(height: 4),
                ],
              ),
              Container(
                width: 61.w,
                height: 26.h,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.lightGreySecond),
                ),
                child: Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dialy.tr(),
                      style: TextStyles.bimini13W400Grey,
                    ),
                    Icon(Icons.keyboard_arrow_down, size: 13.sp),
                  ],
                ),
              ),
              // Text(
              //  AppStrings.seeDetails,
              //   style: TextStyles.bimini13W700Deafult.copyWith(
              //     color: AppColors.primaryDeafult,
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 120.h,
            child: Stack(
              children: [
                Positioned.fill(
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() >= 0 &&
                                  value.toInt() < AppLists.daysOfWeek.length) {
                                return Text(
                                  AppLists.daysOfWeek[value.toInt()],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[500],
                                  ),
                                );
                              }
                              return Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: _buildSpots(),
                          isCurved: true,
                          color: Colors.orange,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: true,
                            checkToShowDot: (
                              FlSpot spot,
                              LineChartBarData barData,
                            ) {
                              return spot.x == 2 && spot.y == 4;
                            },
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 6,
                                color: Colors.orange,
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              );
                            },
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xfffb6d3a), Colors.white],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //   Positioned(
                //     left: 50 + 3 * 30.0,
                //     top: 0,
                //     child: Column(
                //       children: [
                //         Container(
                //           padding: EdgeInsets.symmetric(
                //             horizontal: 8,
                //             vertical: 4,
                //           ),
                //           decoration: BoxDecoration(
                //             color: Colors.black87,
                //             borderRadius: BorderRadius.circular(4),
                //           ),
                //           child: Text(
                //             '500 L.E',
                //             style: TextStyle(color: Colors.white, fontSize: 12),
                //           ),
                //         ),
                //         SizedBox(height: 4),
                //       ],
                //     ),
                //   ),
                // ],
              ]
            ),
          ),
        ],
      ),
    );
  }
}
