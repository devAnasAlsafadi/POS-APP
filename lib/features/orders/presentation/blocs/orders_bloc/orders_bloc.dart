import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../../../core/services/pusher_service.dart';
import '../../../data/models/order_model.dart';
import '../../../domain/entities/order_entity.dart';
import '../../../domain/usecases/get_orders_use_case.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;
  final SocketService socketService;
  StreamSubscription? _socketSubscription;

  OrdersBloc({
    required this.getOrdersUseCase,
    required this.socketService,
  }) : super(const OrdersState()) {

    on<GetOrdersEvent>(_onGetOrders);
    on<OnSocketOrderUpdated>(_onSocketUpdate);


    _socketSubscription = socketService.orderUpdates.listen((orderData) {
      final order = OrderModel.fromJson(orderData).toEntity();
      add(OnSocketOrderUpdated(order));
    });
  }

  Future<void> _onGetOrders(GetOrdersEvent event, Emitter<OrdersState> emit) async {
    emit(state.copyWith(status: OrdersStatus.loading));

    final result = await getOrdersUseCase();

    result.fold(
          (failure) => emit(state.copyWith(
          status: OrdersStatus.failure,
          errorMessage: failure.message
      )),
          (response) => emit(state.copyWith(
          status: OrdersStatus.success,
          allOrders: response.data
      )),
    );
  }

  void _onSocketUpdate(OnSocketOrderUpdated event, Emitter<OrdersState> emit) {
    if (state.status == OrdersStatus.success) {
      List<OrderEntity> currentOrders = List.from(state.allOrders);

      int index = currentOrders.indexWhere((o) => o.id == event.updatedOrder.id);

      if (index != -1) {
        currentOrders[index] = event.updatedOrder;
      } else {
        currentOrders.insert(0, event.updatedOrder);
      }

      emit(state.copyWith(allOrders: currentOrders));
    }
  }

  @override
  Future<void> close() {
    _socketSubscription?.cancel();
    return super.close();
  }
}