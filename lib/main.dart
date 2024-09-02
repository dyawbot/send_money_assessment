import 'package:flutter/material.dart';
import 'package:send_money_assessment/common/app_module.dart';
import 'package:send_money_assessment/features/presenter/widgets/app_color.dart';

import 'features/presenter/navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDepencies().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
        useMaterial3: true,
      ),
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
