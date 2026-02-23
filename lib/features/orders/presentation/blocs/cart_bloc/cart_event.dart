part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class LoadTableEvent extends CartEvent {
  final TableEntity table;
  LoadTableEvent(this.table);
}

class AddProductEvent extends CartEvent {
  final ProductEntity product;
  AddProductEvent(this.product);
}

class RemoveProductEvent extends CartEvent {
  final OrderProductEntity orderProduct;
  RemoveProductEvent(this.orderProduct);
}

class UpdateCartItemQuantityEvent extends CartEvent {
  final OrderProductEntity orderProduct;
  final int quantity;
  UpdateCartItemQuantityEvent(this.orderProduct, this.quantity);
}

class UpdateCartItemNoteEvent extends CartEvent {
  final OrderProductEntity orderProduct;
  final String note;
  UpdateCartItemNoteEvent(this.orderProduct, this.note);
}

class ToggleCartItemTypeEvent extends CartEvent {
  final OrderProductEntity orderProduct;
  ToggleCartItemTypeEvent(this.orderProduct);
}


class SendOrderEvent extends CartEvent {
  final String? customerName;
  final String? description;

  SendOrderEvent({this.customerName, this.description});
}

class MarkAsServedEvent extends CartEvent {}

class RequestBillEvent extends CartEvent {}

class UpdateStatusEvent extends CartEvent {
  final int stage;
  UpdateStatusEvent(this.stage);
}

class AddOrderNoteEvent extends CartEvent {
  final String note;
  AddOrderNoteEvent(this.note);
}

class ClearTableEvent extends CartEvent {}

class ResetCartEvent extends CartEvent {}

class UpdateTableStatusEvent extends CartEvent {
  final int tableId;
  final String status;
  UpdateTableStatusEvent({required this.tableId, required this.status});
}
