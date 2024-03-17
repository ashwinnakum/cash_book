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
  double? borderRadius;
  bool isLeftButton;
  Widget? leftIcon;
  Border? border;

  CommonButton({
    super.key,
    required this.onTap,
    required this.text,
    this.padding,
    this.margin,
    this.color,
    this.fontSize,
    this.borderRadius,
    this.borderColor,
    this.textColor,
    this.leftIcon,
    this.border,
    this.isLeftButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: margin,
          padding: padding ?? EdgeInsets.symmetric(vertical: 19.h),
          alignment: Alignment.center,
          width: double.infinity,
          decoration:
              BoxDecoration(color: color ?? AppColors.primary, borderRadius: BorderRadius.circular(borderRadius ?? 8.r), border: border ?? Border()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(visible: isLeftButton, child: leftIcon ?? Icon(Icons.picture_as_pdf_outlined)),
              AppText(
                text,
                fontFamily: FontFamily.bold,
                fontSize: fontSize ?? FontSize.s16,
                letterSpacing: 1.25,
                color: textColor ?? AppColors.whiteColor,
              ),
            ],
          )),
    );
  }
}
