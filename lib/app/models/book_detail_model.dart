class BookDetailModel {
  Data? data;
  int? responseCode;
  String? responseMsg;
  String? result;
  String? serverTime;

  BookDetailModel({this.data, this.responseCode, this.responseMsg, this.result, this.serverTime});

  BookDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    responseCode = json['ResponseCode'];
    responseMsg = json['ResponseMsg'];
    result = json['Result'];
    serverTime = json['ServerTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['ResponseCode'] = this.responseCode;
    data['ResponseMsg'] = this.responseMsg;
    data['Result'] = this.result;
    data['ServerTime'] = this.serverTime;
    return data;
  }
}

class Data {
  dynamic netBalance;
  dynamic totalIn;
  dynamic totalOut;
  dynamic totalBookHistories;
  List<BookHistories>? bookHistories;

  Data({this.netBalance, this.totalIn, this.totalOut, this.totalBookHistories, this.bookHistories});

  Data.fromJson(Map<String, dynamic> json) {
    netBalance = json['net_balance'];
    totalIn = json['total_in'];
    totalOut = json['total_out'];
    totalBookHistories = json['total_book_histories'];
    if (json['book_histories'] != null) {
      bookHistories = <BookHistories>[];
      json['book_histories'].forEach((v) {
        bookHistories!.add(new BookHistories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['net_balance'] = this.netBalance;
    data['total_in'] = this.totalIn;
    data['total_out'] = this.totalOut;
    data['total_book_histories'] = this.totalBookHistories;
    if (this.bookHistories != null) {
      data['book_histories'] = this.bookHistories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookHistories {
  int? bhId;
  int? bookId;
  String? cashType;
  dynamic amount;
  dynamic balance;
  String? remark;
  String? entryDate;
  String? entryTime;
  String? createdAt;
  String? updatedAt;
  bool? isSelect;
  List<Attaches>? attaches;

  BookHistories(
      {this.bhId,
      this.bookId,
      this.cashType,
      this.amount,
      this.balance,
      this.remark,
      this.entryDate,
      this.entryTime,
      this.createdAt,
      this.updatedAt,
      this.isSelect = false,
      this.attaches});

  BookHistories.fromJson(Map<String, dynamic> json) {
    bhId = json['bh_id'];
    bookId = json['book_id'];
    cashType = json['cash_type'];
    amount = json['amount'];
    balance = json['balance'];
    remark = json['remark'];
    entryDate = json['entry_date'];
    entryTime = json['entry_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isSelect = false;
    if (json['attaches'] != null) {
      attaches = <Attaches>[];
      json['attaches'].forEach((v) {
        attaches!.add(new Attaches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bh_id'] = this.bhId;
    data['book_id'] = this.bookId;
    data['cash_type'] = this.cashType;
    data['amount'] = this.amount;
    data['balance'] = this.balance;
    data['remark'] = this.remark;
    data['entry_date'] = this.entryDate;
    data['entry_time'] = this.entryTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['isSelect'] = this.isSelect;
    if (this.attaches != null) {
      data['attaches'] = this.attaches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attaches {
  int? mediaId;
  int? bhId;
  String? name;

  Attaches({this.mediaId, this.bhId, this.name});

  Attaches.fromJson(Map<String, dynamic> json) {
    mediaId = json['media_id'];
    bhId = json['bh_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['media_id'] = this.mediaId;
    data['bh_id'] = this.bhId;
    data['name'] = this.name;
    return data;
  }
}
