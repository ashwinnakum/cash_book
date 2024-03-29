import 'app/data/all.dart';

Future<void> main() async {
  EasyLoading.init();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Loading();
    Utils.screenPortrait();
    Utils().appStatusBar();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        title: Strings.appName,
        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.primary,
            selectionHandleColor: AppColors.primary,
            selectionColor: AppColors.primary.withOpacity(0.2),
          ),
        ),
        builder: EasyLoading.init(),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  }
}
