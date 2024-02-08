
import 'package:get/get.dart';
import 'package:hit_api_two/controllers/favorite_controller.dart';
import 'package:http/http.dart' as http;
import 'package:hit_api_two/models/football_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class FootballController extends GetxController {
  var isLoading = true.obs;
  RxBool isFavorite = false.obs;
  Database? database;
  RxList<FootballResponseModel> footballresponsemodel = <FootballResponseModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchFootball();
    super.onInit();
  }
  
  void fetchFootball () async {
    try {
      final response = await http.get(Uri.parse('https://apiv3.apifootball.com/?action=get_teams&league_id=302&APIkey=f16a977a7cea7d201f41a1d6fd69fdaaf4e58bf54b94e286053046e4f65210db'));
      if (response.statusCode == 200) {
        footballresponsemodel.value = footballResponseModelFromJson(response.body);
        isLoading(false);
      } else {
        print('Error : ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }
}