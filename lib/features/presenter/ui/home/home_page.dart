import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:send_money_assessment/common/app_module.dart';
import 'package:send_money_assessment/features/data/repository/impl/user_transaction_repo_impl.dart';
import 'package:send_money_assessment/features/data/repository/interfaces/user_transaction_repository.dart';
import 'package:send_money_assessment/features/domain/usecases/user_transaction_usecase.dart';
import 'package:send_money_assessment/features/presenter/navigation/app_router.dart';
import 'package:send_money_assessment/features/presenter/ui/home/home_cubit.dart';
import 'package:send_money_assessment/features/presenter/widgets/customize_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/app_color.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final logger = Logger();
  double? walletBalance;
  double totalBalanceTransaction = 0.0;
  bool isHidden = false;
  // final use = UserTransactionUsecase(UserTransactionRepository.)

  int numberOfTransactions = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 200), () async {
      await checkHideBalance();
    });
  }

  Future<void> checkHideBalance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isHidden = prefs.getBool('isHidden') ?? false;
    });
  }

  void _showValidation() {
    showModalBottomSheet(
        backgroundColor: AppColors.mainBgColor,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
        builder: (context) {
          double _h = MediaQuery.of(context).size.height;
          double _w = MediaQuery.of(context).size.width;

          final con = AutoRouter.of(context);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: SizedBox(
                height: _h * 0.35,
                // color: Colors.,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: _h * 0.081,
                      width: _w * 0.18,
                      child: Image.asset(
                        "assets/error.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: _h * 0.025,
                    ),
                    const Text(
                      "Opss, there's no trasactions to display. Thank you.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                          onPressed: () {
                            con.maybePop();
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              backgroundColor: AppColors.mainColor,
                              fixedSize: Size(_w, _h * 0.05)),
                          child: const Text(
                            "Close",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    final router = AutoRouter.of(context);

    return MultiProvider(
      providers: [
        Provider<UserTransactionRepository>(
          create: (context) => getIt<UserTransactionRepository>(),
        ),
        BlocProvider(
            create: (context) =>
                HomeCubit(context.read<UserTransactionRepository>())),
      ],
      child: Scaffold(
        backgroundColor: AppColors.mainBgColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, homeState) {
                  logger.d(homeState);
                  double? walletAmountApi = 0.0;
                  if (homeState is HomeSuccessState) {
                    var data = homeState.userTransactions[1];
                    walletAmountApi = homeState.userTransactions[0];
                    var listOfAmount = data.map((e) => e.amount).toList();

                    totalBalanceTransaction =
                        listOfAmount.fold(0.0, (sum, item) => sum + item);

                    logger.d(totalBalanceTransaction);
                    logger.d(walletAmountApi);

                    walletBalance = walletAmountApi == null
                        ? 500.0 - totalBalanceTransaction
                        : walletAmountApi - totalBalanceTransaction;

                    // setState(() {

                    //   walletBalance = walletAmountApi;
                    // });
                    logger.d(walletBalance);

                    numberOfTransactions = data.length;
                    logger.d(numberOfTransactions);
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      const Text(
                        "MySendIt",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "a sending money application",
                        style: TextStyle(fontSize: 14, color: Colors.black45),
                      ),
                      SizedBox(
                        height: _height * 0.03,
                      ),
                      Center(
                        child: Container(
                            width: _width,
                            height: _height * 0.23,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0, vertical: 24),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            //? showing user's balance moeny ****************
                                            walletBalance == null
                                                ? const CircularProgressIndicator(
                                                    color:
                                                        AppColors.mainColorDark,
                                                  )
                                                : Text(
                                                    isHidden
                                                        ? "₱••••"
                                                        : "₱$walletBalance",
                                                    style: const TextStyle(
                                                        fontSize: 28,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),

                                            const Text("Wallet balance")
                                          ],
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              final SharedPreferences _prefs =
                                                  await SharedPreferences
                                                      .getInstance();

                                              setState(() {
                                                isHidden = !isHidden;
                                              });

                                              await _prefs.setBool(
                                                  'isHidden', isHidden);
                                            },
                                            icon: !isHidden
                                                ? const Icon(
                                                    Icons.visibility,
                                                    size: 32,
                                                  )
                                                : const Icon(
                                                    Icons.visibility_off,
                                                    size: 32,
                                                  ))
                                      ],
                                    ),

                                    //? This is a send money button **********************
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 1,
                                            backgroundColor: AppColors.btnColor,
                                            fixedSize: Size(
                                                _width * 0.85, _height * 0.03),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12))),
                                        onPressed: () {
                                          router.push(TransferMoneyRoute(
                                              walletBalance:
                                                  walletBalance ?? 500.0));
                                        },
                                        child: const Text(
                                          "Send Money",
                                          style: TextStyle(
                                              color: AppColors.mainColorDark,
                                              fontWeight: FontWeight.bold),
                                        )),

                                    //? A Transaction Button **********************
                                  ],
                                ))),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: Container(
                          width: _width,
                          // height: _height * 0.15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 24),
                              child: MyCustomizeButton(
                                  buttonLabel: "View Transaction History",
                                  buttonInfo: numberOfTransactions == 0
                                      ? const Text("No transactions")
                                      : Text(
                                          "$numberOfTransactions transactions"),
                                  suffixIcon: Icon(Icons.arrow_forward_ios),
                                  onPressedButton: () {
                                    // context.read<HomeCubit>().listenToApiChanges();
                                    logger.d("HELLO");

                                    if (numberOfTransactions == 0) {
                                      _showValidation();
                                    } else {
                                      router.push(TransactionRoute());
                                    }
                                  })),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
