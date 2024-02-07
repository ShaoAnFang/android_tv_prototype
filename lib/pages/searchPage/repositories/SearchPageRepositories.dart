

import '../../../network/api_service.dart';

abstract class SearchPageRepository {
  Future searchMovieByTitle(String title,{String page});
}


class SearchPageRepositoryImpl implements SearchPageRepository {
  final ApiService api = ApiService();

  @override
  Future searchMovieByTitle(title ,{String page = '1'}) async {
    return await api.searchMovieByTitle(title, page: page);
  }
}
