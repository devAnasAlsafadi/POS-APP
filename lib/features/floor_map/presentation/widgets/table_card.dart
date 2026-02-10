import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/main_screen_controller.dart';
import '../../../../core/enum/table_status.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/table_entity.dart';

class TableCard extends StatelessWidget {
  final TableEntity table;
  final MainScreenController controller;
  final Function update;

  const TableCard({
    super.key,
    required this.table,
    required this.controller,
    required this.update,
  });

  @override
  Widget build(BuildContext context) {
    final TableStatus currentStatus = _mapStringToStatus(table.status);
    final Color statusColor = _getStatusColor(currentStatus);

    return GestureDetector(
      onTap: () {
        controller.goToOrderDetails(table, update);
      },
      child: _buildStaticContainer(statusColor, currentStatus),
    );
  }

  Widget _buildStaticContainer(Color color, TableStatus status) {
    return Container(
      decoration: _buildDecoration(color, 1.0),
      child: _buildCardContent(color, status),
    );
  }

  Widget _buildPulsingContainer(Color color, TableStatus status) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.2, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      builder: (context, opacity, child) {
        return Container(
          decoration: _buildDecoration(color, opacity),
          child: _buildCardContent(color, status),
        );
      },
      onEnd: () {},
    );
  }

  BoxDecoration _buildDecoration(Color color, double opacity) {
    return BoxDecoration(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: opacity), width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: opacity * 0.2),
          blurRadius: 8,
          spreadRadius: 1,
        ),
      ],
    );
  }

  Widget _buildCardContent(Color color, TableStatus status) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "0${table.id}",
                style: AppTextStyles.h2.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.people_alt_outlined,
                    size: 16,
                    color: AppColors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${table.capacity}',
                    style: const TextStyle(color: AppColors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            status.name.toUpperCase(),
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const Spacer(),
          if (status == TableStatus.billing || status == TableStatus.dining)
            _buildTotalAmount(color),
          if (status == TableStatus.available)
            const Text(
              "Ready",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          if (status == TableStatus.waiting)
            Text(
              "WAITING FOR ORDER...",
              style: TextStyle(
                color: color.withValues(alpha: 0.7),
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTotalAmount(Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("TOTAL", style: TextStyle(color: Colors.grey, fontSize: 9)),
        Text(
          "\$${table.currentOrderId != null ? '120.50' : '0.00'}", // مثال مؤقت للمبلغ
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  TableStatus _mapStringToStatus(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return TableStatus.available;
      case 'occupied':
        return TableStatus.occupied;
      case 'reserved':
        return TableStatus.reserved;
      case 'dining':
        return TableStatus.dining;
      case 'billing':
        return TableStatus.billing;
      default:
        return TableStatus.available;
    }
  }

  Color _getStatusColor(TableStatus status) {
    switch (status) {
      case TableStatus.available:
        return AppColors.available;
      case TableStatus.occupied:
        return AppColors.occupied;
      case TableStatus.waiting:
        return AppColors.dining;
      case TableStatus.dining:
        return AppColors.dining;
      case TableStatus.billing:
        return AppColors.billing;
      case TableStatus.reserved:
        return AppColors.reserved;
    }
  }
}
