import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/bans_model.dart';
import '../widgets/bank_transaction_tile.dart';

enum SortTransaction { latest, oldest }

class BankTransactionsScreen extends StatefulWidget {
  final Bank bank;
  const BankTransactionsScreen({Key? key, required this.bank})
      : super(key: key);

  @override
  State<BankTransactionsScreen> createState() => _BankTransactionsScreenState();
}

class _BankTransactionsScreenState extends State<BankTransactionsScreen> {
  bool isCredit = true;
  bool isDebit = true;
  bool isOldestFirst = false;
  bool isRange = false;
  int minimumAmount = 0;
  int maximumAmount = 10000;
  RangeValues _currentRange = RangeValues(0, 10000);

  DateTime _transactionDate = DateTime.now();

  List<Tranaction> _visibleTransactions = [];

  void updateTransactions() {
    List<Tranaction> visibleTransactions = [];

    widget.bank.tranactions.forEach((transaction) {
      if ((transaction.amount >= minimumAmount &&
                  transaction.amount <= maximumAmount ||
              !isRange) &&
          (isCredit && transaction.type == "Credit" ||
              isDebit && transaction.type == "Debit")) {
        visibleTransactions.add(transaction);
      }
    });

    if (isOldestFirst) {
      visibleTransactions.sort((a, b) => a.date.compareTo(b.date));
    } else {
      visibleTransactions.sort((a, b) => b.date.compareTo(a.date));
    }

    setState(() {
      _visibleTransactions = visibleTransactions;
    });
  }

  @override
  void initState() {
    updateTransactions();
    super.initState();
  }

  SortTransaction? _sortTransaction = SortTransaction.latest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Bank Transactions')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.network(
                          widget.bank.logo,
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.bank.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "₹ ${widget.bank.balance.toString()}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${widget.bank.type} \t(${widget.bank.account}) \t 2.5% p.a.',
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 4,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Last 10 Transactions",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (context) => StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setModalState) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Sort & Filter",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Spacer(),
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: Icon(Icons.close)),
                                              ],
                                            ),
                                            Divider(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Sort by Time",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            ListTile(
                                              title: Text(
                                                "Latest to Oldest",
                                              ),
                                              leading: Radio<SortTransaction>(
                                                value: SortTransaction.latest,
                                                groupValue: _sortTransaction,
                                                onChanged: (value) {
                                                  setModalState(() {
                                                    _sortTransaction = value;
                                                    isOldestFirst = false;
                                                  });
                                                },
                                              ),
                                            ),
                                            ListTile(
                                              title: Text("Oldest to Latest"),
                                              leading: Radio<SortTransaction>(
                                                value: SortTransaction.oldest,
                                                groupValue: _sortTransaction,
                                                onChanged: (value) {
                                                  setModalState(() {
                                                    _sortTransaction = value;
                                                    isOldestFirst = true;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Filter by",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            ListTile(
                                              title: Text("Credit"),
                                              leading: Checkbox(
                                                value: isCredit,
                                                onChanged: (value) {
                                                  setModalState(() {
                                                    isCredit = !isCredit;
                                                  });
                                                },
                                              ),
                                            ),
                                            ListTile(
                                              title: Text("Debit"),
                                              leading: Checkbox(
                                                value: isDebit,
                                                onChanged: (value) {
                                                  setModalState(() {
                                                    isDebit = !isDebit;
                                                  });
                                                },
                                              ),
                                            ),
                                            ListTile(
                                              title: Text(
                                                  "Amount Between ₹${minimumAmount} and ₹${maximumAmount}"),
                                              leading: Checkbox(
                                                value: isRange,
                                                onChanged: (value) {
                                                  setModalState(() {
                                                    isRange = !isRange;
                                                  });
                                                },
                                              ),
                                            ),
                                            RangeSlider(
                                              max: 100000.0,
                                              min: 0.0,
                                              divisions: 100000,
                                              labels: RangeLabels(
                                                _currentRange.start.toString(),
                                                _currentRange.end.toString(),
                                              ),
                                              values: _currentRange,
                                              onChanged: (values) {
                                                setModalState(() {
                                                  _currentRange = values;
                                                  print(_currentRange);
                                                  minimumAmount =
                                                      values.start.toInt();
                                                  maximumAmount =
                                                      values.end.toInt();
                                                });
                                              },
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    setModalState(() {
                                                      isCredit = true;
                                                      isDebit = true;
                                                      isOldestFirst = false;
                                                      isRange = false;
                                                    });
                                                    updateTransactions();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            Colors.deepPurple,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 64.0,
                                                        vertical: 16.0,
                                                      ),
                                                      child: Text("Reset"),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    updateTransactions();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color:
                                                              Colors.deepPurple,
                                                        ),
                                                        color:
                                                            Colors.deepPurple),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 64.0,
                                                        vertical: 16.0,
                                                      ),
                                                      child: Text(
                                                        "Apply",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]),
                                    ),
                                  );
                                }),
                              );
                            },
                            icon: Icon(Icons.filter_alt))
                      ],
                    ),
                    // SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        isCredit
                            ? Chip(
                                label: Text(
                                  "Credit",
                                ),
                                onDeleted: () {
                                  setState(() {
                                    isCredit = false;
                                  });
                                  updateTransactions();
                                },
                              )
                            : Container(),
                        SizedBox(width: 20),
                        isDebit
                            ? Chip(
                                label: Text(
                                  "Debit",
                                ),
                                onDeleted: () {
                                  setState(() {
                                    isDebit = false;
                                  });
                                  updateTransactions();
                                },
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemBuilder: ((context, index) {
                      if (_transactionDate !=
                              _visibleTransactions[index].date ||
                          index == 0) {
                        _transactionDate = _visibleTransactions[index].date;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              thickness: 1,
                            ),
                            Text(
                              DateFormat('dd/MMM/yy')
                                  .format(_visibleTransactions[index].date),
                            ),
                            BankTransactionTile(
                              transaction: _visibleTransactions[index],
                            )
                          ],
                        );
                      }
                      return BankTransactionTile(
                        transaction: _visibleTransactions[index],
                      );
                    }),
                    itemCount: _visibleTransactions.length),
              ),
            )
          ],
        ),
      ),
    );
  }
}
