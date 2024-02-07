// import 'dart:async';

// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerPageController extends GetxController {
//   final _isPanelShow = false.obs;
//   get isPanelShow => this._isPanelShow.value;
//   set isPanelShow(value) => this._isPanelShow.value = value;

//   late VideoPlayerController playerController;
//   late Timer timer;

//   @override
//   onInit() {
//     final videoUrl = (Get.arguments as Map)["videoUrl"] as String;
//     playerController = VideoPlayerController.network(
//       videoUrl,
//       // closedCaptionFile: _loadCaptions(),
//       videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
//     )
//       ..setLooping(true)
//       ..initialize().then((_) {
//         playerController.play();
//         update();
//       });
//     // playerController?.addListener(() {
//     //   print("playerController Listener");
//     // });
//     super.onInit();
//   }

//   @override
//   onReady() {
//     print("onReady");
//     super.onReady();
//   }

//   @override
//   onClose() {
//     Get.delete<VideoPlayerPageController>();
//     playerController.dispose();
//     timer.cancel();
//     super.onClose();
//   }

//   setPanelHideTimer() {
//     timer = Timer.periodic(const Duration(milliseconds: 2500), (_) {
//       isPanelShow = false;
//       timer.cancel();
//       update();
//     });
//   }
// }
