
import 'package:get/get.dart';
import 'package:hit_api_two/models/api_model.dart';
import 'package:http/http.dart' as http;

class DetailController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ApiModel> apiModel = <ApiModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchItem();
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
}
