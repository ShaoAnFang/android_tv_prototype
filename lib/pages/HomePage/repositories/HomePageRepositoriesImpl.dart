import '../../../network/api_service.dart';
import 'HomePageRepositories.dart';

class HomePageRepositoryImpl implements HomePageRepository {
  final ApiService api = ApiService();

  @override
  Future getMoives({String page = '1'}) async {
    return await api.getMoives(page: page);
  }

  @override
  Future getMoviePopular({String page = '1'}) async {
    return await api.getMoviePopular(page: page);
  }
}
