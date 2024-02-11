import 'package:get/get.dart';
import 'package:hit_api_two/Home/home_page.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3));
    Get.off(HomePage());
  }
}