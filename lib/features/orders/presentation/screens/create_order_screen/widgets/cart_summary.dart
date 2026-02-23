import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_wiz_tech/features/orders/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:pos_wiz_tech/features/orders/presentation/screens/create_order_screen/widgets/summary_row.dart';
import 'package:pos_wiz_tech/core/theme/app_color.dart';
import 'package:pos_wiz_tech/core/theme/app_text_style.dart';


class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final subtotal = state.subtotal;
        final tax = subtotal * 0.0;
        final total = subtotal + tax;
        final newItemsCount = state.newItems.fold(0, (sum, item) => sum + item.count);
        
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: AppColors.cardBackground,
            border: Border(top: BorderSide(color: AppColors.border, width: 1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SummaryRow(label: "Previous:", value: "\$${(state.existingOrder?.totalAmount ?? 0).toStringAsFixed(2)}"),
              const SizedBox(height: 5),
              SummaryRow(label: "New Items:", value: "\$${subtotal.toStringAsFixed(2)}"),
              const Divider(color: AppColors.border, height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Grand Total:", style: AppTextStyles.body.copyWith(color: AppColors.white, fontWeight: FontWeight.w600)),
                  Text("\$${(total + (state.existingOrder?.totalAmount ?? 0)).toStringAsFixed(2)}", style: AppTextStyles.h2.copyWith(color: AppColors.success)),
                ],
              ),
              const SizedBox(height: 20),
              
              // Action Button
              Builder(
                builder: (context) {
                  final tableStatus = state.table?.status ?? 'available';
                  final hasNewItems = state.newItems.isNotEmpty;
                  String label = "Action";
                  VoidCallback? onPressed;
                  Color color = AppColors.primary;
                  IconData icon = Icons.check;

                  if (hasNewItems) {
                    label = "Send to Kitchen (${state.newItems.fold(0, (sum, item) => sum + item.count)})";
                    onPressed = () => context.read<CartBloc>().add(SendOrderEvent());
                    color = AppColors.success;
                    icon = Icons.send;
                  } else {
                    switch (tableStatus) {
                      case 'available':
                        label = "Select Items";
                        onPressed = null;
                        color = AppColors.textSecondary;
                        icon = Icons.touch_app;
                        break;
                      case 'occupied':
                        label = "Mark as Served";
                        onPressed = () => context.read<CartBloc>().add(MarkAsServedEvent());
                        color = AppColors.primary; // Or warning
                        icon = Icons.room_service;
                        break;
                      case 'dining':
                        label = "Request Bill";
                        onPressed = () => context.read<CartBloc>().add(RequestBillEvent());
                        color = AppColors.textSecondary; // Or info
                        icon = Icons.receipt_long;
                        break;
                      case 'billing':
                        label = "Clear Table / Set Available";
                        onPressed = () =>context.read<CartBloc>().add(
                          UpdateTableStatusEvent(
                            tableId: state.table!.id,
                            status: 'available',
                          ),
                        );
                        color = AppColors.error;
                        icon = Icons.cleaning_services;
                        break;
                      default:
                        label = tableStatus;
                        onPressed = null;
                        color = AppColors.textSecondary;
                        icon = Icons.help_outline;
                    }
                  }

                   return SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        disabledBackgroundColor: AppColors.background, // Fallback
                      ),
                      onPressed: onPressed,
                      icon: Icon(icon, color: AppColors.white),
                      label: Text(
                        label,
                        style: AppTextStyles.button.copyWith(fontSize: 16, color: AppColors.white),
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
        );
      },
    );
  }
}