import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hit_api_two/controllers/favorite_controller.dart';
import 'package:hit_api_two/helper/themes.dart';
import 'package:hit_api_two/models/football_model.dart';
import 'package:hit_api_two/navbar_widget/navbar_widget.dart';

class CartPage extends StatelessWidget {
  final CartController controller = Get.put(CartController());

  CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ApiModel>>(
        future: controller.getDataProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ApiModel product = snapshot.data![index];
                return Container(
                  margin: EdgeInsets.all(15),
                  child: Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          child: Container(
                              padding: EdgeInsets.all(30),
                              alignment: Alignment.topRight,
                              child: Icon(Icons.delete_forever)
                          ),
                          onTap: () async {
                            await controller.delete(product.id);
                          },
                        ),
                        Text("data"),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white
                          ),
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          // Set the background color of the inner container
                          child: Text(
                              product.title,
                              style: titleStyle
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("Tidak Ada Data"));
          }
        },
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
