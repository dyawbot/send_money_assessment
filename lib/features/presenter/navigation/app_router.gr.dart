// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    TransactionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TransactionPage(),
      );
    },
    TransferMoneyRoute.name: (routeData) {
      final args = routeData.argsAs<TransferMoneyRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TransferMoneyPage(
          args.walletBalance,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TransactionPage]
class TransactionRoute extends PageRouteInfo<void> {
  const TransactionRoute({List<PageRouteInfo>? children})
      : super(
          TransactionRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransactionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TransferMoneyPage]
class TransferMoneyRoute extends PageRouteInfo<TransferMoneyRouteArgs> {
  TransferMoneyRoute({
    required double walletBalance,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          TransferMoneyRoute.name,
          args: TransferMoneyRouteArgs(
            walletBalance: walletBalance,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'TransferMoneyRoute';

  static const PageInfo<TransferMoneyRouteArgs> page =
      PageInfo<TransferMoneyRouteArgs>(name);
}

class TransferMoneyRouteArgs {
  const TransferMoneyRouteArgs({
    required this.walletBalance,
    this.key,
  });

  final double walletBalance;

  final Key? key;

  @override
  String toString() {
    return 'TransferMoneyRouteArgs{walletBalance: $walletBalance, key: $key}';
  }
}
