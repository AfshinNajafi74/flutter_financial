import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expenditure/controller/add_edit_transaction_controller.dart';
import 'package:income_expenditure/core/constant/extensions.dart';
import 'package:income_expenditure/core/widgets/animated_list_wrapper.dart';
import 'package:income_expenditure/model/category_model/category_model.dart';
import 'package:income_expenditure/model/transaction_model/transaction_model.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  // AddEditTransactionController transactionController = Get.find<AddEditTransactionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تراکنش ها"),),
      body: GetBuilder<AddEditTransactionController>(
        init: AddEditTransactionController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FutureBuilder(
              future: controller.fetchTransactions(),
              builder: (context, snapshot) {
                List<TransactionModel> data = snapshot.data != null ? snapshot.data as List<TransactionModel> : [];
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Colors.green,));
                } else if (data.isNotEmpty && snapshot.data != null){
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      TransactionModel transaction = data[index];
                      return AnimatedListWrapper(
                        index: index,
                        child: Card(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: transaction.typeCategory == TypeCategory.payment ? Colors.red : Colors.green,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(transaction.name),
                                    Text(DateTime.fromMillisecondsSinceEpoch(transaction.dateTime).showDate(context)),
                                    Text( transaction.typeCategory == TypeCategory.payment ?
                                        "-${transaction.amount}" : "+${transaction.amount}",
                                      style: TextStyle(
                                        color: transaction.typeCategory == TypeCategory.payment ? Colors.red : Colors.green
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("no data",),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
