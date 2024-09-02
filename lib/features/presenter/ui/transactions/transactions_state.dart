part of 'transactions_cubit.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();
}

class TransactionsInitial extends TransactionsState {
  @override
  List<Object> get props => [];
}

class TransactionsLoadingState extends TransactionsState {
  @override
  List<Object> get props => [];
}

class TransactionsSuccessState extends TransactionsState {
  final Map<int, dynamic> userTransactions;

  TransactionsSuccessState(this.userTransactions);
  @override
  List<Object> get props => [userTransactions];
}

class TransactionsErrorState extends TransactionsState {
  final String? message;
  TransactionsErrorState({this.message});
  @override
  List<Object?> get props => [message];
}

class TransactionsNoInternetError extends TransactionsState {
  final String? message;
  TransactionsNoInternetError({this.message});
  @override
  List<Object?> get props => [message];
}
