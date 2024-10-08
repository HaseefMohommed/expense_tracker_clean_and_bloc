import 'package:expesne_tracker_app/core/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryChart extends StatelessWidget {
  final List<ChartData> data;

  const CategoryChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppTheme.secondaryPaleColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  startDegreeOffset: -90,
                  sections: data
                      .map((item) => PieChartSectionData(
                            color: item.color,
                            value: item.value,
                            title: '${item.value.toStringAsFixed(0)}%',
                            radius: 50,
                            titleStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: data
                  .map((item) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: item.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(item.category),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final double value;
  final Color color;
  final String category;

  ChartData({
    required this.value,
    required this.color,
    required this.category,
  });
}
