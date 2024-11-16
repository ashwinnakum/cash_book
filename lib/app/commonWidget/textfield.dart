import 'package:cash_book/app/data/all.dart';

class CommonTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final String? helperText;
  final String? labelText;
  final int? maxLines;
  final bool hasError;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final IconData? passwordHideIcon;
  final IconData? passwordShowIcon;
  final TextInputAction? textInputAction;
  final Color? textColor;
  final Color? accentColor;
  List<TextInputFormatter>? inputFormatters;

  CommonTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.onEditingComplete,
    this.helperText,
    this.labelText,
    this.hasError = false,
    this.prefixIcon,
    this.suffixIcon,
    this.passwordHideIcon,
    this.passwordShowIcon,
    this.textInputAction,
    this.textColor,
    this.maxLines = 1,
    this.accentColor,
    this.inputFormatters,
  }) : super(key: key);

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _isObscure = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _isObscure,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      textInputAction: widget.textInputAction,
      maxLines: !_isObscure ? widget.maxLines : 1,
      cursorColor: AppColors.primary,
      inputFormatters: widget.inputFormatters ?? [],
      style: TextStyle(color: widget.textColor ?? Colors.black),
      // Set text color

      decoration: InputDecoration(
        hintText: widget.hintText,

        hintStyle: AppTextStyle(textColor: AppColors.greyColor, textSize: 16.sp),
        labelStyle: TextStyle(color: widget.accentColor ?? Colors.black),
        // Set accent color
        helperText: widget.helperText,
        prefixIcon: widget.prefixIcon,

        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: Icon(_isObscure ? widget.passwordShowIcon ?? Icons.visibility : widget.passwordHideIcon ?? Icons.visibility_off),
                color: widget.accentColor ?? theme.colorScheme.primary,
              )
            : widget.suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.primaryColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.5), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.disabledColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}

class CommonAppTextField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final bool? isSuffixIcon;
  final bool enabled;
  final bool? isPrefixIcon;
  final TextInputType? inputType;
  final bool? isMaxLines;

  final GestureTapCallback? onTap;
  final Color? color;

  final double? height;
  final double? borderRadius;
  final int? maxLines;
  final TextStyle? style;
  TextInputType? keyboardType;
  FocusNode? focusNode;

  final Function(String)? onChanged;
  List<TextInputFormatter>? inputFormatters;

  CommonAppTextField({
    Key? key,
    this.style,
    this.title,
    this.hintText,
    this.labelText,
    required this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.isSuffixIcon = false,
    this.enabled = true,
    this.inputType,
    this.onTap,
    this.isMaxLines = false,
    this.prefixIcon,
    this.borderRadius,
    this.isPrefixIcon = false,
    this.height,
    this.color,
    this.keyboardType,
    this.focusNode,
    this.onChanged,
    this.maxLines = 1,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller!,
      obscureText: obscureText!,
      focusNode: focusNode,
      maxLines: isMaxLines! ? null : maxLines,
      style: AppTextStyle(textColor: Colors.black),
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
      inputFormatters: inputFormatters ?? [],
      decoration: InputDecoration(
        alignLabelWithHint: true,
        enabled: enabled,
        border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.yellowAccent)),
        enabledBorder: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.grey.withOpacity(0.6))),
        focusedBorder: new OutlineInputBorder(borderSide: new BorderSide(color: AppColors.primary)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: AppTextStyle(textColor: AppColors.primary, textSize: 15.sp),
        hintStyle: AppTextStyle(textColor: Colors.grey, textSize: 15.sp),
        contentPadding: EdgeInsets.symmetric(vertical: 15.5.h, horizontal: 15.h),
      ),
    );
  }
}
