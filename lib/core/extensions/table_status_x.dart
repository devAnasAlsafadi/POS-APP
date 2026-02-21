import 'dart:ui';

import '../../features/floor_map/domain/entities/table_entity.dart';
import '../enum/table_status.dart';
import '../theme/app_color.dart';

extension TableStatusX on TableEntity {
  bool get shouldGlow {
    final status = currentStatus;
    return status == TableStatus.occupied || status == TableStatus.waiting;
  }
}