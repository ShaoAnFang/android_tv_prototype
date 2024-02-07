import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/AudioService.dart';

class DrawerCellWidget extends StatefulWidget {
  DrawerCellWidget({
    Key? key,
    required this.index,
    required this.child,
    required this.onFocusChange,
    required this.onClick,
    required this.onRightLeave,
    this.decoration,
    this.requestFocus = false,
    this.focusNode,
  }) : super(key: key);

  int index;
  Widget child;
  Function(int index, bool hasFocus)? onFocusChange;
  Function onClick;
  Function onRightLeave;
  bool requestFocus;
  BoxDecoration? decoration;
  FocusNode? focusNode;

  @override
  State<DrawerCellWidget> createState() {
    return DrawerCellWidgetState();
  }
}

const String keyUp = 'Arrow Up';
const String keyDown = 'Arrow Down';
const String keyLeft = 'Arrow Left';
const String keyRight = 'Arrow Right';
const String keyCenter = 'Select';

class DrawerCellWidgetState extends State<DrawerCellWidget> {
  FocusNode focusNode = FocusNode();
  bool init = false;
  final defaultDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(2),
    border: Border.all(width: 2.5, color: Colors.white),
  );
  BoxDecoration? decoration;

  EdgeInsets margin = const EdgeInsets.symmetric(vertical: 2, horizontal: 1.618);
  EdgeInsets padding = const EdgeInsets.symmetric(vertical: 1.5, horizontal: 1.5);

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) focusNode = widget.focusNode!;

    focusNode.addListener(() {
      if (widget.onFocusChange != null) {
        widget.onFocusChange!(widget.index, focusNode.hasFocus);
      }
      if (mounted) {
        setState(() {
          decoration = focusNode.hasFocus ? widget.decoration ?? defaultDecoration : null;
          margin = EdgeInsets.symmetric(vertical: focusNode.hasFocus ? 1.382 : 1, horizontal: 1.618);
          padding = focusNode.hasFocus ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 1.5, horizontal: 1.5);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
        focusNode: focusNode,
        onKey: (FocusNode focusNode, RawKeyEvent event) {
          if (event is RawKeyUpEvent) return KeyEventResult.handled;
          AudioService().playSound(AssetSource('sounds/mixkit-modern-technology-select-3124.wav'));
          log("keyLabel: ${event.logicalKey.keyLabel}");
          switch (event.logicalKey.keyLabel) {
            case keyCenter:
              widget.onClick();
              break;
            case keyUp:
              if (widget.index == 0) return KeyEventResult.handled;
              FocusScope.of(context).focusInDirection(TraversalDirection.up);
              break;
            case keyDown:
              if (widget.index == 6) return KeyEventResult.handled;
              FocusScope.of(context).focusInDirection(TraversalDirection.down);
              break;
            case keyLeft:
              return KeyEventResult.handled;
            case keyRight:
              // widget.onFocusChange!(widget.index, focusNode.hasFocus);
              widget.onRightLeave();
            // FocusScope.of(context).focusInDirection(TraversalDirection.right);
            // return KeyEventResult.handled;
          }
          return KeyEventResult.handled;
          // return KeyEventResult.ignored;
        },
        child: Container(margin: margin, padding: padding, decoration: decoration, child: widget.child));
  }

  @override
  void dispose() {
    focusNode.removeListener(() {});
    super.dispose();
  }
}
