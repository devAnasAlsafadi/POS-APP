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
import '../../features/floor_map/data/data_source/tables_remote_data_source.dart';
import '../../features/floor_map/data/repositories/table_repository_impl.dart';
import '../../features/floor_map/domain/repositories/table_repository.dart';
import '../../features/floor_map/domain/usecases/get_tables_usecase.dart';
import '../../features/floor_map/presentation/blocs/floor_map_bloc.dart';

// Core & API
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
import '../../features/products/presentation/blocs/cart_bloc/cart_bloc.dart';
import '../../features/orders/domain/usecases/get_order_by_id_use_case.dart';
import '../../features/orders/domain/usecases/create_order_use_case.dart';
import '../../features/orders/domain/usecases/get_active_orders_use_case.dart';
import '../../features/orders/domain/usecases/update_order_status_use_case.dart';
import '../../features/orders/domain/usecases/serve_order_use_case.dart';
import '../../features/orders/domain/usecases/request_bill_use_case.dart';
import '../api/api_consumer.dart';
import '../api/http_consumer.dart';
import '../blocs/connectivity/connectivity_bloc.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {

  //! Features - Floor Map
  // Blocs
  sl.registerFactory(() => FloorMapBloc(getTablesUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTablesUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<TableRepository>(
        () => TableRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<TablesRemoteDataSource>(
        () => TablesRemoteDataSourceImpl(api: sl()),
  );
  // Products Feature (renamed from Orders)
  sl.registerFactory(() => ProductBloc(getMenuDataUseCase: sl()));
  sl.registerLazySingleton(() => GetMenuDataUseCase(sl()));
  sl.registerLazySingleton<ProductsRepository>(
        () => ProductsRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ProductsRemoteDataSource>(
        () => ProductsRemoteDataSourceImpl(api: sl()),
  );

  // Orders Feature (New)
  sl.registerFactory(() => CartBloc(
    getOrderByIdUseCase: sl(),
    createOrderUseCase: sl(),
    updateOrderStatusUseCase: sl(),
    serveOrderUseCase: sl(),
    requestBillUseCase: sl(),
  ));
  
  sl.registerLazySingleton(() => GetOrderByIdUseCase(sl()));
  sl.registerLazySingleton(() => CreateOrderUseCase(sl()));
  sl.registerLazySingleton(() => GetActiveOrdersUseCase(sl())); // If used elsewhere
  sl.registerLazySingleton(() => UpdateOrderStatusUseCase(sl()));
  sl.registerLazySingleton(() => ServeOrderUseCase(sl()));
  sl.registerLazySingleton(() => RequestBillUseCase(sl()));
  
  sl.registerLazySingleton(() => GetOrdersUseCase(sl()));
  sl.registerLazySingleton<OrdersRepository>(
        () => OrdersRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<OrdersRemoteDataSource>(
        () => OrdersRemoteDataSourceImpl(api: sl()),
  );

  //! Features - Auth
  // Blocs
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
  ));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(api: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(sharedPreferences: sl()));






  //! Core
  sl.registerLazySingleton<ApiConsumer>(() => HttpConsumer(client: sl(),sharedPreferences: sl(),));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerFactory(() => ConnectivityBloc(networkInfo: sl()));







  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}