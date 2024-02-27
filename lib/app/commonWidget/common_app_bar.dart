import '../data/all.dart';

class CommonAppBar extends StatelessWidget {
  String? title;
  bool? isLeading;
  bool isAppBar;
  Widget rightWidget;
  void Function()? leadingOnTap;

  EdgeInsetsGeometry? appBarRowPadding;

  CommonAppBar({
    super.key,
    this.title,
    this.isLeading = true,
    this.isAppBar = true,
    this.appBarRowPadding,
    this.leadingOnTap,
    this.rightWidget = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: appBarRowPadding ?? EdgeInsets.only(left: FontSize.defaultBackPadding, right: FontSize.defaultBackPadding, top: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: isLeading!,
            child: GestureDetector(
              onTap: leadingOnTap ??
                      () {
                    Get.back();
                  },
              child: Image.asset(ImagePath.imagesIcBack),
            ),
          ),
          rightWidget
        ],
      ),
    );
  }
}
