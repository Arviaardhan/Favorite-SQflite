import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hit_api_two/Cart/cart_controller.dart';
import 'package:hit_api_two/helper/themes.dart';
import 'package:hit_api_two/models/api_model.dart';
import 'package:hit_api_two/navbar_widget/navbar_widget.dart';

class CartPage extends StatelessWidget {
  final CartController controller = Get.put(CartController());

  CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ApiModel>>(
        future: controller.getDataItem(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                ApiModel item = snapshot.data![index];
                return Container(
                  height: 500,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Card(
                    surfaceTintColor: Colors.white,
                    margin: EdgeInsets.only(left: 15, right: 15),
                    elevation: 4,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10, left: 130),
                            child: InkWell(
                              child: Container(
                                  alignment: Alignment.topRight,
                                  child: Icon(Icons.delete_outline_rounded)
                              ),
                              onTap: () async {
                                await controller.delete(item.id);
                              },
                            ),
                          ),
                          Container(
                            width: 90, // Adjust the width as needed
                            child: Image.network(
                              item.image ?? "",
                              height: 110,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 11, right: 5),
                            child: Text(item.title, overflow: TextOverflow.ellipsis, style: titleStyle,),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("Tidak Ada Data", style: titleStyle,));
          }
        },
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
