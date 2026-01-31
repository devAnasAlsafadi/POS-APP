import '../../../../core/enum/table_status.dart';
import '../models/table_model.dart';

abstract class FloorMapRemoteDataSource {
  Future<List<TableModel>> getTables();
}


class FloorMapRemoteDataSourceImpl implements FloorMapRemoteDataSource {
  @override
  Future<List<TableModel>> getTables() async {
    await Future.delayed(const Duration(seconds: 2));

    return [
      TableModel(
        id: '1',
        tableNumber: '01',
        floorId: 'F1',
        chairCount: 2,
        status: TableStatus.available,
      ),
      TableModel(
        id: '2',
        tableNumber: '02',
        floorId: 'F1',
        chairCount: 4,
        status: TableStatus.waiting,
        totalAmount: 120.50,
        orders: [
          TableOrderModel(orderId: 'ord1', orderTime: DateTime.now().subtract(Duration(minutes: 20)), items: ['Pasta', 'Cola']),
          TableOrderModel(orderId: 'ord2', orderTime: DateTime.now().subtract(Duration(minutes: 12)), items: ['cheese', 'soda'])
        ],
      ),
      TableModel(
        id: '4',
        tableNumber: '04',
        floorId: 'F1',
        chairCount: 2,
        status: TableStatus.billing,
        orders: [
          TableOrderModel(orderId: 'ord1', orderTime: DateTime.now().subtract(Duration(minutes: 20)), items: ['Pasta', 'Cola']),
          TableOrderModel(orderId: 'ord2', orderTime: DateTime.now().subtract(Duration(minutes: 12)), items: ['cheese', 'soda'])
        ],
        totalAmount: 85.0,
      ),
      TableModel(
        id: '6',
        tableNumber: '06',
        floorId: 'F1',
        chairCount: 8,
        status: TableStatus.reserved,
        isReserved: true,
        reservationTime:DateTime.now(),
      ),
    ];
  }
}