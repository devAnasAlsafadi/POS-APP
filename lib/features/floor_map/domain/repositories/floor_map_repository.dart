import 'package:dartz/dartz.dart';
import 'package:pos_wiz_tech/core/errors/errors.dart';
import 'package:pos_wiz_tech/features/floor_map/domain/entities/table_entity.dart';

abstract class FloorMapRepository {
  Future<Either<Failure , List<TableEntity>>> getTables();
}