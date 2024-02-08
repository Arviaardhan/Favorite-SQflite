import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hit_api_two/controllers/home_controller.dart';
import 'package:hit_api_two/helper/themes.dart';
import 'package:hit_api_two/navbar_widget/navbar_widget.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';

import '../controllers/favorite_controller.dart';
import '../models/football_model.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: controller.apiModel.length,
            itemBuilder: (BuildContext context, int index) {
              var product = controller.apiModel[index];
              return Container(
                height: 500,
                margin: EdgeInsets.only(bottom: 20),
                child: Card(
                  surfaceTintColor: Colors.white,
                  margin: EdgeInsets.only(left: 15, right: 15),
                  elevation: 4,
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, left: 130),
                          child: Obx(() => InkWell(
                            child: Icon(
                                size: 25,
                                controller.isStored[product.id] == true
                                    ? Icons.shopping_cart
                                    : Icons.add_shopping_cart
                            ),
                            onTap: () {
                              controller.saveDataToLocalDatabase(product, context);
                            },
                          )),
                        ),
                        Container(
                          width: 90, // Adjust the width as needed
                          child: Image.network(
                            product.image ?? "",
                            height: 110,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, right: 5),
                          child: Text(product.title, overflow: TextOverflow.ellipsis, style: titleStyle,),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
