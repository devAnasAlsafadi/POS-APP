part of 'cart_bloc.dart';

enum CartStatus { initial, loading, success, failure }

@immutable
class CartState {
  final CartStatus status;
  final TableEntity? table;
  final OrderEntity? existingOrder;
  final List<OrderProductEntity> newItems;
  final String? errorMessage;
  final bool actionPerformed;
  final String? orderNote;
  final String? successMessage;


  const CartState({
    this.status = CartStatus.initial,
    this.table,
    this.existingOrder,
    this.newItems = const [],
    this.errorMessage,
    this.actionPerformed = false,
    this.orderNote,
      this.successMessage,
  });

  double get subtotal {
    double total = 0;
    for (var item in newItems) {
      total += item.finalPrice * item.count;
    }
    return total;
  }
  

  CartState copyWith({
    CartStatus? status,
    TableEntity? table,
    OrderEntity? existingOrder,
    List<OrderProductEntity>? newItems,
    String? errorMessage,
    bool? actionPerformed,
    String? orderNote,
    String? successMessage,
  }) {
    return CartState(
      status: status ?? this.status,
      table: table ?? this.table,
      existingOrder: existingOrder ?? this.existingOrder,
      newItems: newItems ?? this.newItems,
      errorMessage: errorMessage ?? this.errorMessage,
      actionPerformed: actionPerformed ?? this.actionPerformed,
      orderNote: orderNote ?? this.orderNote,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}
