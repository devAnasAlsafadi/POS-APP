import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:bloc/bloc.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../floor_map/domain/entities/table_entity.dart';
import '../../../floor_map/presentation/widgets/table_card_widgets/custom_dialog_button.dart';
import '../blocs/reservations_bloc.dart';

class ReservationActionsDialog extends StatelessWidget {
  final TableEntity table;
  final ReservationsBloc reservationsBloc;
  const ReservationActionsDialog({
    super.key,
    required this.table,
    required this.reservationsBloc,
  });


  @override
  Widget build(BuildContext context) {
    final res = table.activeReservation;

    return AlertDialog(
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          const Icon(Icons.event_available, color: AppColors.reserved, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Reserved Table", style: AppTextStyles.h2),
                Text("Table #${table.id.toString().padLeft(2, '0')}", 
                    style: AppTextStyles.bodySecondary),
              ],
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (res != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.reserved.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.reserved.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    _buildInfoRow(Icons.person, "Guest", res.guestName),
                    const SizedBox(height: 12),
                    _buildInfoRow(Icons.phone, "Phone", res.phone),
                    const SizedBox(height: 12),
                    _buildInfoRow(Icons.access_time, "Time",
                        "${res.time.hour.toString().padLeft(2, '0')}:${res.time.minute.toString().padLeft(2, '0')}"),
                    const SizedBox(height: 12),
                    _buildInfoRow(Icons.group, "Guests", "${res.guestsCount} people"),
                    if (res.specialRequests != null && res.specialRequests!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.notes, "Notes", res.specialRequests!),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
            // Guest Arrived Button
            CustomDialogBtn(
              icon: Icons.check_circle,
              label: "GUEST ARRIVED",
              color: AppColors.success,
              onTap: () {
                if (res != null) {
                  reservationsBloc.add(CheckInReservationEvent(id: res.id));
                }
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 12),
            // Cancel Reservation Button
            CustomDialogBtn(
              icon: Icons.cancel,
              label: "CANCEL RESERVATION",
              color: AppColors.error,
              isOutlined: true,
              onTap: () {
                if (res != null) {
                  _showCancelConfirmation(context, res.id, reservationsBloc);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Text("$label:", style: AppTextStyles.body.copyWith(color: AppColors.grey)),
          const SizedBox(width: 8),
          Text(value, style: AppTextStyles.h3.copyWith(color: AppColors.white)),
        ],
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context, int reservationId,ReservationsBloc reservationsBloc) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text("Cancel Reservation?", style: TextStyle(color: AppColors.white)),
        content: const Text("Are you sure you want to cancel this reservation?", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("No", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              reservationsBloc.add(CancelReservationEvent(id: reservationId));
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text("Yes, Cancel", style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }


}