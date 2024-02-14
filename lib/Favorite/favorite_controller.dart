import 'dart:io';

import 'package:get/get.dart';
import 'package:hit_api_two/Detail/detail_controller.dart';
import 'package:hit_api_two/Favorite/favorite_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/api_model.dart';
import '../pages/page.dart';

class FavoriteController extends GetxController {
  final DetailController controller = Get.put(DetailController());
  RxMap<int, bool> isStored = RxMap<int, bool>();
  Database? database;
  var isLoading = true.obs;

  Future<void> delete(int id) async {
    String table = "items";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_items";
    database = await openDatabase(path);

    try {
      await database!.delete(table, where: "id = ?", whereArgs: [id]);
      Get.snackbar("Pesan", "Item berhasil dihapus dari keranjang");
      Get.off(BlandPage());
      Get.off(FavoritePage());
      controller.isStored[id] = false;
      isStored[id] = false;
    } catch (e) {
      print("Error deleting data from the database: $e");
    }
  }

  Future<List<ApiModel>> getDataItem() async {
    isLoading.value = true;
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_items";
    database = await openDatabase(path);
    final data = await database!.query("items");
    List<ApiModel> product = data.map((e) => ApiModel.fromJson(e)).toList();
    return product;
  }
}