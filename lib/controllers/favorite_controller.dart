import 'dart:io';

import 'package:get/get.dart';
import 'package:hit_api_two/pages/favorite_page.dart';
import 'package:hit_api_two/pages/page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/football_model.dart';

class CartController extends GetxController {
  Database? database;
  var isLoading = true.obs;
  RxMap<int, bool> isStored = RxMap<int, bool>();

  void initDatabase() async {
    String db_name = "db_product";
    int db_version = 1;
    String table = "product";
    String id = "idColumn";
    String idProduct = "id";
    String title = "title";
    String image = "image";
    String price = "price";
    String description = "description";
    String favorite = "favorite";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + db_name;

    if (database == null) {
      database = await openDatabase(path, version: db_version, onCreate: (db, version) {
        print(path);
        db.execute('''
        CREATE TABLE IF NOT EXISTS $table (
              $id INTEGER PRIMARY KEY,
              $idProduct INTEGER,
              $title VARCHAR(255),
              $image VARCHAR(255),
              $price MEDIUMINT,
              $description VARCHAR(255),
              $favorite INTEGER DEFAULT 0
            )''');
      });
    }
  }

  Future<void> delete(int id) async {
    String table = "product";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_product";
    database = await openDatabase(path);

    // SnackBar(content: Text("Item berhasil di hapus"));
    try {
      await database!.delete(table, where: "id = ?", whereArgs: [id]);
      Get.snackbar("Pesan", "Item berhasil dihapus dari keranjang");
      Get.off(Page());
      Get.off(CartPage());
      isStored[id] = false;
    } catch (e) {
      print("Error deleting data from the database: $e");
    }
  }

  Future<List<ApiModel>> getDataProduct() async {
    String table = "product";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_product";
    database = await openDatabase(path);
    final data = await database!.query(table);
    List<ApiModel> product = data.map((e) => ApiModel.fromJson(e)).toList();
    return product;
  }

}