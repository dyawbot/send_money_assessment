import 'package:injectable/injectable.dart';
import 'package:send_money_assessment/common/api_result.dart';
import 'package:send_money_assessment/features/data/repository/interfaces/user_transaction_repository.dart';
import 'package:send_money_assessment/features/domain/params/user_transaction_params.dart';
import 'package:send_money_assessment/features/domain/usecases/usecases.dart';

import '../entities/user_transaction_entity.dart';

@injectable
class UserTransactionUsecase extends Usecases<
    Future<ApiResult<UserTransactionEntity>>, UserTransactionParams> {
  final UserTransactionRepository _repository;

  UserTransactionUsecase(this._repository);
  @override
  call(UserTransactionParams params) => _repository.getTransaction(params);
}
