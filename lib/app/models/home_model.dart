class HomeModel {
  HomeData? data;
  int? responseCode;
  String? responseMsg;
  String? result;
  String? serverTime;

  HomeModel({this.data, this.responseCode, this.responseMsg, this.result, this.serverTime});

  HomeModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
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

class HomeData {
  int? netBalance;
  int? totalIn;
  int? totalOut;
  List<BookHistories>? bookHistories;

  HomeData({this.netBalance, this.totalIn, this.totalOut, this.bookHistories});

  HomeData.fromJson(Map<String, dynamic> json) {
    netBalance = json['net_balance'];
    totalIn = json['total_in'];
    totalOut = json['total_out'];
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
    if (this.bookHistories != null) {
      data['book_histories'] = this.bookHistories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookHistories {
  int? bookId;
  String? name;
  String? updatedAt;
  String? createdAt;
  int? netBalance;

  BookHistories({this.bookId, this.name, this.updatedAt, this.netBalance});

  BookHistories.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    name = json['name'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    netBalance = json['net_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['name'] = this.name;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['net_balance'] = this.netBalance;
    return data;
  }
}

class BookHistoryData {
  int? bhId;
  int? bookId;
  String? cacheType;
  int? amount;
  String? remark;
  String? entryDate;
  String? entryTime;
  String? media;
  String? updatedAt;

  BookHistoryData({this.bhId, this.bookId, this.cacheType, this.amount, this.remark, this.entryDate, this.entryTime, this.media, this.updatedAt});

  BookHistoryData.fromJson(Map<String, dynamic> json) {
    bhId = json['bh_id'];
    bookId = json['book_id'];
    cacheType = json['cache_type'];
    amount = json['amount'];
    remark = json['remark'];
    entryDate = json['entry_date'];
    entryTime = json['entry_time'];
    media = json['media'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bh_id'] = this.bhId;
    data['book_id'] = this.bookId;
    data['cache_type'] = this.cacheType;
    data['amount'] = this.amount;
    data['remark'] = this.remark;
    data['entry_date'] = this.entryDate;
    data['entry_time'] = this.entryTime;
    data['media'] = this.media;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
