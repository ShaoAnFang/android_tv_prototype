import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class TextToast {
  static show(String content) {
    Fluttertoast.showToast(
      msg: content,
      timeInSecForIosWeb: 3,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }

  static showIfSuccess(bool isSuccess) {
    Fluttertoast.showToast(
      msg: isSuccess ? "succeed".tr : "fail".tr,
      timeInSecForIosWeb: 3,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }

  static showGift(String content) {
    Fluttertoast.showToast(
      msg: content,
      timeInSecForIosWeb: 4,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
