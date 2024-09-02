import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_assessment/common/api_result.dart';
import 'package:send_money_assessment/features/domain/entities/user_transaction_entity.dart';
import 'package:send_money_assessment/features/domain/usecases/user_transaction_usecase.dart';

import '../../../domain/params/user_transaction_params.dart';

part 'transfer_money_event.dart';
part 'transfer_money_state.dart';

@injectable
class TransferMoneyBloc extends Bloc<TransferMoneyEvent, TransferMoneyState> {
  final UserTransactionUsecase _userTransactionUsecase;

  TransferMoneyBloc(this._userTransactionUsecase)
      : super(TransferMoneyInitial()) {
    on<GetUserTransactionEvent>((event, emit) async {
      emit(TransferMoneyLoadingState());

      var result = await _userTransactionUsecase(event.params);
      var status = result.status;

      if (status == Status.success) {
        var data = result.data;
        if (data != null) {
          emit(TransFerMoneySuccessState(data));
        } else {
          emit(TransferMoneyErrorState(result.message!));
        }
      } else {
        var errorInternet = result.errorType;
        if (errorInternet == ErrorType.noInternet) {
          emit(InternetErrorState(result.message!));
        } else {
          emit(TransferMoneyErrorState(result.message!));
        }
      }
    });
  }
}
