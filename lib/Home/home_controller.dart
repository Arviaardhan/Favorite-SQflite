import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hit_api_two/models/api_model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  Database? database;
  RxBool isLoading = false.obs;
  RxMap<int, bool> isStored = RxMap<int, bool>();
  RxList<ApiModel> apiModel = <ApiModel>[].obs;

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
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  void initDatabase() async {
    String db_name = "db_item";
    int db_version = 1;
    String table = "item";
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
    String table = "item";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_item";
    database = await openDatabase(path);
    List<Map<String, dynamic>> existingData = await database!.query(table, where: "id = ?", whereArgs: [itemModel.id],);
    try {
      if(existingData.isEmpty){
        Map<String, dynamic> itemData = itemModel.toJson();
        itemData['favorite'] = true;
        await database!.insert(table, itemData);
        Get.snackbar("Pesan", "Item berhasil dimasukkan ke keranjang");
        print(itemModel.toJson());
        isStored[itemModel.id] = true;
      }else{
        Get.snackbar("Pesan", "Item sudah ada di keranjang");
        isStored[itemModel.id] = true;
      }
    } catch (e) {
      print("Error inserting data into the database: $e");
    }
  }

  Future<void> updateIsStoredFromDatabase() async {
    String table = "item";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_item";
    database = await openDatabase(path);

    List<Map<String, dynamic>> userData = await database!.query(table);
    userData.forEach((row) {
      int id = row['id'];
      bool favorite = row['favorite'] == 1;
      isStored[id] = favorite;
    });
  }
}
