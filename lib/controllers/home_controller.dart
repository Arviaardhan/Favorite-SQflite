import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

import '../models/football_model.dart';

class HomeController extends GetxController {
  Database? database;
  RxBool isLoading = false.obs;
  RxMap<int, bool> isStored = RxMap<int, bool>();
  RxList<ApiModel> apiModel = <ApiModel>[].obs;

  @override
  void onInit() {
    fetchFootball();
    initDatabase();
    super.onInit();
  }

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
      database = await openDatabase(path, version: db_version,
          onCreate: (db, version) {print(path);
        db.execute('''
        CREATE TABLE IF NOT EXISTS $table (
        $id INTEGER PRIMARY KEY,
        $idProduct INTEGER,
        $title TEXT,
        $image TEXT,
        $price REAL,
        $description TEXT,
        $favorite INTEGER DEFAULT 0
        )''');
      });
    }
  }

  // Fetch football data
  void fetchFootball() async {
    isLoading.value = true;

    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        apiModel.value = apiModelFromJson(response.body);
        isLoading.value = false;
      } else {
        print('Error : ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  // Save data to local database
  void saveDataToLocalDatabase(
      ApiModel productModel, BuildContext context) async {
    String table = "product";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_product";
    database = await openDatabase(path);
    List<Map<String, dynamic>> existingData = await database!.query(
      table,
      where: "id = ?",
      whereArgs: [productModel.id],
    );
    try {
      if (existingData.isEmpty) {
        Map<String, dynamic> userData = productModel.toJson();
        userData['favorite'] = true;
        await database!.insert(table, userData);
        Get.snackbar("Pesan", "Item berhasil dimasukkan ke keranjang");
        print(productModel.toJson());
        isStored[productModel.id] = true;
      } else {
        Get.snackbar("Pesan", "Item sudah ada di keranjang");
        isStored[productModel.id] = true;
      }
    } catch (e) {
      print("Error inserting data into the database: $e");
    }
  }

  Future<void> updateIsStoredFromDatabase() async {
    String table = "product";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_product";
    database = await openDatabase(path);

    List<Map<String, dynamic>> userData = await database!.query(table);
    // Update isStored map based on favorite status retrieved from the database
    userData.forEach((row) {
      int id = row['id'];
      bool favorite = row['favorite'] == 1;
      isStored[id] = favorite;
    });
  }
}
