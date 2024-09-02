import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/home/home_page.dart';
import '../ui/transactions/transaction_page.dart';
import '../ui/transfer_money_bloc/transfer_money_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  // TODO: implement routes
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: TransferMoneyRoute.page),
        AutoRoute(page: TransactionRoute.page),
      ];
}
