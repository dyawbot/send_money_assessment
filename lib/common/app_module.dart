import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:get_it/get_it.dart' as _i1;
import 'package:send_money_assessment/features/data/db/app_database.dart';

import 'app_module.config.dart';

@module
abstract class AppModule {
  @Named("global")
  @lazySingleton
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker.createInstance();

  @lazySingleton
  http.Client get httpClient => http.Client();

  @lazySingleton
  Dio get dio => Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 30),
      ));

  @preResolve
  Future<AppDatabase> get db => AppDatabase.create();
}

final getIt = _i1.GetIt.instance;
@InjectableInit()
Future<void> configureDepencies() async => await getIt.init();
