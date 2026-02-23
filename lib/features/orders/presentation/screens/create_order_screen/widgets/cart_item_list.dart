import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_wiz_tech/core/theme/app_color.dart';
import 'package:pos_wiz_tech/core/theme/app_text_style.dart';
import 'package:pos_wiz_tech/features/orders/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../floor_map/presentation/widgets/order_history_card.dart';
import 'cart_item_tile.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.status == CartStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        final existingItems = state.existingOrder?.products ?? [];
        final newItems = state.newItems;

        if (existingItems.isEmpty && newItems.isEmpty) {

           return Center(child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(Icons.restaurant_menu,size: 40,color: AppColors.grey,),
               Text('No Items Added'),
               Text('Tap item to add to order',style: AppTextStyles.caption.copyWith(color: AppColors.grey),),
             ],
           ),);
        }

        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            if (existingItems.isNotEmpty)...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "ORDER HISTORY",
                  style: TextStyle(
                      color: Colors.white38,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      letterSpacing: 1.2
                  ),
                ),
              ),
              OrderHistoryCard(items: existingItems),
              const SizedBox(height: 10),
            ],
            if (newItems.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.add, color: Colors.green, size: 16),
                    const SizedBox(width: 5),
                    Text(
                      "NEW ITEMS (${newItems.length})",
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              ...newItems.map((item) => CartItemTile(item: item)
                  .animate(key: ValueKey(item.id))
                  .fade(duration: 300.ms)
                  .slideX(begin: 1.0, end: 0.0, curve: Curves.easeOutCubic, duration: 400.ms)
              ),
            ],
            const SizedBox(height: 100),
          ],
        );
      },
    );
  }
}