import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pos_wiz_tech/features/floor_map/domain/entities/table_entity.dart';
import 'package:pos_wiz_tech/features/floor_map/domain/usecases/update_table_status.dart';
import 'package:pos_wiz_tech/features/orders/domain/entities/order_entity.dart';
import 'package:pos_wiz_tech/features/orders/domain/entities/order_product_entity.dart';
import 'package:pos_wiz_tech/features/products/domain/entities/product_entity.dart';
import 'package:pos_wiz_tech/features/orders/domain/usecases/get_order_by_id_use_case.dart';
import 'package:pos_wiz_tech/features/orders/domain/usecases/create_order_use_case.dart';
import 'package:pos_wiz_tech/features/orders/domain/usecases/update_order_status_use_case.dart';
import 'package:pos_wiz_tech/features/orders/domain/usecases/serve_order_use_case.dart';
import 'package:pos_wiz_tech/features/orders/domain/usecases/request_bill_use_case.dart';

import '../../../../../core/utils/order_constants.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetOrderByIdUseCase getOrderByIdUseCase;
  final CreateOrderUseCase createOrderUseCase;
  final UpdateOrderStatusUseCase updateOrderStatusUseCase;
  final ServeOrderUseCase serveOrderUseCase;
  final RequestBillUseCase requestBillUseCase;
  final UpdateTableStatusUseCase updateTableStatusUseCase;

  CartBloc({
    required this.getOrderByIdUseCase,
    required this.createOrderUseCase,
    required this.updateOrderStatusUseCase,
    required this.serveOrderUseCase,
    required this.requestBillUseCase,
    required this.updateTableStatusUseCase,
  }) : super(const CartState()) {
    on<LoadTableEvent>(_onLoadTable);
    on<AddProductEvent>(_onAddProduct);
    on<UpdateCartItemQuantityEvent>(_onUpdateQuantity);
    on<UpdateCartItemNoteEvent>(_onUpdateNote);
    on<ToggleCartItemTypeEvent>(_onToggleType);
    on<RemoveProductEvent>(_onRemoveProduct);
    on<ResetCartEvent>(_onResetCart);
    on<SendOrderEvent>(_onSendOrder);
    on<MarkAsServedEvent>(_onMarkAsServed);
    on<RequestBillEvent>(_onRequestBill);
    on<UpdateStatusEvent>(_onUpdateStatus);
    on<UpdateTableStatusEvent>(_onUpdateTableStatus);
    on<AddOrderNoteEvent>(
      (event, emit) => emit(state.copyWith(orderNote: event.note)),
    );
    on<ClearTableEvent>(_onClearTable);
  }

  Future<void> _onUpdateTableStatus(
      UpdateTableStatusEvent event,
      Emitter<CartState> emit,
      ) async {
    emit(state.copyWith(status: CartStatus.loading));

    final result = await updateTableStatusUseCase(event.tableId, event.status);

    result.fold(
          (failure) => emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: failure.message,
      )),
          (successResponse) {
        emit(state.copyWith(
          status: CartStatus.success,
          table: successResponse.data,
          actionPerformed: true,
          successMessage: successResponse.message ?? "Table status updated to ${event.status}",
        ));
      },
    );
  }


  Future<void> _onClearTable(
    ClearTableEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state.existingOrder == null) return;
    emit(state.copyWith(status: CartStatus.loading));

    if (state.existingOrder != null) {
      final result = await updateOrderStatusUseCase(
        state.existingOrder!.id,
        OrderStages.completed,
      ); // 4 = Completed
      result.fold(
        (failure) => emit(
          state.copyWith(
            status: CartStatus.failure,
            errorMessage: failure.message,
          ),
        ),
        (order) {
          final updatedTable = state.table?.copyWith(
            status: 'available',
            currentOrderId: null,
          );
          emit(
            state.copyWith(
              status: CartStatus.success,
              table: updatedTable,
              existingOrder: null,
              newItems: [],
              actionPerformed: true,
              successMessage: order.message
            ),
          );
        },
      );
    }
  }

  void _onResetCart(ResetCartEvent event, Emitter<CartState> emit) {
    emit(const CartState());
  }

  Future<void> _onLoadTable(
    LoadTableEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(status: CartStatus.loading, table: event.table,actionPerformed: false,));

    if (event.table.status != 'available' &&
        event.table.currentOrderId != null) {
      final result = await getOrderByIdUseCase(event.table.currentOrderId!);
      result.fold(
        (failure) => emit(
          state.copyWith(
            status: CartStatus.failure,
            errorMessage: failure.message,
            actionPerformed: false,
          ),
        ),
        (response) => emit(
          state.copyWith(
            status: CartStatus.success,
            existingOrder: response.data,
            newItems: [],
            actionPerformed: false,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: CartStatus.success,
          existingOrder: null,
          newItems: [],
          actionPerformed: false,
        ),
      );
    }
  }

  void _onAddProduct(AddProductEvent event, Emitter<CartState> emit) {
    final currentList = List<OrderProductEntity>.from(state.newItems);

    final index = currentList.indexWhere(
      (item) => item.id == event.product.id && item.notes == null,
    );

    if (index != -1) {
      currentList[index] = currentList[index].copyWith(count: currentList[index].count +1);
    } else {
      currentList.add(OrderProductEntity.fromProduct(event.product));
    }

    emit(state.copyWith(newItems: currentList));
  }

  void _onUpdateQuantity(
    UpdateCartItemQuantityEvent event,
    Emitter<CartState> emit,
  ) {
    if (event.quantity <= 0) {
      add(RemoveProductEvent(event.orderProduct));
      return;
    }
    final currentList = List<OrderProductEntity>.from(state.newItems);
    final index = currentList.indexOf(event.orderProduct);
    if (index != -1) {
      currentList[index] = event.orderProduct.copyWith(count: event.quantity);
      emit(state.copyWith(newItems: currentList));
    }
  }

  void _onRemoveProduct(RemoveProductEvent event, Emitter<CartState> emit) {
    final currentList = List<OrderProductEntity>.from(state.newItems);
    currentList.remove(event.orderProduct);
    emit(state.copyWith(newItems: currentList));
  }

  void _onUpdateNote(UpdateCartItemNoteEvent event, Emitter<CartState> emit) {
    final currentList = List<OrderProductEntity>.from(state.newItems);
    final index = currentList.indexOf(event.orderProduct);
    if (index != -1) {
      currentList[index] = event.orderProduct.copyWith(notes: event.note);
      emit(state.copyWith(newItems: currentList));
    }
  }

  void _onToggleType(ToggleCartItemTypeEvent event, Emitter<CartState> emit) {
    final currentList = List<OrderProductEntity>.from(state.newItems);
    final index = currentList.indexOf(event.orderProduct);
    if (index != -1) {
      currentList[index] = event.orderProduct.copyWith(
        isTakeaway: !event.orderProduct.isTakeaway,
      );
      emit(state.copyWith(newItems: currentList));
    }
  }

  Future<void> _onSendOrder(
    SendOrderEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state.table == null || state.newItems.isEmpty) return;

    emit(state.copyWith(status: CartStatus.loading));

    final orderData = {
      'dining_table_id': state.table!.id,
      if (event.customerName != null) 'customer_name': event.customerName,
      if (event.description != null || state.orderNote != null)
        'description': event.description ?? state.orderNote,
      'products': state.newItems.map((e) {
        final Map<String, dynamic> productMap = {'id': e.id, 'count': e.count};
        if (e.notes != null && e.notes!.isNotEmpty) {
          productMap['notes'] = e.notes;
        }
        return productMap;
      }).toList(),
    };

    final result = await createOrderUseCase(orderData);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CartStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (response) {
        final updatedTable = state.table?.copyWith(
          status: response.data!.stage == OrderStages.preparing
              ? 'occupied'
              : state.table?.status,
          currentOrderId: response.data!.id,
        );

        emit(
          state.copyWith(
            status: CartStatus.success,
            existingOrder: response.data,
            newItems: [],
            actionPerformed: true,
            table: updatedTable,
            successMessage: response.message,
          ),
        );
      },
    );
  }

  Future<void> _onMarkAsServed(
    MarkAsServedEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state.existingOrder == null) return;
    emit(state.copyWith(status: CartStatus.loading));

    final result = await serveOrderUseCase(state.existingOrder!.id);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CartStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (response) {
        final updatedTable = state.table?.copyWith(status: 'dining');
        emit(
          state.copyWith(
            status: CartStatus.success,
            existingOrder: response.data,
            actionPerformed: true,
            table: updatedTable,
            successMessage: response.message,
          ),
        );
      },
    );
  }

  Future<void> _onRequestBill(
    RequestBillEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state.existingOrder == null) return;
    emit(state.copyWith(status: CartStatus.loading));

    final result = await requestBillUseCase(state.existingOrder!.id);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CartStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (response) {
        final updatedTable = state.table?.copyWith(status: 'billing');
        emit(
          state.copyWith(
            status: CartStatus.success,
            existingOrder: response.data,
            actionPerformed: true,
            table: updatedTable,
            successMessage: response.message,
          ),
        );
      },
    );
  }

  Future<void> _onUpdateStatus(
    UpdateStatusEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state.existingOrder == null) return;
    emit(state.copyWith(status: CartStatus.loading));

    final result = await updateOrderStatusUseCase(
      state.existingOrder!.id,
      event.stage,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CartStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (response) => emit(
        state.copyWith(
          status: CartStatus.success,
          existingOrder: response.data,
          successMessage: response.message,
        ),
      ),
    );
  }

}
