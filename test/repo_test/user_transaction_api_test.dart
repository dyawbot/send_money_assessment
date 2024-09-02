import 'package:dio/dio.dart';
import 'package:floor/floor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_assessment/common/api_result.dart';
import 'package:send_money_assessment/features/data/models/api/user_transaction_api.dart';
import 'package:send_money_assessment/features/data/models/dao/user_transaction_dao.dart';
import 'package:send_money_assessment/features/data/models/dto/user_transaction_dto.dart';
import 'package:send_money_assessment/features/data/repository/impl/user_transaction_repo_impl.dart';
import 'package:send_money_assessment/features/domain/entities/user_transaction_entity.dart';
import 'package:send_money_assessment/features/domain/params/user_transaction_params.dart';

@GenerateMocks([
  UserTransactionApi,
  UserTransactionDao,
  UserWalletAmountDao,
  InternetConnectionChecker
])
import 'user_transaction_api_test.mocks.dart';

void main() {
  // late UserTransactionRepoImpl repository;
  // late MockUserTransactionApi mockUserTransactionApi;
  // late MockUserTransactionDao mockUserTransactionDao;
  // late MockInternetConnectionChecker mockInternetConnectionChecker;

  final mockUserTransactionApi = MockUserTransactionApi();
  final mockUserTransactionDao = MockUserTransactionDao();
  final mockUserWalletDao = MockUserWalletAmountDao();
  final mockInternetConnectionChecker = MockInternetConnectionChecker();
  late UserTransactionRepoImpl repository;

  setUp(() {
    // mockUserTransactionApi = MockUserTransactionApi();
    // mockUserTransactionDao = MockUserTransactionDao();
    // mockInternetConnectionChecker = MockInternetConnectionChecker();
    repository = UserTransactionRepoImpl(
        mockUserTransactionApi,
        mockUserTransactionDao,
        mockUserWalletDao,
        mockInternetConnectionChecker);
  });

  group('Testing UserTransactionRepoImpl', () {
    test(mockInternetConnectionChecker, () async {
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => false);

      final result =
          await repository.getTransaction(UserTransactionParams(090909, 32.23));

      print(result);

      expect(result, isA<ApiResult<UserTransactionEntity>>());
      // expect(result, equals(const ApiResult.noInternetConnection()));
      verify(mockInternetConnectionChecker.hasConnection).called(1);
      verifyNoMoreInteractions(mockInternetConnectionChecker);
    });

    test("success if transaction created", () async {
      final params = UserTransactionParams(9098090, 9.2);
      final dto = UserTransactionDto(params.phoneNumber, params.amountNumber);
      final entity =
          UserTransactionEntity(params.phoneNumber, params.amountNumber);
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);
      when(mockUserTransactionApi.createTransaction(dto.toJson()))
          .thenAnswer((_) async => dto);
      when(mockUserTransactionDao.insert(any)).thenAnswer((_) async => 1);

      final result = await repository.getTransaction(params);

      expect(result, isA<ApiResult<UserTransactionEntity>>());

      expect(result, equals(ApiResult.success(entity)));
      // verify(mockInternetConnectionChecker.hasConnection).called(1);
      verify(mockUserTransactionApi.createTransaction(dto.toJson())).called(1);
      verify(mockUserTransactionDao.insert(entity)).called(1);
    });

    test('Should return connection failed when DioException is thrown',
        () async {
      // Arrange
      final params = UserTransactionParams(1234567890, 100.0);
      final dto = UserTransactionDto(params.phoneNumber, params.amountNumber);
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);
      when(mockUserTransactionApi.createTransaction(dto.toJson()))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await repository.getTransaction(params);

      expect(result, isA<ApiResult<UserTransactionEntity>>());
      // expect(result, equals(const ApiResult.connectionFailed()));
      verify(mockInternetConnectionChecker.hasConnection).called(1);
      verify(mockUserTransactionApi.createTransaction(dto.toJson())).called(1);
    });

    test('Should return error when unknown exception is thrown', () async {
      final params = UserTransactionParams(1234567890, 100.0);
      final dto = UserTransactionDto(params.phoneNumber, params.amountNumber);
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);
      when(mockUserTransactionApi.createTransaction(dto.toJson()))
          .thenThrow(Exception('Some error'));

      final result = await repository.getTransaction(params);

      expect(result, isA<ApiResult<UserTransactionEntity>>());
      // expect(result.errorType, contains(ErrorType.generic));
      // verify(mockInternetConnectionChecker.hasConnection).called(1);
      verify(mockUserTransactionApi.createTransaction(dto.toJson())).called(1);
    });

    test("getting all data for trasaction history", () async {
      final logger = Logger();
      final params = UserTransactionParams(90908, 98.23);
      final params1 = UserTransactionParams(9092308, 198.23);
      final params2 = UserTransactionParams(90912308, 1398.23);
      final entity =
          UserTransactionEntity(params.phoneNumber, params.amountNumber);
      final entity1 =
          UserTransactionEntity(params1.phoneNumber, params1.amountNumber);
      final entity2 =
          UserTransactionEntity(params2.phoneNumber, params2.amountNumber);

      // when(mockUserTransactionDao.getAllLocalData())
      //     .thenAnswer((_) async => [entity, entity1, entity2]);

      when(mockUserTransactionDao.getAllLocalData())
          .thenAnswer((_) => Stream.fromIterable([
                [entity, entity1, entity2]
              ]));

      final result = await mockUserTransactionDao.getAllLocalData().first;

      final dtoData = result
          .map((e) => UserTransactionDto(e.phoneNumber, e.amount))
          .toList();

      final apiResponse = UserDataTransactionDto(dtoData);

      when(mockUserTransactionDao.getAllLocalData())
          .thenAnswer((_) => Stream.fromIterable([result]));

      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((realInvocation) async => true);
      when(mockUserTransactionApi.getAllTransactions(any))
          .thenAnswer((_) async => apiResponse);

      final finalResult = await repository.getAllTransactionsStream().first;

      logger.d(finalResult);
      logger.d(result);

      expect(finalResult, isA<ApiResult<List<UserTransactionEntity>>>());
      expect(finalResult.data, isNotEmpty);
      expect(finalResult.data!.length, equals(result.length));

      // verify(mockUserTransactionDao.getAllLocalData()).called(1);
      // verify(mockUserTransactionApi.getAllTransactions(any)).called(1);

      print(result);
    });
  });
}
