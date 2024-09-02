import 'dart:async';

import 'package:floor/floor.dart';
import 'package:send_money_assessment/features/data/models/dao/user_transaction_dao.dart';
import 'package:send_money_assessment/features/domain/entities/user_transaction_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [UserTransactionEntity, UserWalletAmountEntity])
abstract class AppDatabase extends FloorDatabase {
  UserTransactionDao get userTransactionDAO;
  UserWalletAmountDao get userWalletAmountDAO;

  static Future<AppDatabase> create() async =>
      $FloorAppDatabase.databaseBuilder("app_database.db").build();
}
