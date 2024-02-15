
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hit_api_two/models/api_model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DetailController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ApiModel> apiModel = <ApiModel>[].obs;
  Database? database;
  RxMap<int, bool> isStored = RxMap<int, bool>();

  @override
  void onInit() {
    super.onInit();
    fetchItem();
    initDatabase();
  }

  void fetchItem() async {
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        apiModel.value = apiModelFromJson(response.body);
        await updateIsStoredFromDatabase();
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  void initDatabase() async {
    String db_name = "db_items";
    int db_version = 1;
    String table = "items";
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
              $id INTEGER PRIMARY KEY ,
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

  void saveDataToLocalDatabase(ApiModel itemModel, BuildContext context) async {
    String table = "items";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_items";
    database = await openDatabase(path);
    List<Map<String, dynamic>> existingData = await database!.query(table, where: "id = ?", whereArgs: [itemModel.id],);
    try {
      if(existingData.isEmpty){
        Map<String, dynamic> itemData = itemModel.toJson();
        itemData['favorite'] = true;
        await database!.insert(table, itemData);
        Get.snackbar("Pesan", "Item berhasil ditambahkan di favorite");
        print(itemModel.toJson());
        isStored[itemModel.id] = true;
      }
    } catch (e) {
      print("Error inserting data into the database: $e");
    }
  }

  Future<void> removeDataFromLocalDatabase(int id) async {
    String table = "items";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_items";
    database = await openDatabase(path);

    try {
      await database!.delete(table, where: "id = ?", whereArgs: [id]);
      Get.snackbar("Pesan", "Item berhasil dihapus dari favorit");
      isStored[id] = false;
    } catch (e) {
      print("Error deleting data from the database: $e");
    }
  }


  Future<void> updateIsStoredFromDatabase() async {
    String table = "items";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_items";
    database = await openDatabase(path);

    List<Map<String, dynamic>> userData = await database!.query(table);
    userData.forEach((row) {
      int id = row['id'];
      bool favorite = row['favorite'] == 1;
      isStored[id] = favorite;
    });
  }
}
