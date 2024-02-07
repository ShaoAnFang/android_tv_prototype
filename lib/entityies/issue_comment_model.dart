import 'issue_model.dart';

class IssueCommentModel {
  String? url;
  String? htmlUrl;
  String? issueUrl;
  int? id;
  String? nodeId;
  User? user;
  String? createdAt;
  String? updatedAt;
  String? authorAssociation;
  String? body;
  // Reactions? reactions;
  // Null? performedViaGithubApp;

  IssueCommentModel();

  IssueCommentModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    htmlUrl = json['html_url'];
    issueUrl = json['issue_url'];
    id = json['id'];
    nodeId = json['node_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    authorAssociation = json['author_association'];
    body = json['body'];
    // reactions = json['reactions'] != null ? new Reactions.fromJson(json['reactions']) : null;
    // performedViaGithubApp = json['performed_via_github_app'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    data['html_url'] = htmlUrl;
    data['issue_url'] = issueUrl;
    data['id'] = id;
    data['node_id'] = nodeId;
    // if (user != null) {
    //   data['user'] = user!.toJson();
    // }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['author_association'] = authorAssociation;
    data['body'] = body;
    // if (reactions != null) {
    //   data['reactions'] = reactions!.toJson();
    // }
    // data['performed_via_github_app'] = performedViaGithubApp;
    return data;
  }
}
