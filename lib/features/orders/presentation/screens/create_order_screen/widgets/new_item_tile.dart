import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_wiz_tech/core/theme/app_color.dart';
import 'package:pos_wiz_tech/core/theme/app_text_style.dart';
import 'package:pos_wiz_tech/features/orders/domain/entities/order_product_entity.dart';
import 'package:pos_wiz_tech/features/orders/presentation/blocs/cart_bloc/cart_bloc.dart';

class NewItemTile extends StatelessWidget {
  final OrderProductEntity item;

  const NewItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final double totalPrice = item.finalPrice * item.count;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image (Placeholder or Actual)
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                   color: AppColors.grey.withOpacity(0.1), // Placeholder color
                  image: item.imageUrl != null 
                    ? DecorationImage(image: NetworkImage(item.imageUrl!), fit: BoxFit.cover)
                    : null,
                ),
                child: item.imageUrl == null ? const Icon(Icons.fastfood, color: AppColors.textMuted) : null,
              ),
              const SizedBox(width: 12),
              
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.nameEn, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text("\$${totalPrice.toStringAsFixed(2)}", style: AppTextStyles.h3.copyWith(fontSize: 14)),
                  ],
                ),
              ),

              // Toggle Button
              InkWell(
                onTap: () {
                   context.read<CartBloc>().add(ToggleCartItemTypeEvent(item));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: item.isTakeaway ? AppColors.billing.withOpacity(0.2) : AppColors.success.withOpacity(0.2), // Custom BG based on state
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: item.isTakeaway ? AppColors.billing : AppColors.success,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item.isTakeaway ? Icons.takeout_dining : Icons.restaurant,
                        size: 14,
                        color: item.isTakeaway ? AppColors.billing : AppColors.success,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.isTakeaway ? "Takeaway" : "Dine-in",
                        style: AppTextStyles.labelSmall.copyWith(
                          color: item.isTakeaway ? AppColors.billing : AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Controls
          Row(
            children: [
              // Note Button
              InkWell(
                onTap: () => _showNoteDialog(context, item),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.edit_note, 
                    color: (item.notes?.isNotEmpty ?? false) ? AppColors.primary : AppColors.textMuted,
                    size: 20
                  ),
                ),
              ),
              if(item.notes?.isNotEmpty ?? false)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Note added", 
                    style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontSize: 10)
                  ),
                ),
              
              const Spacer(),

              // Quantity Controls
               _buildQuantityBtn(
                icon: Icons.remove,
                color: AppColors.cardBackground, 
                iconColor: AppColors.textPrimary,
                onTap: () {
                    context.read<CartBloc>().add(UpdateCartItemQuantityEvent(item, item.count - 1));
                }
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("${item.count}", style: AppTextStyles.h3.copyWith(color: AppColors.white)),
              ),
              
              _buildQuantityBtn(
                icon: Icons.add,
                color: AppColors.primary, 
                iconColor: AppColors.black,
                onTap: () {
                    context.read<CartBloc>().add(UpdateCartItemQuantityEvent(item, item.count + 1));
                }
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildQuantityBtn({required IconData icon, required Color color, required Color iconColor, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
       borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: iconColor),
      ),
    );
  }

  void _showNoteDialog(BuildContext context, OrderProductEntity item) {
    final controller = TextEditingController(text: item.notes);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardLight,
        title: Text("Add Note", style: AppTextStyles.h3),
        content: TextField(
          controller: controller,
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: "Enter items note (e.g., No onions)",
            hintStyle: AppTextStyles.bodySecondary,
            filled: true,
            fillColor: AppColors.cardBackground,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text("Cancel", style: AppTextStyles.button.copyWith(color: AppColors.textSecondary, fontSize: 14))
          ),
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(UpdateCartItemNoteEvent(item, controller.text));
              Navigator.pop(context);
            },
            child: Text("Save", style: AppTextStyles.button.copyWith(color: AppColors.primary, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
