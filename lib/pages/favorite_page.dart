import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hit_api_two/controllers/favorite_controller.dart';
import 'package:hit_api_two/controllers/football_controller.dart';
import 'package:hit_api_two/helper/themes.dart';
import 'package:hit_api_two/navbar_widget/navbar_widget.dart';

class FavoritePage extends StatelessWidget {
  final FavoriteController favoriteController = Get.put(FavoriteController());

  FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => ListView.builder(
          itemCount: favoriteController.favorites.length,
          itemBuilder: (context, index) {
            var football = favoriteController.favorites[index];
            return ListTile(
              title: Text(football.teamName ?? ""),
              // Tambahkan widget lain seperti badge, dll. sesuai kebutuhan
            );
          },
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
