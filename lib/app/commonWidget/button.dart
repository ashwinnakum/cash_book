import '../data/all.dart';

class CommonButton extends StatelessWidget {
  void Function() onTap;
  String text;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  Color? color;
  Color? borderColor;
  Color? textColor;
  double? fontSize;
  bool isNextIcon;

  CommonButton({
    super.key,
    required this.onTap,
    required this.text,
    this.padding,
    this.margin,
    this.color,
    this.fontSize,
    this.borderColor,
    this.textColor,
    this.isNextIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: margin,
          padding: padding ?? EdgeInsets.symmetric(vertical: 21.h),
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color ?? AppColors.primary,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: AppText(
            text,
            fontFamily: FontFamily.bold,
            fontSize: fontSize ?? FontSize.s14,
            color: textColor ?? AppColors.whiteColor,
          )),
    );
  }
}
