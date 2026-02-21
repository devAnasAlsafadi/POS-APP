import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/widgets/table_card_widgets/table_click_handler.dart';

import '../../../../../core/enum/table_status.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../domain/entities/table_entity.dart';

class TableContent extends StatelessWidget {
  final TableEntity table;
  final Color color;
  final TableStatus status;

  const TableContent({super.key, required this.table, required this.color, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopRow(context),
          const SizedBox(height: 12),
          Row(
            children: [
              if (status == TableStatus.available)
                _QuickActionButton(icon: Icons.edit_calendar, onTap: () => TableClickHandler.showReservationDialog(context, table.id),),
              _QuickActionButton(
                icon: Icons.history,
                onTap: () => TableClickHandler.showTableHistory(context, table.id),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildStatusBadge(),
          const Spacer(),
          _buildFooter(),
        ],
      ),
    );
  }


  Widget _buildTopRow(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        table.id.toString().padLeft(2, '0'),
        style: AppTextStyles.h2.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.white
        ),
      ),
      Row(
        children: [

          const SizedBox(width: 8),
          _CapacityBadge(capacity: table.capacity),
        ],
      ),
    ],
  );

  Widget _buildStatusBadge() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
    child: Text(status.name.toUpperCase(), style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold)),
  );

  Widget _buildFooter() {
    if (status == TableStatus.billing || status == TableStatus.dining) {
      final total = table.currentOrder?.totalAmount.toStringAsFixed(2) ?? "0.00";
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("TOTAL", style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 8)),
          FittedBox(child: Text("\$$total", style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.w900))),
        ],
      );
    }
    return status == TableStatus.available ? _buildReady() : _buildWaiting();
  }

  Widget _buildReady() => const Text("READY", style: TextStyle(color: Colors.white38, fontSize: 10));
  Widget _buildWaiting() => Text("WAITING...", style: TextStyle(color: color.withValues(alpha: 0.5), fontSize: 9))
      .animate(onPlay: (c) => c.repeat()).shimmer(duration: 2.seconds);
}

class _CapacityBadge extends StatelessWidget {
  final int capacity;
  const _CapacityBadge({required this.capacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.person, size: 14, color: Colors.white.withValues(alpha: 0.5)),
          const SizedBox(width: 4),
          Text(
            '$capacity',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}


class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QuickActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Icon(icon, size: 18, color: Colors.white70),
      ),
    );
  }
}