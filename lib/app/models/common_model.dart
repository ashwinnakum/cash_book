import '../data/all.dart';

class CommonModel {
  String? name;
  String? type;
  int? id;
  RxBool? isNetwork;

  CommonModel({
    this.name,
    this.isNetwork,
    this.type,
    this.id,
  });
}
