import 'dart:async';
import 'dart:developer';
import 'package:android_tv_prototype/components/FocusWidget.dart';
import 'package:flutter/material.dart';
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

class _VideoPlayerPageState extends State<VideoPlayerPage> with TickerProviderStateMixin {
  late AnimationController cancelAnimationController;
  late AnimationController playAnimationController;
  late Animation<double> playAnimation;
  late Animation<double> cancelAnimation;
  final playerFocusNodes = <FocusNode>[];
  late VideoPlayerController playerController;
  late Timer timer;
  bool isPanelShow = false;

  @override
  void initState() {
    super.initState();
    playerFocusNodes.addAll(List<FocusNode>.generate(3, (index) => FocusNode()));
    cancelAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    cancelAnimation = Tween(begin: 1.0, end: 1.618).animate(cancelAnimationController);
    playAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    playAnimation = Tween(begin: 1.0, end: 1.618).animate(playAnimationController);

    playerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
      // closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )
      ..setLooping(true)
      ..initialize().then((_) {
        playerController.play();
      })
      ..addListener(() {
        // print("isBuffering : ${playerController.value.isBuffering}");
        if (playerController.value.position == const Duration(seconds: 0, minutes: 0, hours: 0)) {
          //   print('video Started');
          //   setPanelHideTimer();
        }
        setState(() {});
      });
  }

  @override
  void dispose() {
    playerController.dispose();
    cancelAnimationController.dispose();
    playAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FocusWidget(
        isPlayer: true,
        focusNode: playerFocusNodes[0],
        requestFocus: true,
        decoration: const BoxDecoration(),
        focusChange: (bool hasFocus, FocusNode? focusNode) {
          log("hasFocus: $hasFocus");
          // isPanelShow = true;
        },
        onclick: (key) {
          if (key == keyRight) {
            final newPosition = Duration(seconds: playerController.value.position.inSeconds + 10);
            playerController.seekTo(newPosition);
            return;
          }
          if (key == keyLeft) {
            final newPosition = Duration(seconds: playerController.value.position.inSeconds - 10);
            playerController.seekTo(newPosition);
            return;
          }

          playerFocusNodes[2].requestFocus();
          setState(() {
            if (playerController.value.isPlaying) {
              // playerController.pause();
              isPanelShow = true;
            } else {
              // playerController.play();
              setPanelHideTimer();
            }
          });
        },
        child: Stack(
          children: [
            // AspectRatio(
            //controller.playerController.value.aspectRatio,
            // aspectRatio: 16 / 9,
            // child:
            Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(playerController),
                if (playerController.value.position == const Duration(seconds: 0)) ...{
                  SizedBox.fromSize(size: const Size(40, 40), child: const CircularProgressIndicator(color: Colors.white)),
                },
                Visibility(
                  visible: isPanelShow,
                  child: Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.382),
                      child:
                          // FocusWidget(
                          //   decoration: const BoxDecoration(),
                          //   onclick: () {
                          //     log("onclick");
                          //   },
                          //   focusChange: (bool hasFocus, FocusNode? focusNode) {
                          //     log("hasFocus: $hasFocus");
                          //   },
                          //   child:
                          Column(
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 8, right: 25),
                                child: FocusWidget(
                                  focusNode: playerFocusNodes[1],
                                  decoration: const BoxDecoration(),
                                  focusChange: (hasFocus, foucsNode) {
                                    log("hasFocus: $hasFocus");
                                    if (hasFocus) {
                                      cancelAnimationController.forward();
                                    } else {
                                      cancelAnimationController.reverse();
                                    }
                                  },
                                  onclick: (_) {
                                    widget.cancelCallBack();
                                  },
                                  child: ScaleTransition(scale: cancelAnimation, child: const Text("X", style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.w300))),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: FocusWidget(
                              focusNode: playerFocusNodes[2],
                              decoration: const BoxDecoration(),
                              focusChange: (bool hasFocus, FocusNode? focusNode) {
                                log("hasFocus: $hasFocus");

                                if (hasFocus) {
                                  playAnimationController.forward();
                                } else {
                                  playAnimationController.reverse();
                                }
                              },
                              onclick: (key) {
                                if (key == keyRight) {
                                  final newPosition = Duration(seconds: playerController.value.position.inSeconds + 10);
                                  playerController.seekTo(newPosition);
                                  return;
                                }
                                if (key == keyLeft) {
                                  final newPosition = Duration(seconds: playerController.value.position.inSeconds - 10);
                                  playerController.seekTo(newPosition);
                                  return;
                                }
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
                              child: ScaleTransition(scale: playAnimation, child: controlPanel()),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Expanded(child: VideoProgressIndicator(playerController, allowScrubbing: true)),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    durationAndTotalTime(),
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget controlPanel() {
    return (playerController.value.isPlaying) ? const Icon(Icons.pause, size: 55, color: Colors.white) : const Icon(Icons.play_arrow, size: 55, color: Colors.white);
  }

  setPanelHideTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
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
