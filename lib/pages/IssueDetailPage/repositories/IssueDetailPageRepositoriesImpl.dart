import '../../../network/api_service.dart';
import 'IssueDetailPageRepositories.dart';

class IssueDetailPageRepositoryImpl implements IssueDetailPageRepository {
  final ApiService api = ApiService();

  @override
  Future getIssueComments(String id) async {
    return await api.getIssueComments(id);
  }
}
