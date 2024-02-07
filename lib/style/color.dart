import 'package:flutter/material.dart';

// class AppColor {
/// 背景颜色 Color(0xff283953)
const Color scaffoldBackground = Color(0xff283953); //4F7EC5

/// 背景主色
const Color primaryBG = Color(0xff283953);

const Color textFieldBG = Color(0xffEEF2FA);

/// 文字主色
const Color primaryText = Color(0xffEEF2FA); // Color(0xff4F7EC5);

const Color secondaryText = Colors.white;

const Color thirdText = Color(0xff516484);

const Color dolorTextColor = Color.fromRGBO(214, 174, 60, 1);

const Color pinkColor = Color.fromRGBO(226, 159, 173, 1);

const Color productTagColor = Color.fromRGBO(214, 174, 60, 1);
// /// 次要文本颜色
// static const Color secondaryText = Color(0xFF74788D);

// /// 高亮颜色
// static const Color accentColor = Color(0xFF5C78FF);

// /// 次要颜色
// static const Color secondaryColor = Color(0xFFDEE3FF);

// /// 警告颜色
// static const Color warnColor = Color(0xFFFFB822);

// /// 边框颜色
// static const Color borderColor = Color(0xFFDEE3FF);

// static const Color pinkColor = Color(0xFFF77866);

// static const Color yellowColor = Color(0xFFFFB822);

// }

const titleTextStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: primaryText);

const staticRadius = BorderRadius.all(Radius.circular(12));

final staticBoxShadow = [
  BoxShadow(color: Colors.transparent),
  // BoxShadow(
  //   color: Colors.grey.withOpacity(0.7),
  //   spreadRadius: 2,
  //   blurRadius: 2,
  //   offset: const Offset(2, 2),
  //
];

const linearGradientBG = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color.fromRGBO(245, 234, 219, 0.2),
    Color.fromRGBO(245, 234, 219, 0.6),
    Color.fromRGBO(201, 211, 226, 1),
  ],
);

const linearGradientAlertBG = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color.fromRGBO(16, 22, 33, 0.2),
    Color.fromRGBO(244, 235, 220, 0.0),
    Color.fromRGBO(244, 235, 220, 0.0),
    Color.fromRGBO(16, 22, 33, 0.2),
  ],
);

const selectGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color.fromRGBO(235, 213, 202, 1),
    Color.fromRGBO(252, 205, 202, 1),
    Color.fromRGBO(252, 205, 191, 1),
    Color.fromRGBO(251, 204, 176, 1),
    Color.fromRGBO(246, 196, 170, 1),
    Color.fromRGBO(226, 159, 173, 1),
    Color.fromRGBO(226, 159, 173, 1),
  ],
  // [
  //   Color.fromRGBO(254, 254, 254, 1),
  //   Color.fromRGBO(253, 233, 232, 1),
  //   Color.fromRGBO(250, 210, 207, 1),
  //   Color.fromRGBO(246, 183, 191, 1),
  //   Color.fromRGBO(242, 153, 173, 1),
  //   Color.fromRGBO(238, 127, 158, 1),
  //   Color.fromRGBO(233, 98, 141, 1),
  // ],
);

const unSelectCashTextColor = Color.fromRGBO(102, 102, 102, 1);
const unSelectGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color.fromRGBO(208, 215, 221, 1),
    Color.fromRGBO(208, 215, 221, 1),
    Color.fromRGBO(207, 213, 219, 1),
    Color.fromRGBO(207, 213, 219, 1),
    Color.fromRGBO(184, 190, 197, 1),
    Color.fromRGBO(163, 170, 176, 1),
  ],
  // [
  //   Color.fromRGBO(255, 255, 255, 1),
  //   Color.fromRGBO(183, 183, 183, 1),
  //   Color.fromRGBO(158, 158, 158, 1),
  //   Color.fromRGBO(138, 138, 138, 1),
  //   Color.fromRGBO(118, 118, 118, 1),
  // ],
);
// }
