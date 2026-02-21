import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/main_screen_controller.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/widgets/table_card_widgets/table_click_handler.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/widgets/table_card_widgets/table_content.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/widgets/table_card_widgets/table_glow_wrapper.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/widgets/table_card_widgets/table_style.dart';
import '../../../../core/extensions/table_status_x.dart';
import '../../domain/entities/table_entity.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TableCard extends StatelessWidget {
  final TableEntity table;
  final MainScreenController controller;
  final VoidCallback update;

  const TableCard({super.key, required this.table, required this.controller, required this.update});

  @override
  Widget build(BuildContext context) {
    final status = table.currentStatus;
    final color = table.statusColor;

    return GestureDetector(
      onTap: () => TableClickHandler.handle(context, table, controller, update),
      child: TableGlowWrapper(
        shouldGlow: table.shouldGlow,
        statusColor: color,
        child: Hero(
          tag: 'table_hero_${table.id}',
          flightShuttleBuilder: _heroFlightShuttle,
          child: AnimatedContainer(
            duration: 500.ms,
            decoration: TableStyles.modernDecoration(color),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  TableBackgroundNumber(id: table.id),
                  TableContent(table: table, color: color, status: status),
                ],
              ),
            ),
          ),
        ),
      ),
    ).
    animate()
     .fadeIn(duration: 300.ms)
        .scale(begin: const Offset(0.95, 0.95));
  }



  Widget _heroFlightShuttle(BuildContext flightContext, Animation<double> animation,
      HeroFlightDirection flightDirection, BuildContext fromHeroContext, BuildContext toHeroContext) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }
}