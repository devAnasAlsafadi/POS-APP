import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_wiz_tech/features/orders/presentation/screens/create_order_screen/widgets/product_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:pos_wiz_tech/features/products/presentation/blocs/product_bloc/products_bloc.dart';
import '../../../../../floor_map/domain/entities/table_entity.dart';
import 'category_bar.dart';
import 'menu_header.dart';

class ProductMenuSection extends StatelessWidget {
  final TableEntity table;
  final String waiterName;
  const ProductMenuSection({
    super.key,
    required this.table,
    required this.waiterName
  });
  @override
  Widget build(BuildContext context) {
    final String tableNumber = table.id.toString().padLeft(2, '0');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MenuHeader(
          tableNumber: tableNumber,
          waiterName: waiterName,
          tableId: table.id,
        ),        const CategoryBar(),
        Expanded(
          child: BlocBuilder<ProductBloc, ProductsState>(
            builder: (context, state) {
              if (state.status == ProductStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.filteredProducts.isEmpty) {
                return const Center(child: Text("No products found", style: TextStyle(color: Colors.white)));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 4 : 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.60,
                ),
                itemCount: state.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = state.filteredProducts[index];
                  return ProductCard(product: product)
                      .animate(delay: (30 * index).ms) // Stagger effect
                      .fade(duration: 400.ms)
                      .scale(duration: 400.ms, curve: Curves.easeOutBack);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}