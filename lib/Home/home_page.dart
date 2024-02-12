import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hit_api_two/Detail/detail_page.dart';
import 'package:hit_api_two/Helper/themes.dart';
import 'package:hit_api_two/Home/home_controller.dart';
import 'package:hit_api_two/navbar_widget/navbar_widget.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomePage({Key? key}) : super(key: key);

  Future<void> _refresh() async {
    controller.fetchItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: controller.apiModel.length,
              itemBuilder: (BuildContext context, int index) {
                final product = controller.apiModel[index];
                return Container(
                  height: 500,
                  margin: EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(item: product)));
                    },
                    child: Card(
                      surfaceTintColor: Colors.white,
                      margin: EdgeInsets.only(left: 15, right: 15),
                      elevation: 4,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Column(
                          children: [
                            Container(
                              width: 90, // Adjust the width as needed
                              child: Image.network(
                                product.image ?? "",
                                height: 110,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                              child: Text(product.title, overflow: TextOverflow.ellipsis, style: titleStyle,),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('\$ ${product.price.toStringAsFixed(2)}', style: priceStyleHome,),
                                  Obx(() => InkWell(
                                    child: Icon(
                                      controller.isStored[product.id] == true ? Icons.shopping_cart : Icons.add_shopping_cart,
                                      size: 25,
                                      color: controller.isStored[product.id] == true ? Colors.black : Colors.grey, // Ganti warna sesuai kondisi
                                    ),
                                    onTap: () {
                                      controller.saveDataToLocalDatabase(product, context);
                                    },
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
