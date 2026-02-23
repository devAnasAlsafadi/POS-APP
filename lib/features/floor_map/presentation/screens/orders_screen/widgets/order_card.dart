import 'package:flutter/material.dart';

import '../../../../../orders/domain/entities/order_entity.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF262626),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: order.readyStatus == "ready" ? Colors.green : Colors.transparent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("ORD-${order.id}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.table_restaurant, color: Colors.orange, size: 16),
              const SizedBox(width: 4),
              Text("Table ${order.table!.id}", style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const Divider(color: Colors.grey, height: 24),
          ...order.products.map((product) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text("• ${product.nameEn} (x${product.count})",
                style: const TextStyle(color: Colors.white70)),
          )).toList(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // عرض وقت الطلب
              Text("Ordered: ${order.createdAt}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
              // شريط الحالة أو أيقونة الجاهزية
              if (order.readyStatus == "ready")
                const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 16),
                    SizedBox(width: 4),
                    Text("Ready", style: TextStyle(color: Colors.green)),
                  ],
                )
              else
                const Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text("In Progress", style: TextStyle(color: Colors.orange)),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}