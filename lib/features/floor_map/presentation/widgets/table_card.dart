import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/core/developer.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/main_screen_controller.dart';

import '../../../../core/enum/table_status.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/table_entity.dart';

class TableCard extends StatelessWidget {
  final TableEntity table;
  final MainScreenController controller;
  final Function update;

  const   TableCard({super.key, required this.table, required this.controller, required this.update});

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(table.status);
    bool isWaiting = table.status == TableStatus.waiting;

    return GestureDetector(
      onTap: () {
        if(table.status == TableStatus.available) {
          AppLogger.info("Tabled Clicked");
          controller.goToOrderDetails(table,update);
        } else {
          // Handle viewing details for occupied/reserved tables
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: statusColor.withValues(alpha: 0.5), width: 2),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ]
        ),
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Center(
              child: Opacity(
                opacity: 0.05,
                child: Icon(Icons.table_bar, size: 60, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(table.tableNumber, style: AppTextStyles.h2.copyWith(fontSize: 24,fontWeight: FontWeight.w800)),
                      Row(
                        children: [
                          Icon(Icons.people_alt_outlined, size: 16, color: Colors.grey[400]),
                          const SizedBox(width: 4),
                          Text('${table.chairCount}', style: TextStyle(color: Colors.grey[400])),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(table.status.name.toUpperCase(), style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  const Spacer(),
                  if (isWaiting) _buildTimer(statusColor),
                  if (table.status == TableStatus.billing || table.status == TableStatus.dining)
                    _buildTotalAmount(statusColor),
                  if (table.status == TableStatus.available)
                    const Text("Ready", style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            )
          ],
        )
      ),
    );
  }




  Widget _buildTimer(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time_filled, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            "09:08",
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalAmount(Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "TOTAL",
          style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 1.1),
        ),
        const SizedBox(height: 2),
        Text(
          "\$${table.totalAmount?.toStringAsFixed(2) ?? "0.00"}",
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }


  Color _getStatusColor(TableStatus status) {
    switch (status) {
      case TableStatus.available: return AppColors.available;
      case TableStatus.waiting: return AppColors.waiting;
      case TableStatus.dining: return AppColors.dining;
      case TableStatus.billing: return AppColors.billing;
      case TableStatus.reserved: return AppColors.reserved;
    }
  }
}