import 'dart:developer';
import 'package:flutter/material.dart';
import 'DrawerCellWidget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key, required this.onRightLeave, required this.onClick}) : super(key: key);

  final Function onRightLeave;
  final Function(String) onClick;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> with TickerProviderStateMixin {
  bool isDrawerExpanded = false;
  final drawerFocusNodes = <FocusNode>[];
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    drawerFocusNodes.addAll(List<FocusNode>.generate(7, (index) => FocusNode()));
    controller = AnimationController(
      // value: 1,
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..addListener(() {
        log(controller.status.toString());
        if (controller.status == AnimationStatus.completed) {
          isDrawerExpanded = true;
        } else if (controller.status == AnimationStatus.reverse) {
          isDrawerExpanded = false;
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: isDrawerExpanded ? (controller.value * MediaQuery.sizeOf(context).width * 0.18) + 100 : 60,
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
            // focusNode: controller.drawerParentFocusNode,
            onRightLeave: () {},
            onFocusChange: (int index, bool hasFocus) {
              if (hasFocus && !isDrawerExpanded) {
                controller.forward();
                Future.delayed(const Duration(milliseconds: 250)).then((value) {
                  drawerFocusNodes[0].requestFocus();
                });
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
                _drawerWidgetCell(context, 4, const Icon(Icons.live_tv, color: Colors.white), '電視'),
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
      index: index,
      focusNode: drawerFocusNodes[index],
      onFocusChange: (int index, bool hasFocus) {
        // if (hasFocus) {
        log('Drawer cell $index, hasFocus: $hasFocus');
        // controller.drawerFocusNodes[0].requestFocus();
        // }
      },
      onClick: () {
        controller.reverse();
        widget.onClick(title);
        FocusScope.of(context).focusInDirection(TraversalDirection.right);
        FocusScope.of(context).focusInDirection(TraversalDirection.left);
      },
      onRightLeave: () async {
        controller.reverse();
        widget.onRightLeave();
        /* 這邊很北纜的是 如果不這樣左右一下 按右邊會沒反應 要多按一次右邊才會動 */
        FocusScope.of(context).focusInDirection(TraversalDirection.right);
        FocusScope.of(context).focusInDirection(TraversalDirection.left);
      },
      child: Column(
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 2),
            child: isDrawerExpanded
                ? Row(
                    children: [
                      const SizedBox(width: 20),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: icon),
                      Text(title, style: const TextStyle(color: Colors.white)),
                    ],
                  )
                : icon,
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
