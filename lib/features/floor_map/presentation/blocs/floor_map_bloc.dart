import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_wiz_tech/core/developer.dart';
import '../../../../core/errors/errors.dart';
import '../../domain/entities/table_entity.dart';
import '../../domain/usecases/get_tables_usecase.dart';

part 'floor_map_event.dart';
part 'floor_map_state.dart';

class FloorMapBloc extends Bloc<FloorMapEvent, FloorMapState> {
  final GetTablesUseCase getTablesUseCase;

  FloorMapBloc({required this.getTablesUseCase}) : super(FloorMapInitial()) {

    on<GetTablesEvent>((event, emit) async {
      AppLogger.info('here loading');
      emit(FloorMapLoading());
      AppLogger.info('here loading');
      final result = await getTablesUseCase();

      result.fold(
        (failure) {
          if (failure is OfflineFailure) {
            emit(FloorMapOffline());
          } else {
            emit(const FloorMapError("عذراً، فشل في جلب البيانات من السيرفر"));
          }
        },
        (tables) {
          emit(FloorMapLoaded(tables));
        },
      );
    });
  }
}
