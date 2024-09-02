// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserTransactionDao? _userTransactionDAOInstance;

  UserWalletAmountDao? _userWalletAmountDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user_transactions_tbl` (`primaryKey` INTEGER PRIMARY KEY AUTOINCREMENT, `phoneNumber` INTEGER NOT NULL, `amount` REAL NOT NULL, `createdDate` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user_wallet_amount_tbl` (`primaryId` INTEGER NOT NULL, `walletAmount` REAL NOT NULL, PRIMARY KEY (`primaryId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserTransactionDao get userTransactionDAO {
    return _userTransactionDAOInstance ??=
        _$UserTransactionDao(database, changeListener);
  }

  @override
  UserWalletAmountDao get userWalletAmountDAO {
    return _userWalletAmountDAOInstance ??=
        _$UserWalletAmountDao(database, changeListener);
  }
}

class _$UserTransactionDao extends UserTransactionDao {
  _$UserTransactionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _userTransactionEntityInsertionAdapter = InsertionAdapter(
            database,
            'user_transactions_tbl',
            (UserTransactionEntity item) => <String, Object?>{
                  'primaryKey': item.primaryKey,
                  'phoneNumber': item.phoneNumber,
                  'amount': item.amount,
                  'createdDate': item.createdDate
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserTransactionEntity>
      _userTransactionEntityInsertionAdapter;

  @override
  Stream<List<UserTransactionEntity>> getAllLocalData() {
    return _queryAdapter.queryListStream('SELECT * FROM user_transactions_tbl',
        mapper: (Map<String, Object?> row) => UserTransactionEntity(
            row['phoneNumber'] as int, row['amount'] as double,
            primaryKey: row['primaryKey'] as int?,
            createdDate: row['createdDate'] as String?),
        queryableName: 'user_transactions_tbl',
        isView: false);
  }

  @override
  Future<void> insert(UserTransactionEntity data) async {
    await _userTransactionEntityInsertionAdapter.insert(
        data, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAll(List<UserTransactionEntity> data) async {
    await _userTransactionEntityInsertionAdapter.insertList(
        data, OnConflictStrategy.replace);
  }
}

class _$UserWalletAmountDao extends UserWalletAmountDao {
  _$UserWalletAmountDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _userWalletAmountEntityInsertionAdapter = InsertionAdapter(
            database,
            'user_wallet_amount_tbl',
            (UserWalletAmountEntity item) => <String, Object?>{
                  'primaryId': item.primaryId,
                  'walletAmount': item.walletAmount
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserWalletAmountEntity>
      _userWalletAmountEntityInsertionAdapter;

  @override
  Future<UserWalletAmountEntity?> getTheWalletAmount() async {
    return _queryAdapter.query('SELECT * FROM user_wallet_amount_tbl',
        mapper: (Map<String, Object?> row) =>
            UserWalletAmountEntity(row['walletAmount'] as double));
  }

  @override
  Stream<UserWalletAmountEntity?> updateAmount(String walletAmount) {
    return _queryAdapter.queryStream(
        'UPDATE user_wallet_amount_tblSET walletAmount=?1 WHERE primaryId=1',
        mapper: (Map<String, Object?> row) =>
            UserWalletAmountEntity(row['walletAmount'] as double),
        arguments: [walletAmount],
        queryableName: 'no_table_name',
        isView: false);
  }

  @override
  Future<void> insert(UserWalletAmountEntity data) async {
    await _userWalletAmountEntityInsertionAdapter.insert(
        data, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAll(List<UserWalletAmountEntity> data) async {
    await _userWalletAmountEntityInsertionAdapter.insertList(
        data, OnConflictStrategy.replace);
  }
}
