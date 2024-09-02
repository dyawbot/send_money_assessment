import 'package:equatable/equatable.dart';
import 'package:send_money_assessment/features/domain/usecases/usecases.dart';

class UserTransactionParams extends Params {
  final int phoneNumber;
  final double amountNumber;
  final double? walletAmoubt;
  final String? createdAt;

  UserTransactionParams(this.phoneNumber, this.amountNumber,
      {this.walletAmoubt, this.createdAt});

  @override
  List<Object?> get props =>
      [phoneNumber, amountNumber, walletAmoubt, createdAt];
}
