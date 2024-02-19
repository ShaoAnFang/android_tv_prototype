import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/DrawerWidget.dart';
import '../../components/FocusWidget.dart';
import '../../components/ShimmerWidget.dart';
import '../../components/VideoPlayerPage/VideoPlayerPage.dart';
import '../../routes/PagesBind.dart';
import '../../style/color.dart';
import '../../utils/AudioService.dart';
import '../../utils/ImageCache.dart';
import '../SearchPage/SearchPage.dart';
import 'HomePageController.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBG,
      body: Obx(
        () {
          // if (controller.isLoading) return GridViewShimmer(itemCount: 12);
          return Stack(
            children: [
              Container(color: Colors.black),
              if (!controller.isLoading) ...{
                if (controller.previewPlay) ...{
                  //預覽
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: Get.height * 0.382,
                    left: Get.width * 0.382,
                    child: VideoPlayerPage(
                      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                      cancelCallBack: () {},
                    ),
                  ),
                } else ...{
                  Positioned.fill(
                    left: Get.width * 0.618,
                    child: ImageCached(
                      key: Key(controller.movieList[controller.onFocusIndex].backdropPath),
                      imageUrl: controller.movieList[controller.onFocusIndex].backdropPath,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                },
              },
              Positioned.fill(
                top: Get.height * 0.08,
                left: 70,
                right: Get.width * 0.45,
                bottom: Get.height * 0.52,
                child: controller.isLoading
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("${controller.movieList[controller.onFocusIndex].title} (${controller.movieList[controller.onFocusIndex].originalTitle})",
                              style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                          Text(
                            controller.movieList[controller.onFocusIndex].overview,
                            style: const TextStyle(color: Colors.white, fontSize: 15, overflow: TextOverflow.ellipsis),
                            maxLines: 5,
                          ),
                        ],
                      ),
              ),
              Positioned.fill(
                top: Get.height * 0.45,
                left: 70,
                right: 0,
                child: controller.isLoading ? GridViewShimmer(itemCount: 12) : _buildListView(),
              ),
              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                child: DrawerWidget(onRightLeave: () {
                  FocusScope.of(context).requestFocus(controller.keepFocusNode);
                }, onClick: (String title) {
                  FocusScope.of(context).requestFocus(controller.keepFocusNode);
                  switch (title) {
                    case '搜索':
                      Get.to(() => const SearchpagePage(), binding: PagesBind());

                      break;
                    case '主頁':
                      controller.drawerCategory = title;
                      controller.fetchData();
                      break;
                    case '新鮮熱播':
                      controller.drawerCategory = title;
                      controller.fetchPopularData();
                      break;
                    case '劇集':
                      break;
                    case '電影':
                      break;
                    case '類別':
                      break;
                    case '我的列表':
                      break;
                  }
                }),
              ),
              if (controller.isMobile) ...{
                Positioned(
                  top: 50,
                  right: 50,
                  child: _mobilePanel(context),
                ),
              },
            ],
          );
        },
      ),
    );
  }

  Widget _buildListView({String title = 'Catgeory 影片分類'}) {
    return Obx(
      () {
        return PageView.builder(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          controller: controller.pageController,
          physics: const PageScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: controller.movieList.length ~/ 20,
          onPageChanged: (int pageViewCurrentindex) {
            controller.pageViewCurrentindex = pageViewCurrentindex;
            controller.setPreviewTimer();
          },
          itemBuilder: (_, pageViewindex) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(" $title", style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 20, // controller.movieList.length,
                    itemBuilder: (context, index) {
                      final movieData = controller.movieList[index + pageViewindex * 20];
                      return FocusWidget(
                        // focusNode: pageViewindex == 0 && index == 0 ? controller.initFocusNode : null,
                        requestFocus: pageViewindex == 0 && index == 0,
                        focusChange: (hasfocus, FocusNode? focusNode) {
                          log("pageViewindex: $pageViewindex,index: $index, focusChange hasfocus $hasfocus");
                          controller.onFocusIndex = index + pageViewindex * 20;
                          if (index == 0 && focusNode != null) {
                            controller.keepFocusNode = focusNode;
                          }
                          controller.setPreviewTimer();
                        },
                        onclick: () {
                          Get.to(
                            () => VideoPlayerPage(
                              videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                              cancelCallBack: () {
                                Get.back();
                              },
                            ),
                            transition: Transition.zoom,
                          );
                        },
                        isLeftEdge: index == 0,
                        isRightEdge: index == 19,
                        child: AspectRatio(
                          aspectRatio: 10 / 16,
                          child: ImageCached(imageUrl: movieData.posterPath),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _mobilePanel(BuildContext context) {
    final iconColor = Colors.white.withOpacity(0.362);
    return Container(
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), shape: BoxShape.circle),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _panelButton(context, Icon(Icons.arrow_upward, color: iconColor), 'up'),
          Row(
            children: [
              _panelButton(context, Icon(Icons.arrow_back, color: iconColor), 'left'),
              _panelButton(context, Icon(Icons.circle, color: iconColor), 'center'),
              _panelButton(context, Icon(Icons.arrow_forward, color: iconColor), 'right'),
            ],
          ),
          _panelButton(context, Icon(Icons.arrow_downward, color: iconColor), 'down'),
        ],
      ),
    );
  }

  Widget _panelButton(BuildContext context, Icon icon, String direction) {
    return IconButton(
      icon: icon,
      onPressed: () {
        AudioService().playSound(AssetSource('sounds/mixkit-modern-technology-select-3124.wav'));
        switch (direction) {
          case 'up':
            FocusScope.of(context).focusInDirection(TraversalDirection.up);
            break;
          case 'down':
            FocusScope.of(context).focusInDirection(TraversalDirection.down);
            break;
          case 'left':
            FocusScope.of(context).focusInDirection(TraversalDirection.left);
            break;
          case 'right':
            FocusScope.of(context).focusInDirection(TraversalDirection.right);
            break;
        }
      },
    );
  }
}
