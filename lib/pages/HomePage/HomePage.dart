import 'dart:developer';

import 'package:android_tv_prototype/components/TextToast.dart';
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
                      videoUrl:
                          'https://manifest.googlevideo.com/api/manifest/hls_variant/expire/1728637750/ei/1pYIZ4j4N6GavcAPw8q50Ag/ip/182.16.33.122/id/ae1165bab7b205b0/source/youtube/requiressl/yes/xpc/EgVo2aDSNQ%3D%3D/playback_host/rr5---sn-i3belnls.googlevideo.com/met/1728616150%2C/mh/pp/mm/31%2C26/mn/sn-i3belnls%2Csn-a5msenl7/ms/au%2Conr/mv/u/mvi/5/pl/24/rms/au%2Cau/hfr/1/demuxed/1/tts_caps/1/maudio/1/vprv/1/go/1/rqh/5/mt/1728615135/fvip/1/nvgoi/1/short_key/1/ncsapi/1/keepalive/yes/fexp/51286683%2C51300761%2C51312687/dover/13/itag/0/playlist_type/DVR/sparams/expire%2Cei%2Cip%2Cid%2Csource%2Crequiressl%2Cxpc%2Chfr%2Cdemuxed%2Ctts_caps%2Cmaudio%2Cvprv%2Cgo%2Crqh%2Citag%2Cplaylist_type/sig/AJfQdSswRgIhANWXBZoVWpN3ah55mQaUM1g15htGVqUIAlUU-4AzCAqCAiEAzNKtAT9lRMpUwycZrj-qi8Gx_DWMbCn_Z10m9DcZ7SE%3D/lsparams/playback_host%2Cmet%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms/lsig/ACJ0pHgwRQIhAOvrYJ57oAYcglWPhUjWizAb2PPhBcLl5tGvllq9XOI7AiAwfeyUyHGmg_USlaInX_-jlQhy5TrDin8bQFVkQ2BH2Q%3D%3D/file/index.m3u8', //'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                      cancelCallBack: () {},
                    ),
                  ),
                } else ...{
                  Positioned.fill(
                    left: Get.width * 0.618,
                    child: controller.isMovie
                        ? ImageCached(
                            key: Key(controller.movieList[controller.onFocusIndex].backdropPath),
                            imageUrl: controller.movieList[controller.onFocusIndex].backdropPath,
                            fit: BoxFit.fitHeight,
                          )
                        : ImageCached(
                            key: Key(controller.tvSeriesList[controller.onFocusIndex].backdropPath),
                            imageUrl: controller.tvSeriesList[controller.onFocusIndex].backdropPath,
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
                          if (controller.isMovie) ...{
                            Text("${controller.movieList[controller.onFocusIndex].title} (${controller.movieList[controller.onFocusIndex].originalTitle})",
                                style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                controller.movieList[controller.onFocusIndex].overview,
                                style: const TextStyle(color: Colors.white, fontSize: 15, overflow: TextOverflow.ellipsis),
                                maxLines: 5,
                              ),
                            ),
                          } else ...{
                            if (controller.tvSeriesList[controller.onFocusIndex].name == controller.tvSeriesList[controller.onFocusIndex].originalName) ...{
                              Text(
                                controller.tvSeriesList[controller.onFocusIndex].name,
                                style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
                              ),
                            } else ...{
                              Text("${controller.tvSeriesList[controller.onFocusIndex].name} ", style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                              Text("${controller.tvSeriesList[controller.onFocusIndex].originalName} ", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                            },
                            Expanded(
                              child: Text(
                                controller.tvSeriesList[controller.onFocusIndex].overview,
                                style: const TextStyle(color: Colors.white, fontSize: 15, overflow: TextOverflow.ellipsis),
                                maxLines: 4,
                              ),
                            ),
                          },
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
                child: DrawerWidget(
                  onRightLeave: () {
                    FocusScope.of(context).requestFocus(controller.keepFocusNode);
                  },
                  onClick: (String title) {
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
                        controller.drawerCategory = title;
                        controller.fetchTvData();
                        break;
                      case '電影':
                        TextToast.show("開發中");
                        break;
                      case '電視':
                        controller.drawerCategory = title;
                        Get.to(() => const SearchpagePage(), binding: PagesBind());
                        break;
                      case '類別':
                        TextToast.show("開發中");
                        break;
                      case '我的列表':
                        TextToast.show("開發中");
                        break;
                    }
                  },
                ),
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
          clipBehavior: controller.onFocusIndex > 20 ? Clip.hardEdge : Clip.antiAliasWithSaveLayer,
          controller: controller.pageController,
          physics: const PageScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: controller.isMovie ? controller.movieList.length ~/ 20 : controller.tvSeriesList.length ~/ 20,
          onPageChanged: (int pageViewCurrentindex) {
            controller.pageViewCurrentindex = pageViewCurrentindex;
            // controller.setPreviewTimer();
          },
          itemBuilder: (_, pageViewindex) {
            if (controller.isMovie) {
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
                            log("onFocusIndex: ${controller.onFocusIndex}");
                            if (index == 0 && focusNode != null) {
                              controller.keepFocusNode = focusNode;
                            }
                            // controller.setPreviewTimer();
                          },
                          onclick: (_) {
                            Get.to(
                              () => VideoPlayerPage(
                                videoUrl:
                                    'https://manifest.googlevideo.com/api/manifest/hls_playlist/expire/1728637750/ei/1pYIZ4j4N6GavcAPw8q50Ag/ip/182.16.33.122/id/ae1165bab7b205b0/itag/270/source/youtube/requiressl/yes/ratebypass/yes/pfa/1/sgovp/clen%3D1246474025%3Bdur%3D4351.999%3Bgir%3Dyes%3Bitag%3D137%3Blmt%3D1695217541552278/rqh/1/hls_chunk_host/rr5---sn-i3belnls.googlevideo.com/xpc/EgVo2aDSNQ%3D%3D/met/1728616150,/mh/pp/mm/31,26/mn/sn-i3belnls,sn-a5msenl7/ms/au,onr/mv/u/mvi/5/pl/24/rms/au,au/vprv/1/playlist_type/DVR/dover/13/txp/6219224/mt/1728615135/fvip/1/short_key/1/keepalive/yes/fexp/51286683,51300761,51312687/sparams/expire,ei,ip,id,itag,source,requiressl,ratebypass,pfa,sgovp,rqh,xpc,vprv,playlist_type/sig/AJfQdSswRAIgDE6CTQBHUGTDp6NfaBdv3f1Wkw3M4lSqe4zULIUOr4ICIDzcLvur5kwKDJ8QvGEMKmpG4w2qET6eqKi0y4yUBKG2/lsparams/hls_chunk_host,met,mh,mm,mn,ms,mv,mvi,pl,rms/lsig/ACJ0pHgwRQIgajmdkyAf-5JX1mcr3t5l2RRlpSdAlBAcxkwaeRoS4wsCIQDEh7ZogespziRJbItft0DTRUUZtfRV17_f_RihqNmWZA%3D%3D/playlist/index.m3u8', //'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
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
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(" $title", style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        final tvData = controller.tvSeriesList[index + pageViewindex * 20];
                        return FocusWidget(
                          requestFocus: pageViewindex == 0 && index == 0,
                          focusChange: (hasfocus, FocusNode? focusNode) {
                            log("pageViewindex: $pageViewindex,index: $index, focusChange hasfocus $hasfocus");

                            controller.onFocusIndex = index + pageViewindex * 20;
                            log("onFocusIndex: ${controller.onFocusIndex}");
                            if (index == 0 && focusNode != null) {
                              controller.keepFocusNode = focusNode;
                            }
                            // controller.setPreviewTimer();
                          },
                          onclick: (_) {
                            Get.to(
                              () => VideoPlayerPage(
                                videoUrl:
                                    'https://manifest.googlevideo.com/api/manifest/hls_playlist/expire/1728637750/ei/1pYIZ4j4N6GavcAPw8q50Ag/ip/182.16.33.122/id/ae1165bab7b205b0/itag/270/source/youtube/requiressl/yes/ratebypass/yes/pfa/1/sgovp/clen%3D1246474025%3Bdur%3D4351.999%3Bgir%3Dyes%3Bitag%3D137%3Blmt%3D1695217541552278/rqh/1/hls_chunk_host/rr5---sn-i3belnls.googlevideo.com/xpc/EgVo2aDSNQ%3D%3D/met/1728616150,/mh/pp/mm/31,26/mn/sn-i3belnls,sn-a5msenl7/ms/au,onr/mv/u/mvi/5/pl/24/rms/au,au/vprv/1/playlist_type/DVR/dover/13/txp/6219224/mt/1728615135/fvip/1/short_key/1/keepalive/yes/fexp/51286683,51300761,51312687/sparams/expire,ei,ip,id,itag,source,requiressl,ratebypass,pfa,sgovp,rqh,xpc,vprv,playlist_type/sig/AJfQdSswRAIgDE6CTQBHUGTDp6NfaBdv3f1Wkw3M4lSqe4zULIUOr4ICIDzcLvur5kwKDJ8QvGEMKmpG4w2qET6eqKi0y4yUBKG2/lsparams/hls_chunk_host,met,mh,mm,mn,ms,mv,mvi,pl,rms/lsig/ACJ0pHgwRQIgajmdkyAf-5JX1mcr3t5l2RRlpSdAlBAcxkwaeRoS4wsCIQDEh7ZogespziRJbItft0DTRUUZtfRV17_f_RihqNmWZA%3D%3D/playlist/index.m3u8', //'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
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
                            child: ImageCached(imageUrl: tvData.posterPath),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
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
