import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/core/theme/app_color.dart';
import 'package:pos_wiz_tech/core/theme/app_text_style.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/di/injection_container.dart';
import '../../../../../feedback/presentation/cubit/feedback_cubit.dart';
import '../../../../../feedback/presentation/widgets/feedback_dialog.dart';
import '../../../blocs/cart_bloc/cart_bloc.dart';
import 'cart_item_list.dart';
import 'cart_summary.dart';

class CartSection extends StatelessWidget {
  const CartSection({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state.actionPerformed) {
          if (state.table != null && state.table!.status == 'billing') {
            Future.delayed(const Duration(seconds: 2), () {
              if (context.mounted) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => BlocProvider(
                    create: (context) => sl<FeedbackCubit>(),
                    child: FeedbackDialog(
                      orderId: state.table!.currentOrderId!,
                      tableNumber: "44",
                    ),
                  ),
                );
              }
            });
          }
        }
      },
      child: Container(
        color: AppColors.darkGrey,
        padding: const EdgeInsetsDirectional.only(top: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onLongPress: () => _showOrderNoteDialog(context),
                    child: Row(
                      children: [
                        const Text(
                          "Current Order",
                          style: AppTextStyles.appBarTitle,
                        ),
                        const SizedBox(width: 8),
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            if (state.orderNote != null &&
                                state.orderNote!.isNotEmpty) {
                              return const Icon(
                                Icons.note,
                                color: AppColors.primary,
                                size: 20,
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: CartItemsList()),

            const CartSummary(),
          ],
        ),
      ),
    );
  }

  void _showOrderNoteDialog(BuildContext context) {
    final controller = TextEditingController(
      text: context.read<CartBloc>().state.orderNote,
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          "Order Note",
          style: TextStyle(color: AppColors.white),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: AppColors.white),
          decoration: const InputDecoration(
            hintText: "Add note for the kitchen...",
            hintStyle: TextStyle(color: AppColors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () {
              context.read<CartBloc>().add(AddOrderNoteEvent(controller.text));
              Navigator.pop(context);
            },
            child: const Text("Save", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
