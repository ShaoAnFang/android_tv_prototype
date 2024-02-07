import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  late ShapeBorder shapeBorder;
  final double borderRadius;
  late bool isCircle = false;

  ShimmerWidget.rectangle({
    Key? key,
    this.width = double.infinity,
    required this.height,
    // this.shapeBorder,
    this.borderRadius = 8,
  }) : super(key: key);
  //: this.shapeBorder = RoundedRectangleBorder(borderRadius: BorderRadius.circular(13));

  ShimmerWidget.circle({
    Key? key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
    this.borderRadius = 0,
    this.isCircle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    shapeBorder = RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius));
    return Shimmer.fromColors(
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.grey[400]!,
          shape: isCircle ? CircleBorder() : shapeBorder,
        ),
      ),
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[200]!,
    );
  }
}

class ListViewShimmer extends StatelessWidget {
  const ListViewShimmer({Key? key, this.cellCount = 3}) : super(key: key);

  final int cellCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: cellCount,
          itemBuilder: (BuildContext context, int index) {
            return ListViewShimmerCard();
          },
        ),
      ],
    );
  }
}

class ListViewShimmerCard extends StatelessWidget {
  const ListViewShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: ShimmerWidget.circle(height: 46, width: 46),
          trailing: ShimmerWidget.rectangle(height: 20, width: 40, borderRadius: 5),
          title: ShimmerWidget.rectangle(height: 15, borderRadius: 2),
          subtitle: ShimmerWidget.rectangle(height: 10, borderRadius: 2)),
    );
  }
}

class ListViewHorizontalShimmer extends StatelessWidget {
  const ListViewHorizontalShimmer({Key? key, this.cellCount = 6}) : super(key: key);

  final int cellCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: cellCount,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return AspectRatio(
          aspectRatio: 11 / 16,
          child: Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: ShimmerWidget.rectangle(height: double.infinity, borderRadius: 13),
                  ),
                  ShimmerWidget.rectangle(height: 14, borderRadius: 3),
                  ShimmerWidget.rectangle(height: 12, borderRadius: 3),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class GridViewShimmer extends StatelessWidget {
  GridViewShimmer({Key? key, this.itemCount = 6}) : super(key: key);
  final horizontalPadding = Get.width * 0.05;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisSpacing: 0,
        crossAxisSpacing: 3,
        childAspectRatio: 3 / 4.5,
      ),
      padding: const EdgeInsets.all(4),
      itemCount: itemCount,
      itemBuilder: (_, index) => const GridViewCardShimmer(),
    );
  }
}

class GridViewCardShimmer extends StatelessWidget {
  const GridViewCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     spreadRadius: 1,
        //     blurRadius: 5,
        //     offset: const Offset(2, 2),
        //   ),
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AspectRatio(aspectRatio: 3 / 4.5, child: ShimmerWidget.rectangle(height: double.infinity, borderRadius: 13)),
          ],
        ),
      ),
    );
  }
}

class ShopGridViewShimmer extends StatelessWidget {
  ShopGridViewShimmer({Key? key}) : super(key: key);
  final horizontalPadding = Get.width * 0.05;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: horizontalPadding,
      crossAxisSpacing: horizontalPadding,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding * 0.8,
        8,
        horizontalPadding * 0.8,
        8,
      ),
      childAspectRatio: 11 / 16,
      children: const [
        GridViewCardShimmer(),
        GridViewCardShimmer(),
        GridViewCardShimmer(),
        GridViewCardShimmer(),
      ],
    );
  }
}

// class GridViewCardShimmer extends StatelessWidget {
//   const GridViewCardShimmer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(15)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(1, 1),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(6),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             AspectRatio(aspectRatio: 1, child: ShimmerWidget.rectangle(height: double.infinity, borderRadius: 13)),
//             ShimmerWidget.rectangle(
//               width: double.infinity,
//               borderRadius: 3,
//               height: 15,
//             ),
//             ShimmerWidget.rectangle(
//               width: double.infinity,
//               borderRadius: 3,
//               height: 15,
//             ),
//             ShimmerWidget.rectangle(
//               width: double.infinity,
//               borderRadius: 3,
//               height: 15,
//             ),
//           ],
//         ),
//       ),
//       // Column(
//       //   mainAxisAlignment: MainAxisAlignment.center,
//       //   crossAxisAlignment: CrossAxisAlignment.center,
//       //   children: [
//       //     Padding(
//       //       padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
//       //       child: ShimmerWidget.rectangle(width: 18, height: 18),
//       //     ),
//       //     Padding(
//       //       padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//       //       child: ShimmerWidget.rectangle(height: 13),
//       //     ),
//       //   ],
//       // ),
//     );
//   }
// }
