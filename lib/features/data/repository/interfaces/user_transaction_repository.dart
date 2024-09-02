import 'package:send_money_assessment/common/api_result.dart';
import 'package:send_money_assessment/features/data/repository/interfaces/app_repository.dart';
import 'package:send_money_assessment/features/domain/entities/user_transaction_entity.dart';
import 'package:send_money_assessment/features/domain/params/user_transaction_params.dart';

abstract class UserTransactionRepository extends AppRepository {
  Stream<ApiResult<Map<int, dynamic>>> getAllTransactionsStream();
  Future<ApiResult<UserTransactionEntity>> getTransaction(
      UserTransactionParams params);
}
