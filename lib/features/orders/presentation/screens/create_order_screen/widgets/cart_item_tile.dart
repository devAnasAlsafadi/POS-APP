import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_wiz_tech/core/theme/app_color.dart';
import 'package:pos_wiz_tech/core/theme/app_text_style.dart';
import 'package:pos_wiz_tech/features/orders/domain/entities/order_product_entity.dart';
import 'package:pos_wiz_tech/features/orders/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CartItemTile extends StatelessWidget {
  final OrderProductEntity item;

  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                  onTap: () =>  _showNoteDialog(context, item),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Icon(Icons.fastfood, size: 40, color: Colors.grey),
                      errorWidget: (context, url, error) => const Icon(Icons.fastfood, size: 40, color: Colors.grey),
                    ),
                  )
              ),
              SizedBox(width: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.nameEn, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold,color: AppColors.white)),
                  Text("${item.finalPrice} ", style: AppTextStyles.caption.copyWith(color: AppColors.primary)),

                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  context.read<CartBloc>().add(ToggleCartItemTypeEvent(item));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: item.isTakeaway ? AppColors.primary : AppColors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(item.isTakeaway ?Icons.local_mall_outlined :Icons.restaurant_menu_sharp,size: 18,),
                      SizedBox(width: 5,),
                      Text(
                        item.isTakeaway ? "Takeaway" : "Dine-in",
                        style:AppTextStyles.labelSmall.copyWith(color: AppColors.white),
                      ),
                    ],
                  )
                ),
              ),

            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent,size: 20),
                onPressed: () {
                  context.read<CartBloc>().add(UpdateCartItemQuantityEvent(item, item.count - 1));
                },
              ),
              Text(
                "${item.count}",
                style: AppTextStyles.h3.copyWith(fontSize: 18, color: AppColors.white),
              )
              .animate(key: ValueKey(item.count))
              .scale(duration: 200.ms, curve: Curves.easeOutBack), // Pulse effect on change
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: Colors.greenAccent,size: 20,),
                onPressed: () {
                  context.read<CartBloc>().add(UpdateCartItemQuantityEvent(item, item.count + 1));
                },
              ),
            ],
          ),
        ],
      )
    );
  }


  void _showNoteDialog(BuildContext context, OrderProductEntity item) {
    final controller = TextEditingController(text: item.notes);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Note"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter items note (e.g., No onions)"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(UpdateCartItemNoteEvent(item, controller.text));
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}