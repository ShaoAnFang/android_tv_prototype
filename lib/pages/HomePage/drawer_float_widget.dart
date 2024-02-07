import 'dart:developer';
import 'package:flutter/material.dart';

import '../../components/DrawerCellWidget.dart';

class DrawerFlowWidget extends StatefulWidget {
  const DrawerFlowWidget({Key? key, required this.focusNodes, required this.didTapped}) : super(key: key);
  final List<FocusNode> focusNodes;
  final Function(String type) didTapped;

  @override
  State<DrawerFlowWidget> createState() => DrawerFlowWidgetState();
}

class DrawerFlowWidgetState extends State<DrawerFlowWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isAnimationCompleted = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        if (controller.status == AnimationStatus.completed) {
          setState(() => isAnimationCompleted = true);
        } else if (controller.status == AnimationStatus.reverse) {
          setState(() => isAnimationCompleted = false);
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Positioned.fill(
          right: -60,
          child: Flow(
            delegate: FlowMenuDelegate(controller: controller),
            children: [
              // _drawerWidgetCell(0, const Icon(Icons.search, color: Colors.white), '搜索'),
              // _drawerWidgetCell(1, const Icon(Icons.home_outlined, color: Colors.white), '主頁'),
              // _drawerWidgetCell(2, const Icon(Icons.arrow_outward_outlined, color: Colors.white), '新鮮熱播'),
              // _drawerWidgetCell(3, const Icon(Icons.monitor, color: Colors.white), '劇集'),
              // _drawerWidgetCell(4, const Icon(Icons.movie_outlined, color: Colors.white), '電影'),
              // _drawerWidgetCell(5, const Icon(Icons.category_outlined, color: Colors.white), '類別'),
              // _drawerWidgetCell(6, const Icon(Icons.add, color: Colors.white), '我的列表'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _drawerWidgetCell(0, const Icon(Icons.search, color: Colors.white), '搜索'),
                  _drawerWidgetCell(1, const Icon(Icons.home_outlined, color: Colors.white), '主頁'),
                  _drawerWidgetCell(2, const Icon(Icons.arrow_outward_outlined, color: Colors.white), '新鮮熱播'),
                  _drawerWidgetCell(3, const Icon(Icons.monitor, color: Colors.white), '劇集'),
                  _drawerWidgetCell(4, const Icon(Icons.movie_outlined, color: Colors.white), '電影'),
                  _drawerWidgetCell(5, const Icon(Icons.category_outlined, color: Colors.white), '類別'),
                  _drawerWidgetCell(6, const Icon(Icons.add, color: Colors.white), '我的列表'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _drawerWidgetCell(0, const Icon(Icons.search, color: Colors.white), '搜索'),
                  _drawerWidgetCell(1, const Icon(Icons.home_outlined, color: Colors.white), '主頁'),
                  _drawerWidgetCell(2, const Icon(Icons.arrow_outward_outlined, color: Colors.white), '新鮮熱播'),
                  _drawerWidgetCell(3, const Icon(Icons.monitor, color: Colors.white), '劇集'),
                  _drawerWidgetCell(4, const Icon(Icons.movie_outlined, color: Colors.white), '電影'),
                  _drawerWidgetCell(5, const Icon(Icons.category_outlined, color: Colors.white), '類別'),
                  _drawerWidgetCell(6, const Icon(Icons.add, color: Colors.white), '我的列表'),
                ],
              ),
            ],
          ),
          // ),
        ),
      ],
    );
  }

  Widget _drawerWidgetCell(int index, Icon icon, String title) {
    return DrawerCellWidget(
      // requestFocus: index == 0,
      index: index,
      focusNode: widget.focusNodes[index],
      onFocusChange: (int index, bool hasFocus) {
        if (hasFocus) {
          log('Drawer cell $index, hasFocus: $hasFocus');
          // controller.isDrawerExpanded = true;
          // controller.drawerFocusNodes[0].requestFocus();
          controller.forward();
        } else {}
      },
      onClick: () {},
      onRightLeave: () {
        // controller.isDrawerExpanded = !controller.isDrawerExpanded;
      },
      child: Column(
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: isAnimationCompleted
                ? icon
                : Row(
                    children: [
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: icon),
                      Text(title, style: const TextStyle(color: Colors.white)),
                    ],
                  ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  const FlowMenuDelegate({required this.controller}) : super(repaint: controller);
  final Animation<double> controller;

  @override
  void paintChildren(FlowPaintingContext context) {
    final length = context.childCount;
    // for (int i = 0; i < length; i++) {
    //   final x = -(controller.value * 62.0) * (i + 2);
    //   context.paintChild(i, transform: Matrix4.identity()..translate(x, 0, 0));
    // }
    for (int i = 0; i < length; i++) {
      final x = (controller.value * 90.0);
      context.paintChild(i, transform: Matrix4.identity()..translate(x, 0, 0));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
