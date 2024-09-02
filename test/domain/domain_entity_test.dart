import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:send_money_assessment/common/api_result.dart';
import 'package:send_money_assessment/features/data/db/app_database.dart';
import 'package:send_money_assessment/features/data/models/dao/user_transaction_dao.dart';
import 'package:send_money_assessment/features/data/models/dto/user_transaction_dto.dart';
import 'package:send_money_assessment/features/data/repository/impl/user_transaction_repo_impl.dart';
import 'package:send_money_assessment/features/data/repository/interfaces/user_transaction_repository.dart';
import 'package:send_money_assessment/features/domain/entities/user_transaction_entity.dart';
import 'package:send_money_assessment/features/domain/params/user_transaction_params.dart';
import 'package:send_money_assessment/features/domain/usecases/user_transaction_usecase.dart';

import 'domain_entity_test.mocks.dart';
@GenerateMocks([UserTransactionRepository])
import 'user_transaction_repository_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase appDatabase;
  late UserTransactionDao userTransactionDao;
  late UserTransactionUsecase usecase;
  late MockUserTransactionRepository mockUserTransactionRepository;

  setUp(() async {
    appDatabase = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    userTransactionDao = appDatabase.userTransactionDAO;

    mockUserTransactionRepository = MockUserTransactionRepository();
    usecase = UserTransactionUsecase(mockUserTransactionRepository);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("UserTransactionEntity unit test", () {
    test("Entity properties must set correctly", () {
      final entity = UserTransactionEntity(09701450476, 500.0);

      expect(entity.phoneNumber, 09701450476);

      expect(entity.amount, 500.0);
      expect(entity.primaryKey, null);
    });

    test('Saving entity to database test', () async {
      final entity = UserTransactionEntity(11111123, 500);
      await userTransactionDao.insert(entity);

      final transaction = await userTransactionDao.getAllLocalData().first;

      expect(transaction, isNotEmpty);
      expect(transaction.first.phoneNumber, entity.phoneNumber);
      expect(transaction.first.amount, entity.amount);
    });

    test('Retrieve All data in data', () async {
      final entity = [
        UserTransactionEntity(11111123, 500),
        UserTransactionEntity(11111124, 500),
        UserTransactionEntity(11111125, 500)
      ];
      await userTransactionDao.insertAll(entity);

      final transaction = await userTransactionDao.getAllLocalData();

      print(transaction);

      expect(entity.length, transaction.length);
      // expect(entity., transaction);

      // expect(transaction, isNotEmpty);
      // expect(transaction.first.phoneNumber, entity.phoneNumber);
      // expect(transaction.first.amount, entity.amount);
    });

    test("success result when repo ret data", () async {
      final params = UserTransactionParams(0901239213, 51.0);
      final userTransaction =
          UserTransactionEntity(params.phoneNumber, params.amountNumber);
      final apiResult = ApiResult.success(userTransaction);

      when(mockUserTransactionRepository.getTransaction(params))
          .thenAnswer((_) async => apiResult);

      final result = await usecase(params);

      expect(result, equals(apiResult));
      verify(mockUserTransactionRepository.getTransaction(params)).called(1);
    });
  });
}
