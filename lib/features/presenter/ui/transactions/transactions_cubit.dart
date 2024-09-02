import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:send_money_assessment/features/data/repository/impl/user_transaction_repo_impl.dart';
import 'package:send_money_assessment/features/data/repository/interfaces/user_transaction_repository.dart';

import '../../../../common/api_result.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final UserTransactionRepository _userTransactionRepository;

  TransactionsCubit(this._userTransactionRepository)
      : super(TransactionsInitial()) {
    listenToApiChanges();
  }

  listenToApiChanges() {
    _userTransactionRepository.getAllTransactionsStream().listen((result) {
      var status = result.status;

      if (status == Status.success) {
        var data = result.data;
        if (data != null) {
          if (data.isNotEmpty) {
            emit(TransactionsSuccessState(data));
          } else {
            emit(TransactionsErrorState(message: result.message));
          }
        } else {
          emit(TransactionsErrorState(message: result.message));
        }
      } else {
        emit(TransactionsErrorState(message: result.message));
      }
    });
  }
}
