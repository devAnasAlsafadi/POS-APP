part of 'orders_bloc.dart';

abstract class OrdersEvent {
  const OrdersEvent();
}

class GetOrdersEvent extends OrdersEvent {}

class OnSocketOrderUpdated extends OrdersEvent {
  final OrderEntity updatedOrder;
  const OnSocketOrderUpdated(this.updatedOrder);
}

class FilterOrdersEvent extends OrdersEvent {
  final int stage;
  const FilterOrdersEvent(this.stage);
}