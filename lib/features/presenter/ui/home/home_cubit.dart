import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_assessment/features/data/repository/impl/user_transaction_repo_impl.dart';
import 'package:send_money_assessment/features/data/repository/interfaces/user_transaction_repository.dart';
import 'package:send_money_assessment/features/domain/entities/user_transaction_entity.dart';
import 'package:send_money_assessment/features/domain/usecases/user_transaction_usecase.dart';

import '../../../../common/api_result.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final UserTransactionRepository _userTransactionRepository;

  HomeCubit(this._userTransactionRepository) : super(HomeInitial()) {
    listenToApiChanges();
  }

  listenToApiChanges() {
    _userTransactionRepository.getAllTransactionsStream().listen((result) {
      var status = result.status;

      if (status == Status.success) {
        var data = result.data;
        if (data != null) {
          if (data.isNotEmpty) {
            emit(HomeSuccessState(data));
          } else {
            emit(HomeErrorState(message: result.message));
          }
        } else {
          emit(HomeErrorState(message: result.message));
        }
      } else {
        emit(HomeErrorState(message: result.message));
      }
    });
  }
}
