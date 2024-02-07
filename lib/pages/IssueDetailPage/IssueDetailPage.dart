import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../style/color.dart';
import '../../utils/ImageCache.dart';
import 'IssueDetailPageController.dart';

class IssueDetailPage extends GetView<IssueDetailPageController> {
  const IssueDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBG,
      appBar: AppBar(
        backgroundColor: primaryBG,
        title: const Text('Issue detail ', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white), onPressed: () => Get.back()),
      ),
      body: Center(
        child: Obx(
          () {
            if (controller.isLoading) return const CircularProgressIndicator();
            return ListView.builder(
              itemCount: controller.issueCommentList.length,
              itemBuilder: (context, index) {
                final commentData = controller.issueCommentList[index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 42,
                          height: 42,
                          child: ClipRRect(borderRadius: BorderRadius.circular(50), child: ImageCached(imageUrl: commentData.user?.avatarUrl ?? "")),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("#${commentData.user?.login} commented", style: const TextStyle(fontSize: 18, color: Colors.white)),
                              Text(commentData.body ?? " ", style: const TextStyle(fontSize: 10, color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
