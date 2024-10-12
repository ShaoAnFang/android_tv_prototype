/*
  "id": 0,
  "channel": "央视",
  "logo": "https://resources.yangshipin.cn/assets/oms/image/202306/d57905b93540bd15f0c48230dbbbff7ee0d645ff539e38866e2d15c8b9f7dfcd.png?imageMogr2/format/webp",
  "pid": "600001859",
  "sid": "2000210103",
  "programId": "600001859",
  "needToken": false,
  "mustToken": false,
  "title": "CCTV1 综合",
  "videoUrl": [
    "http://dbiptv.sn.chinamobile.com/PLTV/88888890/224/3221226231/index.m3u8"
  ]
*/

class LiveTVModel {
  int id = 0;
  String channel = "";
  String logo = "";
  String title = "";
  List<String> videoUrl = [];

  LiveTVModel();

  LiveTVModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    channel = json["channel"];
    logo = json["logo"];
    title = json["title"];
    if (json["videoUrl"] != null) {
      videoUrl = List<String>.from(json["videoUrl"].map((e) => e));
    }
  }
}
