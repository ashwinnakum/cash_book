import 'package:flutter/gestures.dart';

import '../data/all.dart';

class AppText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final double? fontSize;
  final Color? color;
  final double? letterSpacing;
  final double? height;
  final TextDecoration textDecoration;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  AppText(
    this.text, {
    this.fontSize,
    this.color,
    this.fontFamily = FontFamily.medium,
    this.letterSpacing,
    this.overflow,
    this.textDecoration = TextDecoration.none,
    this.textAlign = TextAlign.start,
    this.height,
    this.maxLines = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        height: height ?? 1.3,
        color: color ?? AppColors.blackColor,
        fontFamily: fontFamily,
        fontSize: fontSize ?? FontSize.s18,
        letterSpacing: letterSpacing,
        decoration: textDecoration,
        overflow: overflow,
        decorationColor: color ?? AppColors.blackColor,
      ),
    );
  }
}

class AppTextStyle extends TextStyle {
  final Color? textColor;
  final double? textSize;
  final String? textFamily;
  final TextDecoration? textDecorations;
  final Paint? textBackground;
  final double? textLetterSpacing;
  final double? textHeight;
  final TextOverflow? overflow;

  AppTextStyle({
    this.textHeight,
    this.textColor = AppColors.blackColor,
    this.textSize,
    this.textFamily = FontFamily.medium,
    this.textDecorations,
    this.textBackground,
    this.textLetterSpacing,
    this.overflow,
  })  : assert(textColor != null),
        super(
          color: textColor,
          fontSize: textSize ?? FontSize.s18,
          fontFamily: textFamily,
          decoration: textDecorations,
          background: textBackground,
          letterSpacing: textLetterSpacing,
          height: textHeight,
          overflow: overflow,
        );
}

class AppRichText extends StatelessWidget {
  final String? firstText;
  final String? secondText;
  final String? thirdText;
  final String? forthText;
  final double? height;
  final String? firstTextFontFamily;
  final String? secondTextFontFamily;
  final String? thirdTextFontFamily;
  final String? fourthTextFontFamily;
  final FontWeight? firstFontWeight;
  final FontWeight? secondFontWeight;
  final FontWeight? thirdFontWeight;
  final FontWeight? fourthFontWeight;
  final TextDecoration? firstDecoration;
  final TextDecoration? secondDecoration;
  final TextDecoration? thirdDecoration;
  final TextDecoration? fourthDecoration;
  final Color? firstTextColor;
  final Color? secondTextColor;
  final Color? thirdTextColor;
  final Color? fourthTextColor;
  final TextAlign? textAlign;
  final double? fontSize;
  final Function()? onTap;
  final Function()? onTapFourth;

  const AppRichText(
      {super.key,
      this.firstText,
      this.secondText,
      this.onTap,
      this.thirdText,
      this.forthText,
      this.onTapFourth,
      this.firstTextColor,
      this.secondTextColor,
      this.thirdTextColor,
      this.fourthTextColor,
      this.fontSize,
      this.firstTextFontFamily,
      this.firstFontWeight,
      this.fourthFontWeight,
      this.secondFontWeight,
      this.thirdFontWeight,
      this.height,
      this.textAlign,
      this.fourthTextFontFamily,
      this.secondTextFontFamily,
      this.thirdTextFontFamily,
      this.firstDecoration,
      this.secondDecoration,
      this.thirdDecoration,
      this.fourthDecoration});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: RichText(
        textAlign: textAlign ?? TextAlign.start,
        overflow: TextOverflow.visible,
        text: TextSpan(
          text: firstText!,
          recognizer: TapGestureRecognizer()..onTap = () {},
          style: TextStyle(
            fontSize: fontSize ?? FontSize.s14,
            color: firstTextColor ?? const Color(0xFF808080),
            fontFamily: firstTextFontFamily ?? FontFamily.medium,
            height: height ?? 1.3,
            decoration: firstDecoration,
          ),
          children: [
            TextSpan(
              text: secondText!,
              recognizer: TapGestureRecognizer()..onTap = onTap,
              style: TextStyle(
                fontSize: fontSize ?? FontSize.s14,
                color: secondTextColor ?? AppColors.darkText,
                fontFamily: secondTextFontFamily ?? FontFamily.medium,
                decoration: secondDecoration,
              ),
            ),
            TextSpan(
              text: thirdText ?? "",
              recognizer: TapGestureRecognizer()..onTap = () {},
              style: TextStyle(
                fontSize: fontSize ?? FontSize.s14,
                color: thirdTextColor ?? AppColors.darkText,
                fontFamily: thirdTextFontFamily ?? FontFamily.medium,
                decoration: thirdDecoration,
              ),
            ),
            TextSpan(
              text: forthText ?? "",
              recognizer: TapGestureRecognizer()..onTap = onTapFourth,
              style: TextStyle(
                fontSize: fontSize ?? FontSize.s14,
                color: fourthTextColor ?? AppColors.primary,
                fontFamily: fourthTextFontFamily ?? FontFamily.medium,
                decoration: fourthDecoration,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
