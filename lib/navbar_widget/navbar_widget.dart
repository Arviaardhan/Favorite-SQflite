import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hit_api_two/navbar_widget/navbar_controller.dart';
import 'package:hit_api_two/pages/favorite_page.dart';
import 'package:hit_api_two/pages/home.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/heroicons.dart';

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
              Get.to(() => FavoritePage());
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
