import 'package:get/get.dart';

import '../modules/add_detail/bindings/add_detail_binding.dart';
import '../modules/add_detail/views/add_detail_view.dart';
import '../modules/detail/bindings/detail_binding.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/generate_report/bindings/generate_report_binding.dart';
import '../modules/generate_report/views/generate_report_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DETAIL,
      page: () => const AddDetailView(),
      binding: AddDetailBinding(),
    ),
    GetPage(
      name: _Paths.GENERATE_REPORT,
      page: () => const GenerateReportView(),
      binding: GenerateReportBinding(),
    ),
  ];
}
