import '../../components/FocusWidget.dart';
import '../../components/ShimmerWidget.dart';
import '../../components/VideoPlayerPage/VideoPlayerPage.dart';
import '../../utils/ImageCache.dart';
import 'SearchPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchpagePage extends GetView<SearchPageController> {
  const SearchpagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Colors.black,
            child: TextFormField(
              autofocus: true,
              onChanged: (String newValue) {
                controller.searchKeyWord = newValue;
              },
              onFieldSubmitted: (_) {
                print("onFieldSubmitted");
                controller.fetchKeyWordData();
              },
              style: const TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                hintText: "請輸入",
                hintStyle: TextStyle(color: Colors.grey[300]),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                fillColor: Colors.transparent,
                filled: true,
                contentPadding: const EdgeInsets.fromLTRB(18, 14, 0, 14),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 6),
              child: Text('給您的搜尋建議', style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (controller.isLoading) return GridViewShimmer(itemCount: 12);
                if (controller.searchKeyWord.isEmpty && controller.searchResultMovieList.isEmpty) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      childAspectRatio: 3 / 4.5,
                    ),
                    padding: const EdgeInsets.all(4),
                    itemCount: controller.recommendMovieList.length,
                    itemBuilder: (_, index) {
                      final movieData = controller.recommendMovieList[index];
                      return FocusWidget(
                        requestFocus: index == 0,
                        decoration: const BoxDecoration(),
                        focusChange: (bool hasFocus, FocusNode? focusNode) {},
                        isLeftEdge: index == 0,
                        isRightEdge: index == 5,
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
                        child: AspectRatio(
                          aspectRatio: 3 / 4.5,
                          child: ImageCached(imageUrl: movieData.posterPath),
                        ),
                      );
                    },
                  );
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      childAspectRatio: 3 / 4.5,
                    ),
                    padding: const EdgeInsets.all(4),
                    itemCount: controller.searchResultMovieList.length,
                    itemBuilder: (_, index) {
                      final movieData = controller.searchResultMovieList[index];
                      return FocusWidget(
                        requestFocus: index == 0,
                        decoration: const BoxDecoration(),
                        focusChange: (bool hasFocus, FocusNode? focusNode) {},
                        isLeftEdge: index == 0,
                        isRightEdge: index == 5,
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
                        child: AspectRatio(
                          aspectRatio: 3 / 4.5,
                          child: ImageCached(imageUrl: movieData.posterPath),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
