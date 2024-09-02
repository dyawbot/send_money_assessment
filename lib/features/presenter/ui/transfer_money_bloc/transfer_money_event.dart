part of 'transfer_money_bloc.dart';

abstract class TransferMoneyEvent extends Equatable {
  const TransferMoneyEvent();
}

class GetUserTransactionEvent extends TransferMoneyEvent {
  final UserTransactionParams params;

  GetUserTransactionEvent(this.params);

  @override
  List<Object> get props => [params];
}
