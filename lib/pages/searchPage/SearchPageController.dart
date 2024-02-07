import 'dart:developer';

import 'package:get/get.dart';
import '../../entityies/movie_model.dart';
import '../HomePage/repositories/HomePageRepositories.dart';
import 'repositories/SearchPageRepositories.dart';

class SearchPageController extends GetxController {
  SearchPageController({required this.searchPageRepository, required this.homePageRepository});

  final SearchPageRepository searchPageRepository;
  final HomePageRepository homePageRepository;

  final _isLoading = true.obs;
  set isLoading(value) => _isLoading.value = value;
  get isLoading => _isLoading.value;

  final _recommendMovieList = <MovieModel>[].obs;
  List<MovieModel> get recommendMovieList => _recommendMovieList.toList();

  final _searchResultMovieList = <MovieModel>[].obs;
  List<MovieModel> get searchResultMovieList => _searchResultMovieList.toList();

  final _searchKeyWord = ''.obs;
  set searchKeyWord(value) => _searchKeyWord.value = value;
  String get searchKeyWord => _searchKeyWord.value;

  @override
  void onInit() async {
    super.onInit();
    await fetchRecommendData();
  }

  fetchRecommendData() async {
    isLoading = true;
    final dataList = await homePageRepository.getMoives(page: '1');
    log("dataList length ${dataList.length.toString()}");
    _recommendMovieList.addAll(dataList);
    // page += 1;
    // if (page <= 3) await fetchRecommendData();
    isLoading = false;
  }

  fetchKeyWordData() async {
    isLoading = true;
    final dataList = await searchPageRepository.searchMovieByTitle(searchKeyWord /*page: '$page'*/);
    log("dataList length ${dataList.length.toString()}");
    _searchResultMovieList.addAll(dataList);
    // page += 1;
    // if (page <= 3) await fetchData();
    isLoading = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
