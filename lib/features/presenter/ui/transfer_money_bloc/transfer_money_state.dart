part of 'transfer_money_bloc.dart';

abstract class TransferMoneyState extends Equatable {
  const TransferMoneyState();
}

class TransferMoneyInitial extends TransferMoneyState {
  @override
  List<Object> get props => [];
}

class TransferMoneyLoadingState extends TransferMoneyState {
  @override
  List<Object> get props => [];
}

class TransFerMoneySuccessState extends TransferMoneyState {
  final UserTransactionEntity userTransactionEntity;
  const TransFerMoneySuccessState(this.userTransactionEntity);
  @override
  List<Object> get props => [userTransactionEntity];
}

class TransferMoneyErrorState extends TransferMoneyState {
  final String message;
  const TransferMoneyErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class InternetErrorState extends TransferMoneyState {
  final String message;
  const InternetErrorState(this.message);

  @override
  List<Object> get props => [message];
}
