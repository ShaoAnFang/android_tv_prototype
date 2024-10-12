import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:android_tv_prototype/entityies/tv_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../../entityies/movie_model.dart';
import '../../entityies/live_tv_model.dart';
import 'repositories/HomePageRepositories.dart';
import 'package:intl/intl.dart';

class HomePageController extends GetxController with SingleGetTickerProviderMixin, WidgetsBindingObserver {
  HomePageController({required this.homePageRepository});

  final HomePageRepository homePageRepository;

  final _isLoading = true.obs;
  set isLoading(value) {
    _isLoading.value = value;
    // if (!value) setPreviewTimer();
  }

  get isLoading => _isLoading.value;

  final _isMovie = true.obs;
  set isMovie(value) => _isMovie.value = value;
  bool get isMovie => _isMovie.value;

  final _movieList = <MovieModel>[].obs;
  List<MovieModel> get movieList => _movieList.toList();

  final _mainMovieList = <MovieModel>[].obs;
  List<MovieModel> get mainMovieList => _mainMovieList.toList();

  final _popularMovieList = <MovieModel>[].obs;
  List<MovieModel> get popularMovieList => _popularMovieList.toList();

  final _tvSeriesList = <TVModel>[].obs;
  List<TVModel> get tvSeriesList => _tvSeriesList.toList();

  final _onFocusIndex = 0.obs;
  set onFocusIndex(value) => _onFocusIndex.value = value;
  int get onFocusIndex => _onFocusIndex.value;

  late PageController pageController;
  int page = 1;
  int popularPage = 1;
  int tvPage = 1;

  bool isMobile = false;

  final _drawerCategory = "主頁".obs;
  set drawerCategory(value) => _drawerCategory.value = value;
  String get drawerCategory => _drawerCategory.value;

  final _pageViewCurrentindex = 0.obs;
  set pageViewCurrentindex(value) => _pageViewCurrentindex.value = value;
  get pageViewCurrentindex => _pageViewCurrentindex.value;

  final initFocusNode = FocusNode();

  final drawerParentFocusNode = FocusNode();

  final _drawerFocusNodes = <FocusNode>[].obs;
  List<FocusNode> get drawerFocusNodes => _drawerFocusNodes.toList();
  late AnimationController controller;

  FocusNode? keepFocusNode;

  final _previewPlay = false.obs;
  set previewPlay(value) => _previewPlay.value = value;
  bool get previewPlay => _previewPlay.value;

  int previewCountDownTime = 8;
  late Timer previewTimer;

  // final _isSearch = false.obs;
  // set isSearch(value) => _isSearch.value = value;
  // get isSearch => _isSearch.value;

  @override
  void onInit() async {
    WidgetsBinding.instance.addObserver(this);
    pageController = PageController(viewportFraction: 0.85, keepPage: true);
    _drawerFocusNodes.addAll(List<FocusNode>.generate(7, (index) => FocusNode()));

    await readLocalChannelJson();
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
    // previewTimer.cancel();
    super.onClose();
  }

  setPreviewTimer() {
    previewCountDownTime = 8;
    previewPlay = false;
    previewTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (previewCountDownTime == 0) {
        previewPlay = true;
        timer.cancel();
      } else {
        previewCountDownTime--;
        previewPlay = false;
      }
    });
  }

  //discover movie
  fetchData() async {
    isLoading = true;
    _movieList.clear();

    final dataList = await homePageRepository.getMoives(page: '$page');
    log("GetMoives dataList length ${dataList.length.toString()}");

    page += 1;
    if (page <= 3) {
      _mainMovieList.addAll(dataList);
      await fetchData();
    } else {
      _mainMovieList.addAll(dataList);
      _movieList.addAll(_mainMovieList);
      isMovie = true;
    }
    isLoading = false;
  }

  fetchPopularData() async {
    isLoading = true;
    _movieList.clear();

    final dataList = await homePageRepository.getMoviePopular(page: '$popularPage');
    log("GetMoviePopular dataList length ${dataList.length.toString()}");
    popularPage += 1;
    if (popularPage <= 3) {
      _popularMovieList.addAll(dataList);
      await fetchPopularData();
    } else {
      _popularMovieList.addAll(dataList);
      _movieList.addAll(_popularMovieList);
      isMovie = true;
    }
    isLoading = false;
  }

  //discover tv
  fetchTvData() async {
    isLoading = true;
    // _movieList.clear();

    final dataList = await homePageRepository.getTvSeries(page: '$popularPage');
    log("Get TvData dataList length ${dataList.length.toString()}");
    tvPage += 1;
    // if (tvPage <= 3) {
    //   _tvSeriesList.addAll(dataList);
    //   await fetchTvData();
    // } else {
    _tvSeriesList.addAll(dataList);
    // _movieList.addAll(_popularMovieList);
    isMovie = false;
    // }
    isLoading = false;
  }

  Future<void> readLocalChannelJson() async {
    final response = await rootBundle.loadString('assets/channels.json');
    final data = await json.decode(response);
    List<LiveTVModel> liveTVModels = List<LiveTVModel>.from(data.map((e) => LiveTVModel.fromJson(e)));

    // log(data.toString());
    // log(liveTVModels.toString());
  }
}
