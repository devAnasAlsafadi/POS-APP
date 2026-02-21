import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pos_wiz_tech/features/reservations/presentation/widgets/reservation_action_dialog.dart';

import '../../../../../core/enum/table_status.dart';
import '../../../../../core/extensions/table_status_x.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../reservations/presentation/blocs/reservations_bloc.dart';
import '../../../../reservations/presentation/widgets/reservation_dialog.dart';
import '../../../domain/entities/table_entity.dart';
import '../../screens/main_screen/main_screen_controller.dart';

class TableClickHandler {
  static void handle(BuildContext context, TableEntity table, MainScreenController controller, VoidCallback update) {
    if (table.currentStatus == TableStatus.reserved) {
      _showReservationActions(context, table);
      return;
    }

    controller.goToOrderDetails(table, update);
  }

  static void _showReservationActions(BuildContext context, TableEntity table) {
    showDialog(
      context: context,
      builder: (ctx) => ReservationActionsDialog(table: table,reservationsBloc: context.read<ReservationsBloc>()),
    );
  }

  static void showReservationDialog(BuildContext context, int tableId) {
    final reservationsBloc = context.read<ReservationsBloc>();
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: reservationsBloc,
        child: ReservationDialog(tableId: tableId),
      ),
    );
  }





  static void showTableHistory(BuildContext context, int tableId) {
    // TODO: فتح ديالوج السجل
  }



}
