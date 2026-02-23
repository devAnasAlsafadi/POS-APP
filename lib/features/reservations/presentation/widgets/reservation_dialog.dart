import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pos_wiz_tech/core/developer.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/my_text_field.dart';
import '../blocs/reservations_bloc.dart';

class ReservationDialog extends StatefulWidget {
  final int tableId;
  const ReservationDialog({super.key, required this.tableId});

  @override
  State<ReservationDialog> createState() => _ReservationDialogState();
}

class _ReservationDialogState extends State<ReservationDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  int _guestCount = 2;
  DateTime _selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 450,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const Divider(color: AppColors.border, height: 32),

                _buildLabel("GUEST NAME *", Icons.person_outline),
                MyTextField(
                  controller: _nameController,
                  hintText: "Enter guest name",
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  fillColor: AppColors.surface,
                  validator: (v) => v!.isEmpty ? "Required" : null,
                ),

                const SizedBox(height: 20),
                _buildLabel("GUEST PHONE", Icons.phone_outlined),
                MyTextField(
                  controller: _phoneController,
                  hintText: "+1 (555) 000-0000",
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  fillColor: AppColors.surface,
                ),

                const SizedBox(height: 20),
                _buildLabel("RESERVATION DATE & TIME *", Icons.calendar_today_outlined),
                _buildDateTimePicker(),

                const SizedBox(height: 20),
                _buildLabel("NUMBER OF GUESTS", Icons.group_outlined),
                _buildGuestCounter(),

                const SizedBox(height: 20),
                _buildLabel("SPECIAL REQUESTS", Icons.notes_outlined),
                MyTextField(
                  controller: _noteController,
                  hintText: "e.g., Window seat preferred...",
                  obscureText: false,
                  keyboardType: TextInputType.multiline,
                  fillColor: AppColors.surface,
                ),

                const SizedBox(height: 32),
                _buildActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("New Reservation", style: AppTextStyles.h2),
            Text("Table #${widget.tableId.toString().padLeft(2, '0')}",
                style: AppTextStyles.bodySecondary),
          ],
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: AppColors.textSecondary),
        )
      ],
    );
  }

  Widget _buildLabel(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textMuted),
          const SizedBox(width: 8),
          Text(text, style: AppTextStyles.labelSmall),
        ],
      ),
    );
  }

  Widget _buildDateTimePicker() {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _selectedDateTime,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 90)),
        );
        if (date != null) {
          final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(_selectedDateTime));
          if (time != null) {
            setState(() => _selectedDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute));
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month, color: AppColors.textMuted, size: 20),
            const SizedBox(width: 12),
            Text(
              DateFormat('yyyy/MM/dd  -  HH:mm').format(_selectedDateTime),
              style: AppTextStyles.body,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestCounter() {
    return Row(
      children: [
        _counterBtn(Icons.remove, () => setState(() => _guestCount > 1 ? _guestCount-- : null)),
        Expanded(
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10)),
            child: Text("$_guestCount Guests", style: AppTextStyles.h3.copyWith(color: AppColors.white)),
          ),
        ),
        _counterBtn(Icons.add, () => setState(() => _guestCount++)),
      ],
    );
  }

  Widget _counterBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
        child: Icon(icon, color: AppColors.white, size: 20),
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.border),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: AppTextStyles.button.copyWith(fontSize: 16,color: AppColors.grey)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 18),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(_selectedDateTime);
                final data = {
                  "table_id": widget.tableId,
                  "guest_name": _nameController.text,
                  "guest_phone": _phoneController.text,
                  "guests_count": _guestCount,
                  "reservation_time": formattedDate,
                  "special_requests": _noteController.text,
                };
                context.read<ReservationsBloc>().add(CreateReservationEvent(reservationData: data));
                AppLogger.error("_selectedDateTime.toIso8601String() : $formattedDate");
                Navigator.pop(context);
              }
            },
            child:  Text("Confirm Reservation",style: AppTextStyles.button.copyWith(fontWeight: FontWeight.bold,fontSize: 16),),
          ),
        ),
      ],
    );
  }
}