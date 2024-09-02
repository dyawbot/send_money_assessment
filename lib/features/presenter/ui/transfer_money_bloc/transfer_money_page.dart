import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:send_money_assessment/features/domain/params/user_transaction_params.dart';
import 'package:send_money_assessment/features/presenter/navigation/app_router.dart';
import 'package:send_money_assessment/features/presenter/ui/transfer_money_bloc/transfer_money_bloc.dart';
import 'package:send_money_assessment/features/presenter/widgets/app_color.dart';
import 'package:send_money_assessment/features/presenter/widgets/custom_textform_field.dart';

import '../../../../common/app_module.dart';

@RoutePage()
class TransferMoneyPage extends StatefulWidget {
  final double walletBalance;
  const TransferMoneyPage(this.walletBalance, {Key? key}) : super(key: key);

  @override
  State<TransferMoneyPage> createState() => _TransferMoneyPageState();
}

class _TransferMoneyPageState extends State<TransferMoneyPage> {
  final logger = Logger();
  final _transactionBloc = getIt<TransferMoneyBloc>();
  bool isLoading = false;

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountNumberController = TextEditingController();

  void _sendMoney() {
    double? parsedAmount = double.tryParse(amountNumberController.text);
    if (parsedAmount != null && widget.walletBalance < parsedAmount) {
      String message =
          "The amount you want to send ₱$parsedAmount is less than the amount of your wallet balance";
      _showBottomDialogSheet(false, message);
    } else {
      final params = UserTransactionParams(
          int.tryParse(phoneNumberController.text)!,
          double.tryParse(amountNumberController.text)!,
          walletAmoubt: widget.walletBalance);
      _transactionBloc.add(GetUserTransactionEvent(params));
    }
  }

  void _showBottomDialogSheet(bool successful, String message) {
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
            child: successful
                ? SizedBox(
                    height: _h * 0.35,
                    // color: Colors.,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: _h * 0.081,
                          width: _w * 0.2,
                          child: Image.asset(
                            "assets/success_icon.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: _h * 0.02,
                        ),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                              onPressed: () {
                                con.replace(HomeRoute());
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: AppColors.mainColor,
                                  fixedSize: Size(_w, _h * 0.05)),
                              child: const Text(
                                "Done",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ))
                : SizedBox(
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
                          height: _h * 0.02,
                        ),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                              onPressed: () {
                                con.replace(HomeRoute());
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

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents dismissing by tapping outside the dialog
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor:
              Colors.transparent, // Makes the background transparent
          child: SizedBox(
            height: 100,
            width: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return BlocConsumer<TransferMoneyBloc, TransferMoneyState>(
      bloc: _transactionBloc,
      listener: (context, state) {
        // TODO: implement listener
        logger.d(state);
        if (state is TransferMoneyLoadingState) {
          logger.d("HMM ADD LOADING STATE");

          setState(() {
            isLoading = !isLoading;
          });

          if (isLoading == true) {
            _showLoadingDialog(context);
          }
        }

        if (state is TransFerMoneySuccessState) {
          if (isLoading) {
            Navigator.pop(context);
          }
          setState(() {
            isLoading = false;
          });
          logger.d("THE STATE IS SUCCESSFULLLLLLLL");
          double amount = state.userTransactionEntity.amount;
          String message = "You successfully transferred\n₱$amount";
          _showBottomDialogSheet(true, message);
        }

        if (state is InternetErrorState) {
          if (isLoading) {
            Navigator.pop(context);
          }
          setState(() {
            isLoading = false;
          });
          _showBottomDialogSheet(false, state.message);
        }

        if (state is TransferMoneyErrorState) {
          logger.d("ERROR OCCURED");
          if (isLoading) {
            Navigator.pop(context);
          }
          setState(() {
            isLoading = false;
          });
          _showBottomDialogSheet(false, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: _width,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Send Money",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    )),
                const SizedBox(
                  height: 24,
                ),
                MyCustomTextFormField(
                  inputType: TextInputType.number,
                  controller: phoneNumberController,
                  hintText: "Phone Number",
                ),
                const SizedBox(
                  height: 12,
                ),
                MyCustomTextFormField(
                  inputType: TextInputType.numberWithOptions(decimal: true),
                  controller: amountNumberController,
                  hintText: "Amount",
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: AppColors.mainColor,
                        fixedSize: Size(_width, _height * 0.05)),
                    onPressed: _sendMoney,
                    child: const Text("Send")),
              ],
            ),
          )),
        );
      },
    );
  }
}
