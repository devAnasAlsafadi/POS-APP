import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/floor_map/data/data_source/floor_map_remote_data_source.dart';
import '../../features/floor_map/data/repositories/floor_map_repository_impl.dart';
import '../../features/floor_map/domain/repositories/floor_map_repository.dart';
import '../../features/floor_map/domain/usecases/get_tables_usecase.dart';
import '../../features/floor_map/presentation/blocs/floor_map_bloc.dart';
import '../api/api_consumer.dart';
import '../api/http_consumer.dart';
import '../blocs/connectivity/connectivity_bloc.dart';
import '../network/network_info.dart';

final sl  = GetIt.instance;

Future<void> init () async {

  // API Consumer
  sl.registerLazySingleton<ApiConsumer>(() => HttpConsumer(client: sl()));


  // External
  sl.registerLazySingleton(() => http.Client());


  sl.registerFactory(() => ConnectivityBloc(networkInfo: sl()));
  sl.registerFactory(() => FloorMapBloc(getTablesUseCase: sl()));


  sl.registerLazySingleton(() => GetTablesUseCase(repository: sl()),);

  sl.registerLazySingleton<FloorMapRepository>(
        () => FloorMapRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<FloorMapRemoteDataSource>(
        () => FloorMapRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());


}