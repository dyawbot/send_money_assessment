import 'package:floor/floor.dart';
import 'package:send_money_assessment/features/data/models/dao/user_transaction_dao.dart';
import 'package:send_money_assessment/features/data/models/dto/user_transaction_dto.dart';

import 'app_entity.dart';

@Entity(tableName: UserTransactionEntity.tableName)
class UserTransactionEntity extends AppEntity {
  @ignore
  static const String tableName = "user_transactions_tbl";
  @PrimaryKey(autoGenerate: true)
  final int? primaryKey;
  final int phoneNumber;
  final double amount;
  final String? createdDate;

  UserTransactionEntity(this.phoneNumber, this.amount,
      {this.primaryKey, this.createdDate});

  @ignore
  UserTransactionDto toDto() {
    return UserTransactionDto(phoneNumber, amount, createdDate: createdDate);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [primaryKey, phoneNumber, amount, createdDate];
}

@Entity(tableName: UserWalletAmountEntity.tableName)
class UserWalletAmountEntity extends AppEntity {
  @ignore
  static const String tableName = "user_wallet_amount_tbl";

  @primaryKey
  final int primaryId = 1;

  final double walletAmount;
  UserWalletAmountEntity(
    this.walletAmount,
  );

  @override
  List<Object?> get props => [walletAmount];
}
