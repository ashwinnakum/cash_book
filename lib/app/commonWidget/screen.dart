import '../data/all.dart';

class CommonScreen extends StatelessWidget {
  Widget? child;
  Widget floatingActionButton;
  Widget? bottomNavigationBarWidget;
  Color? backgroundColor;
  bool resizeToAvoidBottomInset;

  CommonScreen({
    super.key,
    this.bottomNavigationBarWidget,
    this.child,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = false,
    this.floatingActionButton = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    Utils().appStatusBar();
    return SafeArea(
      top: false,
      bottom: false,
      child: GestureDetector(
        onTap: () {
          Utils().hideKeyboard();
        },
        child: Scaffold(
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBarWidget ?? const SizedBox(),
          backgroundColor: backgroundColor ?? AppColors.primary,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          body: child,
        ),
      ),
    );
  }
}
