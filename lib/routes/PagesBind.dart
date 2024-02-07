import 'package:android_tv_prototype/pages/searchPage/repositories/SearchPageRepositories.dart';
import 'package:get/get.dart';
import '../pages/HomePage/HomePageController.dart';
import '../pages/HomePage/repositories/HomePageRepositoriesImpl.dart';
import '../pages/IssueDetailPage/IssueDetailPageController.dart';
import '../pages/IssueDetailPage/repositories/IssueDetailPageRepositoriesImpl.dart';
import '../pages/searchPage/SearchPageController.dart';

class PagesBind implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<MainPageController>(() => MainPageController());
    Get.lazyPut(() => HomePageController(homePageRepository: HomePageRepositoryImpl()));

    Get.lazyPut(() => SearchPageController(searchPageRepository: SearchPageRepositoryImpl(), homePageRepository: HomePageRepositoryImpl()));

    Get.lazyPut(() => IssueDetailPageController(issueDetailPageRepository: IssueDetailPageRepositoryImpl()));
  }
}
