import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/orders_screen/widgets/order_card.dart';
import '../../../../orders/domain/entities/order_entity.dart';
import '../../../../orders/presentation/blocs/orders_bloc/orders_bloc.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersBloc>().add(GetOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Kitchen Orders", style: TextStyle(color: Colors.white)),
          bottom: TabBar(
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "All Orders (${context.select((OrdersBloc b) => b.state.allOrders.length)})"),
              const Tab(text: "Preparing"),
              const Tab(text: "Ready"),
            ],
          ),
        ),
        body: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state.status == OrdersStatus.loading) {
              return const Center(child: CircularProgressIndicator(color: Colors.orange));
            }

            return TabBarView(
              children: [
                _buildOrdersList(state.allOrders),
                _buildOrdersList(state.allOrders.where((o) =>
                o.readyStatus == "awaiting" || o.readyStatus == "processing").toList()), // التحضير
                _buildOrdersList(state.allOrders.where((o) =>
                o.readyStatus == "ready").toList()),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrdersList(List<OrderEntity> orders) {
    if (orders.isEmpty) {
      return const Center(child: Text("No orders found", style: TextStyle(color: Colors.grey)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCard(order: order);
      },
    );
  }
}