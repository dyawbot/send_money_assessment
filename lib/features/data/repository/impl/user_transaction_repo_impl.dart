import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:send_money_assessment/common/api_result.dart';
import 'package:send_money_assessment/features/data/models/api/user_transaction_api.dart';
import 'package:send_money_assessment/features/data/models/dao/user_transaction_dao.dart';
import 'package:send_money_assessment/features/data/models/dto/user_transaction_dto.dart';
import 'package:send_money_assessment/features/data/repository/interfaces/user_transaction_repository.dart';
import 'package:send_money_assessment/features/domain/entities/user_transaction_entity.dart';
import 'package:send_money_assessment/features/domain/params/user_transaction_params.dart';

@Injectable(as: UserTransactionRepository)
class UserTransactionRepoImpl extends UserTransactionRepository {
  final Logger logger = Logger();
  final UserTransactionApi _userTransactionApi;
  final UserTransactionDao _userTransactionDao;
  final UserWalletAmountDao _userWalletAmountDao;

  final InternetConnectionChecker _internetConnectionChecker;

  UserTransactionRepoImpl(
      this._userTransactionApi,
      this._userTransactionDao,
      this._userWalletAmountDao,
      @Named("global") this._internetConnectionChecker);

  @override
  Stream<ApiResult<Map<int, dynamic>>> getAllTransactionsStream() async* {
    // Listen for changes in the local database
    yield* _userTransactionDao
        .getAllLocalData()
        .asyncExpand((transactionLocalDb) async* {
      if (transactionLocalDb.isEmpty) {
        yield const ApiResult.success(null,
            message: "No transactions", errorType: ErrorType.nullData);
      } else {
        // Always emit the local data first
        var data = {
          0: null,
          1: transactionLocalDb
              .map((e) => UserTransactionEntity(e.phoneNumber, e.amount,
                  createdDate: e.createdDate))
              .toList()
        };
        yield ApiResult.success(data);
      }

      // Check for internet connection
      if (!(await _internetConnectionChecker.hasConnection)) {
        yield const ApiResult.noInternetConnection();
      } else {
        // var amountBalance = await _userWalletAmountDao.getTheWalletAmount();

        var amountBalance = await _userWalletAmountDao.getTheWalletAmount();
        var localData = transactionLocalDb
            .map((e) => UserTransactionDto(e.phoneNumber, e.amount,
                createdDate: e.createdDate))
            .toList();

        //initially the wallet balnce is 500

        var body = UserDataTransactionDto(
          localData,
          walletAmount: amountBalance?.walletAmount,
        );

        try {
          // get the api by calling it here
          logger.d(body.toJson());
          var response =
              await _userTransactionApi.getAllTransactions(body.toJson());

          // Convert the API response to entities and yield success
          var dataEntity = response.data
              .map((e) => UserTransactionEntity(e.phoneNumber, e.amount,
                  createdDate: e.createdDate))
              .toList();

          // Yield the success result with API data

          var finalData = {
            0: response.walletAmount,
            1: dataEntity,
          };
          yield ApiResult.success(finalData);
        } catch (e) {
          // Handle any exceptions and yield error
          yield ApiResult.error(
              "Failed to fetch transactions: ${e.toString()}");
        }
        // });
      }
    });
  }

  @override
  Future<ApiResult<UserTransactionEntity>> getTransaction(
      UserTransactionParams params) async {
    //? Check local db
    // var transactionLocalDb = await _userTransactionDao.getAllLocalData();
    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    var _walletBalance = await _userWalletAmountDao.getTheWalletAmount();

    if (!(await _internetConnectionChecker.hasConnection)) {
      return const ApiResult.noInternetConnection();
    } else {
      var parameters = UserTransactionDto(
          params.phoneNumber, params.amountNumber,
          createdDate: formattedDateTime);
      await _userWalletAmountDao
          .insert(UserWalletAmountEntity(params.walletAmoubt!));

      try {
        var response =
            await _userTransactionApi.createTransaction(parameters.toJson());
        // if(response.)
        await _userTransactionDao.insert(response.toEntity());
        return ApiResult.success(response.toEntity());
      } on DioException catch (e) {
        logger.e(e);
        return const ApiResult.connectionFailed();
      } on Exception catch (e) {
        logger.e(e);

        return ApiResult.error(
            "There's a promblem to the server. Error: ${e.toString()}");
      }
    }
  }
}
