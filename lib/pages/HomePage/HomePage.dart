import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/DrawerCellWidget.dart';
import '../../components/FocusWidget.dart';
import '../../components/ShimmerWidget.dart';
import '../../components/VideoPlayerPage/VideoPlayerPage.dart';
import '../../routes/PagesBind.dart';
import '../../style/color.dart';
import '../../utils/AudioService.dart';
import '../../utils/ImageCache.dart';
import '../IssueDetailPage/IssueDetailPage.dart';
import '../searchPage/SearchPage.dart';
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
              controller.isLoading
                  ? const SizedBox()
                  : Positioned.fill(
                      child: ImageCached(
                        key: Key(controller.movieList[controller.onFocusIndex].backdropPath),
                        imageUrl: controller.movieList[controller.onFocusIndex].backdropPath,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
              Positioned.fill(
                top: Get.height * 0.25,
                left: 70,
                right: 0,
                bottom: 0,
                child: controller.isLoading
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(controller.movieList[controller.onFocusIndex].title, style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                          Text(controller.movieList[controller.onFocusIndex].originalTitle, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
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
                child: _drawerWidget(context),
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

  Widget _drawerWidget(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: controller.isDrawerExpanded ? (controller.controller.value * Get.width * 0.18) + 100 : 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // if (controller.isDrawerExpanded) ...{
                //   Colors.cyan,
                //   Colors.indigo,
                // },
                Colors.black,
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.8),
              ],
            ),
          ),
          child: DrawerCellWidget(
            index: 100,
            focusNode: controller.drawerParentFocusNode,
            onRightLeave: () {},
            onFocusChange: (int index, bool hasFocus) {
              if (hasFocus && !controller.isDrawerExpanded) {
                controller.isDrawerExpanded = !controller.isDrawerExpanded;
                Future.delayed(const Duration(milliseconds: 50)).then((value) => controller.drawerFocusNodes[0].requestFocus());
                // controller.drawerFocusNodes[0].requestFocus();
              }
            },
            onClick: () {},
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _drawerWidgetCell(context, 0, const Icon(Icons.search, color: Colors.white), '搜索'),
                _drawerWidgetCell(context, 1, const Icon(Icons.home_outlined, color: Colors.white), '主頁'),
                _drawerWidgetCell(context, 2, const Icon(Icons.arrow_outward_outlined, color: Colors.white), '新鮮熱播'),
                _drawerWidgetCell(context, 3, const Icon(Icons.monitor, color: Colors.white), '劇集'),
                _drawerWidgetCell(context, 4, const Icon(Icons.movie_outlined, color: Colors.white), '電影'),
                _drawerWidgetCell(context, 5, const Icon(Icons.category_outlined, color: Colors.white), '類別'),
                _drawerWidgetCell(context, 6, const Icon(Icons.add, color: Colors.white), '我的列表'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _drawerWidgetCell(BuildContext context, int index, Icon icon, String title) {
    return DrawerCellWidget(
      // requestFocus: index == 0,
      index: index,
      focusNode: controller.drawerFocusNodes[index],
      onFocusChange: (int index, bool hasFocus) {
        // if (hasFocus) {
        log('Drawer cell $index, hasFocus: $hasFocus');
        // controller.isDrawerExpanded = true;
        // controller.drawerFocusNodes[0].requestFocus();
        // }
      },
      onClick: () {
        switch (title) {
          case '搜索':
            Get.to(() => const SearchpagePage(), binding: PagesBind());
            break;
          case '主頁':
            break;
          case '新鮮熱播':
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
      },
      onRightLeave: () async {
        controller.isDrawerExpanded = !controller.isDrawerExpanded;
        FocusScope.of(context).requestFocus(controller.keepFocusNode);
        /* 這邊很北纜的是 如果不這樣左右一下 按右邊會沒反應 要多按一次右邊才會動 */
        FocusScope.of(context).focusInDirection(TraversalDirection.right);
        FocusScope.of(context).focusInDirection(TraversalDirection.left);
      },
      child: Column(
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 2),
            child: Obx(
              () => controller.isDrawerExpanded
                  ? Row(
                      children: [
                        const SizedBox(width: 20),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: icon),
                        Text(title, style: const TextStyle(color: Colors.white)),
                      ],
                    )
                  : icon,
            ),
          ),
          const SizedBox(height: 5),
        ],
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
