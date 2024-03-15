import '../data/all.dart';

class CommonBottomSheet extends StatelessWidget {
  final Widget? widget;
  final double? borderRadius;
  final Color? bottomSheetColor;
  final EdgeInsetsGeometry? padding;

  const CommonBottomSheet({Key? key, this.widget, this.borderRadius, this.padding, this.bottomSheetColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(borderRadius ?? 12.r),
          topLeft: Radius.circular(borderRadius ?? 12.r),
        ),
      ),
      child: Padding(padding: padding ?? EdgeInsets.symmetric(horizontal: 0, vertical: 20.h), child: widget),
    );
  }
}
