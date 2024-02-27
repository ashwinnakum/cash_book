import '../data/all.dart';

class CommonModel {
  String? name;
  String? id;
  String? price;
  String? icon;
  RxBool? isCheck;
  GlobalKey? globalKey;
  Color? color;
  Widget? widget;
  List<CommonModel>? list;

  CommonModel({
    this.name,
    this.icon,
    this.isCheck,
    this.id,
    this.globalKey,
    this.color,
    this.widget,
    this.price,
    this.list,
  });
}
