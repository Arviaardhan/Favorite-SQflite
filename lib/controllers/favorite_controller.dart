import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/football_model.dart';

class FavoriteController extends GetxController {
  RxList<FootballResponseModel> favorites = <FootballResponseModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadFavorites();
  }

  void addToFavorites(FootballResponseModel football) {
    favorites.add(football);
  }

  void removeFromFavorites(String teamKey) {
    favorites.removeWhere((element) => element.teamKey == teamKey);
  }

  bool isFavorite(String teamKey) {
    return favorites.any((element) => element.teamKey == teamKey);
  }

  Future<void> loadFavorites() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = directory.path + "db_football";

      Database database = await openDatabase(path);

      final List<Map<String, dynamic>> favoriteData = await database.query('db_football', where: 'favorite = ?', whereArgs: [1]);

      favorites.assignAll(favoriteData.map((data) => FootballResponseModel.fromJson(data)).toList());
      isLoading.value = false; // Perbarui isLoading menjadi false setelah data selesai dimuat
    } catch (e) {
      print("Error loading favorites: $e");
      isLoading.value = false; // Perbarui isLoading menjadi false jika terjadi kesalahan
    }
  }
}