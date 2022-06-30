import '../models/bans_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/bank_tile.dart';

class BankListScreen extends StatefulWidget {
  const BankListScreen({Key? key}) : super(key: key);

  @override
  State<BankListScreen> createState() => _BankListScreenState();
}

class _BankListScreenState extends State<BankListScreen> {
  bool _isLoading = true;

  BanksModel _banks = BanksModel(banks: []);

  Future<void> loadBanks() async {
    final jsonString = await rootBundle.loadString('assets/bank_data.json');
    _banks = banksModelFromJson(jsonString);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    loadBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'All Bank Accounts',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.builder(
                itemCount: _banks.banks.length,
                itemBuilder: (context, index) {
                  final bank = _banks.banks[index];
                  return BankTile(bank: bank);
                },
              ),
            ),
    );
  }
}
