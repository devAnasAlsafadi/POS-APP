import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Auth Feature
import '../../features/auth/data/data_source/auth_local_data_source.dart';
import '../../features/auth/data/data_source/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

// Floor Map Feature
import '../../features/feedback/domain/usecases/submit_feedback_use_case.dart';
import '../../features/feedback/presentation/cubit/feedback_cubit.dart';
import '../../features/floor_map/data/data_source/tables_remote_data_source.dart';
import '../../features/floor_map/data/repositories/table_repository_impl.dart';
import '../../features/floor_map/domain/repositories/table_repository.dart';
import '../../features/floor_map/domain/usecases/get_tables_usecase.dart';
import '../../features/floor_map/domain/usecases/update_table_status.dart';
import '../../features/floor_map/presentation/blocs/floor_map_bloc.dart';

// Products Feature
import '../../features/orders/presentation/blocs/orders_bloc/orders_bloc.dart';
import '../../features/products/data/data_source/products_remote_data_source.dart';
import '../../features/products/data/repositories/products_repositories_impl.dart';
import '../../features/products/domain/repositories/products_repositories.dart';
import '../../features/products/domain/usecases/get_menu_data_use_case.dart';
import '../../features/products/presentation/blocs/product_bloc/products_bloc.dart';

// Orders Feature
import '../../features/orders/data/data_source/orders_remote_data_source.dart';
import '../../features/orders/data/repositories/orders_repository_impl.dart';
import '../../features/orders/domain/repositories/orders_repository.dart';
import '../../features/orders/domain/usecases/get_orders_use_case.dart';
import '../../features/orders/presentation/blocs/cart_bloc/cart_bloc.dart';
import '../../features/orders/domain/usecases/get_order_by_id_use_case.dart';
import '../../features/orders/domain/usecases/create_order_use_case.dart';
import '../../features/orders/domain/usecases/get_active_orders_use_case.dart';
import '../../features/orders/domain/usecases/update_order_status_use_case.dart';
import '../../features/orders/domain/usecases/serve_order_use_case.dart';
import '../../features/orders/domain/usecases/request_bill_use_case.dart';

// Reservations Feature
import '../../features/reservations/data/datasources/reservations_remote_data_source.dart';
import '../../features/reservations/data/repositories/reservations_repository_impl.dart';
import '../../features/reservations/domain/repositories/reservations_repository.dart';
import '../../features/reservations/domain/usecase/cancel_reservation_use_case.dart';
import '../../features/reservations/domain/usecase/check_in_reservation_use_case.dart';
import '../../features/reservations/domain/usecase/create_reservation_use_case.dart';
import '../../features/reservations/domain/usecase/get_all_reservations_use_case.dart';
import '../../features/reservations/domain/usecase/get_today_reservations_use_case.dart';
import '../../features/reservations/domain/usecase/get_upcoming_reservations_use_case.dart';
import '../../features/reservations/domain/usecase/no_show_reservation_use_case.dart';
import '../../features/reservations/presentation/blocs/reservations_bloc.dart';

// Feedback Feature
import '../../features/feedback/data/datasources/feedback_remote_data_source.dart';
import '../../features/feedback/data/repositories/feedback_repository_impl.dart';
import '../../features/feedback/domain/repositories/feedback_repository.dart';

// Core & API
import '../api/api_consumer.dart';
import '../api/http_consumer.dart';
import '../blocs/connectivity/connectivity_bloc.dart';
import '../network/network_info.dart';
import '../services/pusher_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Floor Map
  sl.registerFactory(() => FloorMapBloc(getTablesUseCase: sl(), reservationsBloc: sl()));
  sl.registerLazySingleton(() => GetTablesUseCase(sl()));
  sl.registerLazySingleton<TableRepository>(
        () => TableRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<TablesRemoteDataSource>(
        () => TablesRemoteDataSourceImpl(api: sl()),
  );

  sl.registerLazySingleton<SocketService>(
        () => SocketService(authLocalDataSource: sl<AuthLocalDataSource>()),
  );
  //! Features - Products
  sl.registerFactory(() => ProductBloc(getMenuDataUseCase: sl()));
  sl.registerLazySingleton(() => GetMenuDataUseCase(sl()));
  sl.registerLazySingleton<ProductsRepository>(
        () => ProductsRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ProductsRemoteDataSource>(
        () => ProductsRemoteDataSourceImpl(api: sl()),
  );

  //! Features - Feedback
  sl.registerFactory(() => FeedbackCubit(submitFeedbackUseCase: sl()));
  sl.registerLazySingleton(() => SubmitFeedbackUseCase(sl()));
  sl.registerLazySingleton<FeedbackRepository>(
        () => FeedbackRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<FeedbackRemoteDataSource>(
        () => FeedbackRemoteDataSourceImpl(apiConsumer: sl()),
  );

  //! Features - Orders
  sl.registerFactory(() => CartBloc(
    getOrderByIdUseCase: sl(),
    createOrderUseCase: sl(),
    updateOrderStatusUseCase: sl(),
    serveOrderUseCase: sl(),
    requestBillUseCase: sl(),
    updateTableStatusUseCase: sl(),
  ));
  sl.registerFactory(() => OrdersBloc(
    getOrdersUseCase: sl(),
    socketService: sl(),
  ));

  sl.registerLazySingleton(() => GetOrderByIdUseCase(sl()));
  sl.registerLazySingleton(() => CreateOrderUseCase(sl()));
  sl.registerLazySingleton(() => GetActiveOrdersUseCase(sl()));
  sl.registerLazySingleton(() => UpdateOrderStatusUseCase(sl()));
  sl.registerLazySingleton(() => ServeOrderUseCase(sl()));
  sl.registerLazySingleton(() => RequestBillUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTableStatusUseCase(sl()));
  sl.registerLazySingleton(() => GetOrdersUseCase(sl()));
  sl.registerLazySingleton<OrdersRepository>(
        () => OrdersRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<OrdersRemoteDataSource>(
        () => OrdersRemoteDataSourceImpl(api: sl()),
  );

  //! Features - Auth
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
  ));
  sl.registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(api: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
          () => AuthLocalDataSourceImpl(sharedPreferences: sl()));

  //! Features - Reservations
  // Blocs - CRITICAL: Must be LazySingleton so FloorMapBloc and UI share same instance
  sl.registerLazySingleton(() => ReservationsBloc(
    getAllReservationsUseCase: sl(),
    getTodayReservationsUseCase: sl(),
    getUpcomingReservationsUseCase: sl(),
    createReservationUseCase: sl(),
    checkInReservationUseCase: sl(),
    cancelReservationUseCase: sl(),
    noShowReservationUseCase: sl(),
  ));

  // Use cases
  sl.registerLazySingleton(() => GetAllReservationsUseCase(sl()));
  sl.registerLazySingleton(() => GetTodayReservationsUseCase(sl()));
  sl.registerLazySingleton(() => GetUpcomingReservationsUseCase(sl()));
  sl.registerLazySingleton(() => CreateReservationUseCase(sl()));
  sl.registerLazySingleton(() => CheckInReservationUseCase(sl()));
  sl.registerLazySingleton(() => CancelReservationUseCase(sl()));
  sl.registerLazySingleton(() => NoShowReservationUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<ReservationsRepository>(
        () => ReservationsRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ReservationsRemoteDataSource>(
        () => ReservationsRemoteDataSourceImpl(apiConsumer: sl()),
  );

  //! Core
  sl.registerLazySingleton<ApiConsumer>(
          () => HttpConsumer(client: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerFactory(() => ConnectivityBloc(networkInfo: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}