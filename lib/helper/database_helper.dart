// import 'package:sqflite/sqflite.dart';
//
// import '../models/football_model.dart';
//
// class FavoriteDatabase {
//   static Database? _database;
//   static const String tableName = 'favorites';
//
//   static Future<void> initializeDatabase() async {
//     _database = await openDatabase(
//       'favorite_database.db',
//       version: 1,
//       onCreate: (db, version) {
//         db.execute(
//           'CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, teamKey TEXT, teamName TEXT, countryName TEXT, teamFounded INTEGER, teamBadge TEXT)',
//         );
//       },
//     );
//   }
//
//   static Future<void> insertFavorite(FootballResponseModel football) async {
//     await _database!.insert(
//       tableName,
//       football.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   static Future<void> deleteFavorite(String teamKey) async {
//     await _database!.delete(
//       tableName,
//       where: 'teamKey = ?',
//       whereArgs: [teamKey],
//     );
//   }
//
//   static Future<List<FootballResponseModel>> getFavorites() async {
//     final List<Map<String, dynamic>> maps = await _database!.query(tableName);
//     return List.generate(maps.length, (i) {
//       return FootballResponseModel(
//         teamKey: maps[i]['teamKey'],
//         teamName: maps[i]['teamName'],
//         teamCountry: maps[i]['teamCountry'],
//         teamFounded: maps[i]['teamFounded'],
//         teamBadge: maps[i]['teamBadge'],
//       );
//     });
//   }
// }
