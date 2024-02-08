import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  var isFavoriteIconFilled = false.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}