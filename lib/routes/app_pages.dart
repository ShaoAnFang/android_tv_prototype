import 'package:android_tv_prototype/pages/HomePage/HomePage.dart';
import 'package:get/get.dart';
import 'PagesBind.dart';

part 'app_routes.dart';

class AppPages {
  static const initPage = AppRoutes.homePage;
  static final routes = [
    GetPage(
      name: AppRoutes.homePage,
      page: () => HomePage(),
      binding: PagesBind(),
      children: [],
    ),
  ];
}
