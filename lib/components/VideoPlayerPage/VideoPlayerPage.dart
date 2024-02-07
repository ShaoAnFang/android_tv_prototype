import 'dart:async';
import 'dart:developer';

import 'package:android_tv_prototype/components/FocusWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({
    Key? key,
    required this.videoUrl,
    required this.cancelCallBack,
  }) : super(key: key);

  final String videoUrl;
  final Function cancelCallBack;
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController playerController;
  late Timer timer;
  bool isPanelShow = false;

  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight
    // ]);
    playerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
      // closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )
      ..setLooping(true)
      ..initialize().then((_) {
        playerController.play();
        // setState(() {});
      })
      ..addListener(() {
        // print("isBuffering : ${playerController.value.isBuffering}");
        if (playerController.value.position == const Duration(seconds: 0, minutes: 0, hours: 0)) {
          print('video Started');
          setPanelHideTimer();
        }
        setState(() {});
      });
  }

  @override
  void dispose() {
    playerController.dispose();
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FocusWidget(
          decoration: const BoxDecoration(),
          focusChange: (bool hasFocus, FocusNode? focusNode) {
            log("hasFocus: $hasFocus");
            // isPanelShow = true;
          },
          onclick: () {
            setState(() {
              if (playerController.value.isPlaying) {
                playerController.pause();
                isPanelShow = true;
              } else {
                playerController.play();
                setPanelHideTimer();
              }
            });
          },
          child: SizedBox.expand(
            child: Stack(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (playerController.value.isPlaying) {
                          playerController.pause();
                          isPanelShow = true;
                        } else {
                          playerController.play();
                          setPanelHideTimer();
                        }
                      });
                    },
                    child: AspectRatio(
                      //controller.playerController.value.aspectRatio,
                      aspectRatio: 16 / 9,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          VideoPlayer(playerController),
                          if (playerController.value.position == const Duration(seconds: 0)) ...{
                            SizedBox.fromSize(
                              size: const Size(40, 40),
                              child: const CircularProgressIndicator(),
                            ),
                          },
                          // ClosedCaption(
                          //     text: controller.playerController.value.caption.text),
                          // _ControlsOverlay(controller: _controller),
                          Visibility(
                            visible: isPanelShow,
                            child: controlPanel(),
                          ),
                          Visibility(
                            visible: isPanelShow,
                            child: Positioned(
                              right: 10,
                              bottom: 15,
                              child: Container(
                                color: Colors.black,
                                child: Text(
                                  durationAndTotalTime(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          // Visibility(
                          //   visible: isPanelShow,
                          //   child: Positioned(
                          //     right: 0,
                          //     bottom: 2,
                          //     child: TextButton(
                          //       child: Icon(Icons.fullscreen, color: Colors.white),
                          //       onPressed: () {
                          //         //直的話改橫
                          //         final orientation = isPortrait ? DeviceOrientation.landscapeLeft : DeviceOrientation.portraitUp;
                          //         SystemChrome.setPreferredOrientations([orientation]);
                          //       },
                          //     ),
                          //   ),
                          // ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: VideoProgressIndicator(playerController, allowScrubbing: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 25,
                  child: Visibility(
                    visible: isPanelShow,
                    child: FocusWidget(
                      needScalTransition: true,
                      decoration: const BoxDecoration(),
                      focusChange: (hasFocus, foucsNode) {
                        log("hasFocus: $hasFocus");
                      },
                      onclick: () {
                        widget.cancelCallBack();
                      },
                      child: Icon(Icons.cancel_outlined, size: 55, color: Colors.grey.withOpacity(0.5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget controlPanel() {
    return (playerController.value.isPlaying) ? Icon(Icons.pause, size: 55, color: Colors.grey.withOpacity(0.5)) : Icon(Icons.play_arrow, size: 55, color: Colors.grey.withOpacity(0.5));
  }

  setPanelHideTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 2500), (_) {
      timer.cancel();
      if (playerController.value.isPlaying) {
        isPanelShow = false;
        setState(() {});
      }
    });
  }

  String durationAndTotalTime() {
    return "${_printDuration(playerController.value.position)} / ${_printDuration(playerController.value.duration)}";
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    //return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
