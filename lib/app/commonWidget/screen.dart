import '../data/all.dart';

class CommonScreen extends StatelessWidget {
  Widget? child;
  Widget floatingActionButton;
  Widget? bottomNavigationBarWidget;

  CommonScreen({
    super.key,
    this.bottomNavigationBarWidget,
    this.child,
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
          backgroundColor: AppColors.primary,
          resizeToAvoidBottomInset: false,
          body: child,
        ),
      ),
    );
  }
}
