import 'package:send_money_assessment/features/domain/entities/app_entity.dart';

abstract class AppDto<T extends AppEntity> {
  T toEntity();
}
