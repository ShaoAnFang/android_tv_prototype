import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../../entityies/movie_model.dart';
import 'repositories/HomePageRepositories.dart';
import 'package:intl/intl.dart';

class HomePageController extends GetxController with SingleGetTickerProviderMixin, WidgetsBindingObserver {
  HomePageController({required this.homePageRepository});

  final HomePageRepository homePageRepository;

  final _isLoading = true.obs;
  set isLoading(value) => _isLoading.value = value;
  get isLoading => _isLoading.value;

  final _movieList = <MovieModel>[].obs;
  List<MovieModel> get movieList => _movieList.toList();

  final _onFocusIndex = 0.obs;
  set onFocusIndex(value) => _onFocusIndex.value = value;
  int get onFocusIndex => _onFocusIndex.value;

  late PageController pageController;
  int page = 1;

  bool isMobile = false;

  final _isDrawerExpanded = false.obs;
  set isDrawerExpanded(value) {
    if (value) {
      controller.forward();
    } else {
      controller.reverse();
    }
    _isDrawerExpanded.value = value;
  }

  get isDrawerExpanded => _isDrawerExpanded.value;

  final _pageViewCurrentindex = 0.obs;
  set pageViewCurrentindex(value) => _pageViewCurrentindex.value = value;
  get pageViewCurrentindex => _pageViewCurrentindex.value;

  final initFocusNode = FocusNode();

  final drawerParentFocusNode = FocusNode();

  final _drawerFocusNodes = <FocusNode>[].obs;
  List<FocusNode> get drawerFocusNodes => _drawerFocusNodes.toList();
  late AnimationController controller;

  FocusNode? keepFocusNode;
  @override
  void onInit() async {
    WidgetsBinding.instance.addObserver(this);
    pageController = PageController(viewportFraction: 0.8, keepPage: true);
    _drawerFocusNodes.addAll(List<FocusNode>.generate(7, (index) => FocusNode()));
    controller = AnimationController(
      // value: 0.4,
      vsync: this,
      duration: const Duration(milliseconds: 382),
    )..addListener(() {
        if (controller.status == AnimationStatus.completed) {
          isDrawerExpanded = true;
        } else if (controller.status == AnimationStatus.reverse) {
          isDrawerExpanded = false;
        }
      });

    final startTime = DateTime.now();
    // for (final _ in [1, 2, 3]) {
    await fetchData();
    // }

    final endTime = DateTime.now().difference(startTime).inMilliseconds;
    print('endTime: $endTime');
    // if (GetPlatform.isMobile) {
    //   log('GetPlatform isMobile: ${GetPlatform.isMobile}');
    //   isMobile = GetPlatform.isMobile;
    // }

    // const platform = MethodChannel('android.tv');
    // isTV = await platform.invokeMethod('isLeanbackLauncherDevice');
    // log('isTV: $isTV');
    Map<String, String?> infoMap = {};
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    infoMap["sdk"] = androidDeviceInfo.version.sdkInt.toString();
    infoMap["version"] = androidDeviceInfo.version.baseOS;
    infoMap["board"] = androidDeviceInfo.board.toString();
    infoMap["bootloader"] = androidDeviceInfo.bootloader;
    infoMap["brand"] = androidDeviceInfo.brand;
    infoMap["device"] = androidDeviceInfo.device;
    infoMap["manufacturer"] = androidDeviceInfo.manufacturer;
    infoMap["model"] = androidDeviceInfo.model;
    infoMap["product"] = androidDeviceInfo.product;
    infoMap["isPhysicalDevice"] = androidDeviceInfo.isPhysicalDevice.toString();

    // log(infoMap.toString());
    print(infoMap.toString());
    print(infoMap);

    super.onInit();
  }

  @override
  onClose() {
    controller.dispose();
    super.onClose();
  }

  fetchData() async {
    isLoading = true;
    final dataList = await homePageRepository.getMoives(page: '$page');
    log("dataList length ${dataList.length.toString()}");
    _movieList.addAll(dataList);
    page += 1;
    if (page <= 3) await fetchData();
    isLoading = false;
  }
}
