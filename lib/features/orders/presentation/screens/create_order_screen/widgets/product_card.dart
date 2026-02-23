import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/core/theme/app_color.dart';
import 'package:pos_wiz_tech/core/theme/app_text_style.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_wiz_tech/features/orders/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:pos_wiz_tech/features/products/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
              tag: 'product_${product.id}',
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(product.imageUrl, fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => Center(child: const Icon(Icons.fastfood, size: 50, color: Colors.grey))),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding:  EdgeInsetsDirectional.symmetric(vertical: 0, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.nameEn, style:AppTextStyles.labelSmall.copyWith(color: AppColors.white,fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                SizedBox(height: 5,),
                Text(product.descEn, style:AppTextStyles.caption.copyWith(color: AppColors.grey,fontSize: 8), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${product.finalPrice.toInt()} ", style: AppTextStyles.bodySecondary.copyWith(color: AppColors.primary)),
                      IconButton(
                        onPressed: () {
                          context.read<CartBloc>().add(AddProductEvent(product));
                        },
                        icon: const Icon(Icons.add_box, color: AppColors.primary),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}