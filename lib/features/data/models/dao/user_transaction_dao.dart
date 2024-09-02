import 'package:floor/floor.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_assessment/features/data/db/app_database.dart';
import 'package:send_money_assessment/features/data/models/dao/app_dao.dart';

import '../../../domain/entities/user_transaction_entity.dart';

@injectable
@dao
abstract class UserTransactionDao extends AppDao<UserTransactionEntity> {
  @factoryMethod
  static UserTransactionDao create(AppDatabase db) => db.userTransactionDAO;

  @Query("SELECT * FROM ${UserTransactionEntity.tableName}")
  Stream<List<UserTransactionEntity>> getAllLocalData();
}

@injectable
@dao
abstract class UserWalletAmountDao extends AppDao<UserWalletAmountEntity> {
  @factoryMethod
  static UserWalletAmountDao create(AppDatabase db) => db.userWalletAmountDAO;

  @Query("SELECT * FROM ${UserWalletAmountEntity.tableName}")
  Future<UserWalletAmountEntity?> getTheWalletAmount();

  @Query(
      "UPDATE ${UserWalletAmountEntity.tableName}SET walletAmount=:walletAmount WHERE primaryId=1")
  Stream<UserWalletAmountEntity?> updateAmount(String walletAmount);
}
