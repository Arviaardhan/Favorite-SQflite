import 'package:get/get.dart';
import '../models/football_model.dart';

class FavoriteController extends GetxController {
  var isLoading = true.obs;
  RxList<FootballResponseModel> favorites = <FootballResponseModel>[].obs;

  void addToFavorites(FootballResponseModel football) {
    if (!favorites.contains(football)) {
      favorites.add(football);
    }
  }
}