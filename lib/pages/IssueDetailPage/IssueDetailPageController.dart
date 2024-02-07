import 'package:get/get.dart';

import '../../entityies/issue_comment_model.dart';
import 'repositories/IssueDetailPageRepositories.dart';

class IssueDetailPageController extends GetxController {
  IssueDetailPageController({required this.issueDetailPageRepository});

  final IssueDetailPageRepository issueDetailPageRepository;

  final _isLoading = true.obs;
  set isLoading(value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  final _issueCommentList = <IssueCommentModel>[].obs;
  List<IssueCommentModel> get issueCommentList => _issueCommentList.toList();

  @override
  void onInit() async {
    final id = Get.arguments['id'];
    await fetchData(id);
    super.onInit();
  }

  fetchData(String id) async {
    isLoading = true;
    final data = await issueDetailPageRepository.getIssueComments(id);
    _issueCommentList.addAll(data);
    print(issueCommentList.length);
    isLoading = false;
  }
}
