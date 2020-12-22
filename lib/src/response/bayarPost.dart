class BayarResponse {
  bool success;
  Data data;

  BayarResponse({this.success, this.data});

  BayarResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String batasWaktu;
  String orderId;
  String amount;
  String currency;
  String transactionTime;
  String transactionStatus;
  List<Bank> bank;

  Data(
      {this.batasWaktu,
      this.orderId,
      this.amount,
      this.currency,
      this.transactionTime,
      this.transactionStatus,
      this.bank});

  Data.fromJson(Map<String, dynamic> json) {
    batasWaktu = json['batas_waktu'];
    orderId = json['orderId'];
    amount = json['amount'];
    currency = json['currency'];
    transactionTime = json['transaction_time'];
    transactionStatus = json['transaction_status'];
    if (json['bank'] != null) {
      bank = new List<Bank>();
      json['bank'].forEach((v) {
        bank.add(new Bank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batas_waktu'] = this.batasWaktu;
    data['orderId'] = this.orderId;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['transaction_time'] = this.transactionTime;
    data['transaction_status'] = this.transactionStatus;
    if (this.bank != null) {
      data['bank'] = this.bank.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bank {
  String bank;
  String vaNumber;

  Bank({this.bank, this.vaNumber});

  Bank.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    vaNumber = json['va_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank'] = this.bank;
    data['va_number'] = this.vaNumber;
    return data;
  }
}
