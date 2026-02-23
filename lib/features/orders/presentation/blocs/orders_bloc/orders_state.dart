part of 'orders_bloc.dart';

enum OrdersStatus { initial, loading, success, failure }

class OrdersState {
  final List<OrderEntity> allOrders;
  final OrdersStatus status;
  final String? errorMessage;

  const OrdersState({
    this.allOrders = const [],
    this.status = OrdersStatus.initial,
    this.errorMessage,
  });

  OrdersState copyWith({
    List<OrderEntity>? allOrders,
    OrdersStatus? status,
    String? errorMessage,
  }) {
    return OrdersState(
      allOrders: allOrders ?? this.allOrders,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}