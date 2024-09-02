import 'package:floor/floor.dart';
import 'package:send_money_assessment/features/domain/entities/app_entity.dart';

abstract class AppDao<T extends AppEntity> {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(T data);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<T> data);
}
