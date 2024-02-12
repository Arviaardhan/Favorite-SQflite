import 'dart:io';

import 'package:get/get.dart';
import 'package:hit_api_two/Cart/cart_page.dart';
import 'package:hit_api_two/pages/page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../Home/home_controller.dart';
import '../models/api_model.dart';

class CartController extends GetxController {

  final HomeController controller = Get.put(HomeController());
  RxMap<int, bool> isStored = RxMap<int, bool>();
  Database? database;
  var isLoading = true.obs;

  Future<void> delete(int id) async {
    String table = "item";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_item";
    database = await openDatabase(path);

    try {
      await database!.delete(table, where: "id = ?", whereArgs: [id]);
      Get.snackbar("Pesan", "Item berhasil dihapus dari keranjang");
      Get.off(BlandPage());
      Get.off(CartPage());
      controller.isStored[id] = false;
      isStored[id] = false;
    } catch (e) {
      print("Error deleting data from the database: $e");
    }
  }

  Future<List<ApiModel>> getDataItem() async {
    isLoading.value = true;
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_item";
    database = await openDatabase(path);
    final data = await database!.query("item");
    List<ApiModel> product = data.map((e) => ApiModel.fromJson(e)).toList();
    return product;
  }
}