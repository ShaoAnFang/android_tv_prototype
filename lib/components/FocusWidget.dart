import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/AudioService.dart';
import 'VideoPlayerPage/VideoPlayerPage.dart';

class FocusWidget extends StatefulWidget {
  FocusWidget({
    Key? key,
    required this.child,
    required this.focusChange,
    required this.onclick,
    this.decoration,
    this.requestFocus = false,
    this.isRightEdge = false,
    this.isLeftEdge = false,
    this.needScalTransition = false,
    this.focusNode,
  }) : super(key: key);

  Widget child;
  onFocusChange? focusChange;
  onClick onclick;
  bool requestFocus;
  BoxDecoration? decoration;
  bool isRightEdge;
  bool isLeftEdge;
  FocusNode? focusNode;
  bool needScalTransition;

  @override
  State<StatefulWidget> createState() {
    return FocusWidgetState();
  }
}

typedef void onFocusChange(bool hasFocus, FocusNode? focusNode);
typedef void onClick();
const String keyUp = 'Arrow Up';
const String keyDown = 'Arrow Down';
const String keyLeft = 'Arrow Left';
const String keyRight = 'Arrow Right';
const String keyCenter = 'Select';

class FocusWidgetState extends State<FocusWidget> {
  FocusNode focusNode = FocusNode();
  bool init = false;
  final defaultDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(2),
    border: Border.all(width: 2.5, color: Colors.white),
  );
  BoxDecoration? decoration;

  double scale = 1.0;

  EdgeInsets margin = const EdgeInsets.symmetric(vertical: 2, horizontal: 1.618);
  EdgeInsets padding = const EdgeInsets.symmetric(vertical: 1.5, horizontal: 1.5);

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) focusNode = widget.focusNode!;

    focusNode.addListener(() {
      if (widget.focusChange != null) {
        widget.focusChange!(focusNode.hasFocus, widget.isLeftEdge ? focusNode : null);
      }
      setState(() {
        if (widget.needScalTransition) {
          scale == 1 ? 1.618 : 1;
        } else {
          decoration = focusNode.hasFocus ? widget.decoration ?? defaultDecoration : null;
        }
        margin = EdgeInsets.symmetric(vertical: focusNode.hasFocus ? 1.382 : 1, horizontal: 1.618);
        padding = focusNode.hasFocus ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 1.5, horizontal: 1.5);
      });
      // if (focusNode.hasFocus) {
      //   setState(() {
      //     decoration = focusNode.hasFocus ? widget.decoration ?? defaultDecoration : null;
      //     margin = EdgeInsets.symmetric(vertical: focusNode.hasFocus ? 1.382 : 4, horizontal: 1.618);
      //     padding = focusNode.hasFocus ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 4, horizontal: 4);
      //   });
      // } else {
      //   setState(() {
      //     decoration = null;
      //     margin = const EdgeInsets.symmetric(vertical: 4, horizontal: 1.618);
      //     padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 4);
      //   });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.requestFocus && !init) {
    //   FocusScope.of(context).requestFocus(focusNode);
    //   init = true;
    // }
    return Focus(
        autofocus: widget.requestFocus,
        focusNode: focusNode,
        onKey: (FocusNode focusNode, RawKeyEvent event) {
          if (event is RawKeyUpEvent) return KeyEventResult.handled;
          AudioService().playSound(AssetSource('sounds/mixkit-modern-technology-select-3124.wav'));
          log("keyLabel: ${event.logicalKey.keyLabel}");
          switch (event.logicalKey.keyLabel) {
            case keyCenter:
              widget.onclick();
              break;
            case keyUp:
              FocusScope.of(context).focusInDirection(TraversalDirection.up);
              break;

            case keyDown:
              FocusScope.of(context).focusInDirection(TraversalDirection.down);
              break;

            case keyLeft:
              FocusScope.of(context).focusInDirection(TraversalDirection.left);
              break;
            case keyRight:
              if (widget.isRightEdge) return KeyEventResult.handled; //handled == 不處理
              FocusScope.of(context).focusInDirection(TraversalDirection.right);
              break;
          }
          return KeyEventResult.handled;
        },
        // RawKeyboardListener(
        // onKey: (RawKeyEvent event) {
        //   if (event is RawKeyDownEvent) {
        //     log("keyLabel: ${event.logicalKey.keyLabel}");
        // const String keyUp = 'Arrow Up';
        // const String keyDown = 'Arrow Down';
        // const String keyLeft = 'Arrow Left';
        // const String keyRight = 'Arrow Right';
        // const String keyCenter = 'Select';
        // }

        // if (event is RawKeyDownEvent && event.data is RawKeyEventDataAndroid) {
        //   RawKeyEventDataAndroid rawKeyEventDataAndroid = event.data as RawKeyEventDataAndroid;
        // log("keyCode: ${rawKeyEventDataAndroid.keyCode}");
        // switch (event.logicalKey.keyLabel) {
        //   case keyCenter:
        //     widget.onclick();
        //     break;
        //   case keyUp:
        //     FocusScope.of(context).focusInDirection(TraversalDirection.up);
        //     break;

        //   case keyDown:
        //     FocusScope.of(context).focusInDirection(TraversalDirection.down);
        //     break;

        //   case keyLeft:
        //     FocusScope.of(context).focusInDirection(TraversalDirection.left);
        //     break;
        //   case keyRight:
        //     FocusScope.of(context).focusInDirection(TraversalDirection.right);
        //     break;
        // }
        // switch (rawKeyEventDataAndroid.keyCode) {
        //   case 19: //KEY_UP
        //     // DefaultFocusTraversal.of(context).inDirection(
        //     // FocusScope.of(context).focusedChild, TraversalDirection.up);
        //     FocusScope.of(context).focusInDirection(TraversalDirection.up);
        //     break;
        //   case 20: //KEY_DOWN
        //     FocusScope.of(context).focusInDirection(TraversalDirection.down);
        //     break;
        //   case 21: //KEY_LEFT
        //     // FocusScope.of(context).requestFocus(focusNodeB0);
        //     FocusScope.of(context).focusInDirection(TraversalDirection.left);
        //     // 手动指定下一个焦点
        //     // FocusScope.of(context).requestFocus(focusNode);
        //     break;
        //   case 22: //KEY_RIGHT
        //     // FocusScope.of(context).requestFocus(focusNodeB1);
        //     FocusScope.of(context).focusInDirection(TraversalDirection.right);
        //     // DefaultFocusTraversal.of(context)
        //     // .inDirection(focusNode, TraversalDirection.right);
        //     // if(focusNode.nextFocus()){
        //     //    FocusScope.of(context)
        //     //  .focusInDirection(TraversalDirection.right);
        //     // }
        //     break;
        //   case 23: //KEY_CENTER
        //     widget.onclick();
        //     break;
        //   case 66: //KEY_ENTER
        //     widget.onclick();
        //     break;
        //   default:
        //     break;
        // }
        // }
        // },
        child: Container(margin: margin, padding: padding, decoration: decoration, child: Transform.scale(scale: scale, child: widget.child)));
  }
}
