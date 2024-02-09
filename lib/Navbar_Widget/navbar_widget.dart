import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hit_api_two/navbar_widget/navbar_controller.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/heroicons.dart';

import '../Cart/cart_page.dart';
import '../Home/home_page.dart';

class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar({Key? key}) : super(key: key);

  final NavbarController navbarController = Get.put(NavbarController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
        currentIndex: navbarController.selectedIndex.value,
        onTap: (index) {
          navbarController.changeTabIndex(index);
          switch (index) {
            case 0:
              Get.to(() => HomePage());
              break;
            case 1:
              Get.to(() => CartPage());
              break;
            default:
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Iconify(Heroicons.home_solid, color: navbarController.selectedIndex.value == 0 ? Colors.blueAccent : Colors.grey),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Iconify(Carbon.favorite, color: navbarController.selectedIndex.value == 1 ? Colors.blueAccent : Colors.grey),
            label: "Favorite",
          ),
        ],
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
