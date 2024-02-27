import '../data/all.dart';

class CommonModel {
  String? name;
  String? id;
  String? icon;
  RxBool? isCheck;
  GlobalKey? globalKey;
  Color? color;
  Widget? widget;

  CommonModel({this.name, this.icon, this.isCheck, this.id, this.globalKey, this.color, this.widget});
}
