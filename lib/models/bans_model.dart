// To parse this JSON data, do
//
//     final banksModel = banksModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BanksModel banksModelFromJson(String str) => BanksModel.fromJson(json.decode(str));

String banksModelToJson(BanksModel data) => json.encode(data.toJson());

class BanksModel {
    BanksModel({
        required this.banks,
    });

    List<Bank> banks;

    factory BanksModel.fromJson(Map<String, dynamic> json) => BanksModel(
        banks: List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "banks": List<dynamic>.from(banks.map((x) => x.toJson())),
    };
}

class Bank {
    Bank({
        required this.name,
        required this.type,
        required this.account,
        required this.balance,
        required this.logo,
        required this.tranactions,
    });

    String name;
    String type;
    String account;
    int balance;
    String logo;
    List<Tranaction> tranactions;

    factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        name: json["name"],
        type: json["type:"],
        account: json["account"],
        balance: json["balance"],
        logo: json["logo"],
        tranactions: List<Tranaction>.from(json["tranactions"].map((x) => Tranaction.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "type:": type,
        "account": account,
        "balance": balance,
        "logo": logo,
        "tranactions": List<dynamic>.from(tranactions.map((x) => x.toJson())),
    };
}

class Tranaction {
    Tranaction({
        required this.name,
        required this.type,
        required this.amount,
        required this.date,
    });

    String name;
    String type;
    int amount;
    DateTime date;

    factory Tranaction.fromJson(Map<String, dynamic> json) => Tranaction(
        name: json["name"],
        type: json["type"],
        amount: json["amount"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "amount": amount,
        "date": date.toIso8601String(),
    };
}
