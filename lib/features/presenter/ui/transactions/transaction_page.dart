import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:send_money_assessment/common/app_module.dart';
import 'package:send_money_assessment/features/data/models/dto/user_transaction_dto.dart';
import 'package:send_money_assessment/features/data/repository/impl/user_transaction_repo_impl.dart';
import 'package:send_money_assessment/features/data/repository/interfaces/user_transaction_repository.dart';
import 'package:send_money_assessment/features/domain/entities/user_transaction_entity.dart';
import 'package:send_money_assessment/features/presenter/ui/transactions/transactions_cubit.dart';
import 'package:send_money_assessment/features/presenter/widgets/app_color.dart';

@RoutePage()
class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final logger = Logger();
  int totalData = 0;
  List<UserTransactionEntity> listOfTransactions = [];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<UserTransactionRepository>(
              create: (context) => getIt<UserTransactionRepository>()),
          BlocProvider(
              create: (context) =>
                  TransactionsCubit(context.read<UserTransactionRepository>())),
        ],
        child: Scaffold(
          backgroundColor: AppColors.mainBgColor,
          appBar: AppBar(
            title: const Text("Transaction History"),
          ),
          body: BlocBuilder<TransactionsCubit, TransactionsState>(
            builder: (context, state) {
              if (state is TransactionsSuccessState) {
                listOfTransactions = state.userTransactions[1];

                logger.d(listOfTransactions.first.primaryKey);
                totalData = listOfTransactions.length;
              }
              return Container(
                color: AppColors.mainBgColor,
                child: ListView.builder(
                    itemCount: totalData,
                    itemBuilder: (context, index) {
                      final item = listOfTransactions[index];
                      // if (item.cre)
                      return Container(
                        child: ListTile(
                          // ,
                          dense: true,
                          leading: const Icon(
                            Icons.message_rounded,
                            color: AppColors.mainColorDark,
                          ),
                          title: Text("₱${item.phoneNumber}"),
                          subtitle: Text("${item.createdDate}"),
                          trailing: Text(
                            "-₱${item.amount}",
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }),
              );
            },
          ),
        ));
  }
}
