import 'dart:developer';
import 'package:android_tv_prototype/entityies/movie_model.dart';
import 'package:android_tv_prototype/entityies/tv_model.dart';
import 'package:dio/dio.dart';

import '../components/TextToast.dart';
import '../entityies/live_tv_model.dart';
import 'http_util.dart';

class ApiService {
  final HttpUtil http = HttpUtil();

  Future getMoives({String page = '1'}) async {
    final response = await http.get(
      '/discover/movie?&sort_by=popularity.desc&include_adult=false&include_video=false&with_watch_monetization_types=flatrate',
      params: {
        // "api_key": "eb74ce94febc33af53529bf04d1c8811",
        "page": page
      },
    );
    if (response is DioException) {
      log("getMoives error");
      log(response.toString());
      TextToast.show("statusCode: ${response.response?.statusCode}");
      return false;
    }

    return List<MovieModel>.generate(response.data['results'].length, (index) => MovieModel.fromJson(response.data['results'][index]));
  }

  Future searchMovieByTitle(String title, {String page = '1'}) async {
    final response = await http.get(
      '/search/movie?language=zh-TW&sort_by=popularity.desc&include_adult=false&include_video=false&with_watch_monetization_types=flatrate',
      params: {"query": title, "page": page},
    );

    if (response is DioException) {
      log("searchMovieByTitle error");
      log(response.toString());
      TextToast.show("statusCode: ${response.response?.statusCode}");
      return false;
    }

    return List<MovieModel>.generate(response.data['results'].length, (index) => MovieModel.fromJson(response.data['results'][index]));
  }

  Future getMoviePopular({String page = '1'}) async {
    final response = await http.get(
      '/movie/popular',
      params: {"page": page},
    );

    if (response is DioException) {
      log("searchMoviePopular error");
      log(response.toString());
      TextToast.show("statusCode: ${response.response?.statusCode}");
      return false;
    }

    return List<MovieModel>.generate(response.data['results'].length, (index) => MovieModel.fromJson(response.data['results'][index]));
  }

  Future getTvSeries({String page = '1'}) async {
    final response = await http.get(
      '/discover/tv',
      params: {
        "include_adult": true,
        "include_null_first_air_dates": false,
        "sort_by": "popularity.desc",
        "page": page,
      },
    );

    if (response is DioException) {
      log("Get Tv Series  error");
      log(response.toString());
      TextToast.show("statusCode: ${response.response?.statusCode}");
      return false;
    }

    return List<TVModel>.generate(response.data['results'].length, (index) => TVModel.fromJson(response.data['results'][index]));
  }
}
