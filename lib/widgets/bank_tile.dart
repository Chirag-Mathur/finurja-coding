import 'package:finurja_assignment/screens/bank_transactions.dart';
import 'package:flutter/material.dart';

import '../models/bans_model.dart';

class BankTile extends StatelessWidget {
  final Bank bank;
  const BankTile({Key? key, required this.bank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Image.network(
                      bank.logo,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      bank.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(bank.type),
                        Text(bank.account),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Your balance'),
                        Text(
                          "₹ ${bank.balance.toString()}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                BankTransactionsScreen(bank: bank),
                          ),
                        );
                      },
                      child: Text('View Transactions'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: Divider(
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
