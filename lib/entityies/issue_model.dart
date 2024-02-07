class IssueModel {
  String? url;
  String? repositoryUrl;
  String? labelsUrl;
  String? commentsUrl;
  String? eventsUrl;
  String? htmlUrl;
  int? id;
  String? nodeId;
  int? number;
  String? title;
  User? user;
  // List<Null>? labels;
  String? state;
  // bool? locked;
  // Null? assignee;
  // List<Null>? assignees;
  // Null? milestone;
  // int? comments;
  String? createdAt;
  // String? updatedAt;
  // Null? closedAt;
  // String? authorAssociation;
  // Null? activeLockReason;
  // String? body;
  // Reactions? reactions;
  // String? timelineUrl;
  // Null? performedViaGithubApp;
  // Null? stateReason;

  IssueModel();

  IssueModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    repositoryUrl = json['repository_url'];
    labelsUrl = json['labels_url'];
    commentsUrl = json['comments_url'];
    eventsUrl = json['events_url'];
    htmlUrl = json['html_url'];
    id = json['id'];
    nodeId = json['node_id'];
    number = json['number'];
    title = json['title'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    // if (json['labels'] != null) {
    // 	labels = <Null>[];
    // 	json['labels'].forEach((v) { labels!.add(new Null.fromJson(v)); });
    // }
    state = json['state'];
    // locked = json['locked'];
    // assignee = json['assignee'];
    // if (json['assignees'] != null) {
    // 	assignees = <Null>[];
    // 	json['assignees'].forEach((v) { assignees!.add(new Null.fromJson(v)); });
    // }
    // milestone = json['milestone'];
    // comments = json['comments'];
    createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
    // closedAt = json['closed_at'];
    // authorAssociation = json['author_association'];
    // activeLockReason = json['active_lock_reason'];
    // body = json['body'];
    // reactions = json['reactions'] != null ? new Reactions.fromJson(json['reactions']) : null;
    // timelineUrl = json['timeline_url'];
    // performedViaGithubApp = json['performed_via_github_app'];
    // stateReason = json['state_reason'];
  }
}

class User {
  String? login;
// 	int? id;
// 	String? nodeId;
  String? avatarUrl;
// 	String? gravatarId;
// 	String? url;
// 	String? htmlUrl;
// 	String? followersUrl;
// 	String? followingUrl;
// 	String? gistsUrl;
// 	String? starredUrl;
// 	String? subscriptionsUrl;
// 	String? organizationsUrl;
// 	String? reposUrl;
// 	String? eventsUrl;
// 	String? receivedEventsUrl;
// 	String? type;
// 	bool? siteAdmin;

  User();

  User.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    // id = json['id'];
    // nodeId = json['node_id'];
    avatarUrl = json['avatar_url'];
    // gravatarId = json['gravatar_id'];
    // url = json['url'];
    // htmlUrl = json['html_url'];
    // followersUrl = json['followers_url'];
    // followingUrl = json['following_url'];
    // gistsUrl = json['gists_url'];
    // starredUrl = json['starred_url'];
    // subscriptionsUrl = json['subscriptions_url'];
    // organizationsUrl = json['organizations_url'];
    // reposUrl = json['repos_url'];
    // eventsUrl = json['events_url'];
    // receivedEventsUrl = json['received_events_url'];
    // type = json['type'];
    // siteAdmin = json['site_admin'];
  }

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = {};
// 		data['login'] = login;
// 		data['id'] = id;
// 		data['node_id'] = nodeId;
// 		data['avatar_url'] = avatarUrl;
// 		data['gravatar_id'] = gravatarId;
// 		data['url'] = url;
// 		data['html_url'] = htmlUrl;
// 		data['followers_url'] = followersUrl;
// 		data['following_url'] = followingUrl;
// 		data['gists_url'] = gistsUrl;
// 		data['starred_url'] = starredUrl;
// 		data['subscriptions_url'] = subscriptionsUrl;
// 		data['organizations_url'] = organizationsUrl;
// 		data['repos_url'] = reposUrl;
// 		data['events_url'] = eventsUrl;
// 		data['received_events_url'] = receivedEventsUrl;
// 		data['type'] = type;
// 		data['site_admin'] = siteAdmin;
// 		return data;
// 	}
}

// class Reactions {
// 	String? url;
// 	int? totalCount;
// 	int? 1;
// 	int? 1;
// 	int? laugh;
// 	int? hooray;
// 	int? confused;
// 	int? heart;
// 	int? rocket;
// 	int? eyes;

// 	Reactions({url, totalCount, 1, 1, laugh, hooray, confused, heart, rocket, eyes});

// 	Reactions.fromJson(Map<String, dynamic> json) {
// 		url = json['url'];
// 		totalCount = json['total_count'];
// 		1 = json['+1'];
// 		1 = json['-1'];
// 		laugh = json['laugh'];
// 		hooray = json['hooray'];
// 		confused = json['confused'];
// 		heart = json['heart'];
// 		rocket = json['rocket'];
// 		eyes = json['eyes'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = {};
// 		data['url'] = url;
// 		data['total_count'] = totalCount;
// 		data['+1'] = 1;
// 		data['-1'] = 1;
// 		data['laugh'] = laugh;
// 		data['hooray'] = hooray;
// 		data['confused'] = confused;
// 		data['heart'] = heart;
// 		data['rocket'] = rocket;
// 		data['eyes'] = eyes;
// 		return data;
// 	}
// }
