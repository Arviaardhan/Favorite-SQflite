import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hit_api_two/Profile/profile_page.dart';
import 'package:hit_api_two/navbar_widget/navbar_controller.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/ri.dart';

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
            case 2:
              Get.to(() => ProfilePage());
            default:
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Obx(() => Iconify(
              // Change icon to home_solid when selected index is 0
              navbarController.selectedIndex.value == 0 ? AntDesign.home_fill : AntDesign.home_outline,
              color: navbarController.selectedIndex.value == 0 ? Color(0xFF4169E1) : Colors.grey,
            )),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Obx(() => Iconify(
              // Change icon to favorite_solid when selected index is 1
              navbarController.selectedIndex.value == 1 ? Ri.shopping_cart_fill : Ri.shopping_cart_line,
              color: navbarController.selectedIndex.value == 1 ? Color(0xFF4169E1) : Colors.grey,
            )),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Obx(() => Iconify(
              navbarController.selectedIndex.value == 2 ? Carbon.user_filled : Carbon.user,
              color: navbarController.selectedIndex.value == 2 ? Color(0xFF4169E1) : Colors.grey,
            )),
            label: "Profile",
          ),
        ],
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
