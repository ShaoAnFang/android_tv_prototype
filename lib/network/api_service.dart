import 'dart:developer';
import 'package:android_tv_prototype/entityies/movie_model.dart';
import 'package:dio/dio.dart';

import '../components/TextToast.dart';

import '../entityies/issue_comment_model.dart';
import '../entityies/issue_model.dart';
import 'http_util.dart';

class ApiService {
  final HttpUtil http = HttpUtil();

  Future getMoives({String page = '1'}) async {
    final response = await http.get(
      '/discover/movie?&language=zh-TW&sort_by=popularity.desc&include_adult=false&include_video=false&with_watch_monetization_types=flatrate',
      params: {
        "api_key": "eb74ce94febc33af53529bf04d1c8811",
        "language": "zh-TW",
        "page": page,
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
      params: {
        "api_key": "eb74ce94febc33af53529bf04d1c8811",
        "language": "zh-TW",
        "query": title,
        "page": page,
      },
    );

    if (response is DioException) {
      log("searchMovieByTitle error");
      log(response.toString());
      TextToast.show("statusCode: ${response.response?.statusCode}");
      return false;
    }

    return List<MovieModel>.generate(response.data['results'].length, (index) => MovieModel.fromJson(response.data['results'][index]));
  }

  Future getIssueComments(String id) async {
    final response = await http.get('/repos/flutter/Flutter/issues/$id/comments');
    if (response is DioException) {
      log("get Issue Comments error");
      log(response.toString());
      TextToast.show("statusCode: ${response.response?.statusCode}");
      return false;
    }
    return List<IssueCommentModel>.generate(response.data.length, (index) => IssueCommentModel.fromJson(response.data[index]));
  }
}
