import 'package:flutter/material.dart';

import '../models/bans_model.dart';

class BankTransactionTile extends StatelessWidget {
  final Tranaction transaction;
  const BankTransactionTile({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            Text(
              transaction.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            transaction.type == "Credit"
                ? Row(
                    children: [
                      Text(
                        "₹ ${transaction.amount.toString()}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_upward,
                        color: Colors.green,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Text(
                        "₹ ${transaction.amount.toString()}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_downward,
                        color: Colors.red,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
