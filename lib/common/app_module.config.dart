// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:send_money_assessment/common/app_module.dart' as _i870;
import 'package:send_money_assessment/features/data/db/app_database.dart'
    as _i518;
import 'package:send_money_assessment/features/data/models/api/user_transaction_api.dart'
    as _i632;
import 'package:send_money_assessment/features/data/models/dao/user_transaction_dao.dart'
    as _i1006;
import 'package:send_money_assessment/features/data/repository/impl/user_transaction_repo_impl.dart'
    as _i831;
import 'package:send_money_assessment/features/data/repository/interfaces/user_transaction_repository.dart'
    as _i953;
import 'package:send_money_assessment/features/domain/usecases/user_transaction_usecase.dart'
    as _i442;
import 'package:send_money_assessment/features/presenter/ui/home/home_cubit.dart'
    as _i65;
import 'package:send_money_assessment/features/presenter/ui/transfer_money_bloc/transfer_money_bloc.dart'
    as _i1044;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i518.AppDatabase>(
      () => appModule.db,
      preResolve: true,
    );
    gh.lazySingleton<_i519.Client>(() => appModule.httpClient);
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.factory<_i1006.UserTransactionDao>(
        () => _i1006.UserTransactionDao.create(gh<_i518.AppDatabase>()));
    gh.factory<_i1006.UserWalletAmountDao>(
        () => _i1006.UserWalletAmountDao.create(gh<_i518.AppDatabase>()));
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => appModule.internetConnectionChecker,
      instanceName: 'global',
    );
    gh.factory<_i632.UserTransactionApi>(
        () => _i632.UserTransactionApi.create(gh<_i361.Dio>()));
    gh.factory<_i953.UserTransactionRepository>(
        () => _i831.UserTransactionRepoImpl(
              gh<_i632.UserTransactionApi>(),
              gh<_i1006.UserTransactionDao>(),
              gh<_i1006.UserWalletAmountDao>(),
              gh<_i973.InternetConnectionChecker>(instanceName: 'global'),
            ));
    gh.factory<_i442.UserTransactionUsecase>(() =>
        _i442.UserTransactionUsecase(gh<_i953.UserTransactionRepository>()));
    gh.factory<_i1044.TransferMoneyBloc>(
        () => _i1044.TransferMoneyBloc(gh<_i442.UserTransactionUsecase>()));
    gh.factory<_i65.HomeCubit>(
        () => _i65.HomeCubit(gh<_i953.UserTransactionRepository>()));
    return this;
  }
}

class _$AppModule extends _i870.AppModule {}
