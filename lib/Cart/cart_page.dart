import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hit_api_two/Cart/cart_controller.dart';
import 'package:hit_api_two/models/api_model.dart';
import 'package:hit_api_two/navbar_widget/navbar_widget.dart';

import '../Helper/themes.dart';

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
            return ListView.builder (
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                ApiModel item = snapshot.data![index];
                int quantity = 1;
                double totalPrice = item.price;
                return Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 80,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Warna bayangan kotak
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(0, 2), // Atur posisi bayangan kotak
                            ),
                          ],
                        ),
                        child: Image.network(
                          item.image ?? "",
                          height: 110,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title, overflow: TextOverflow.ellipsis, style: titleStyle),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (quantity > 1) {
                                        quantity--;
                                        totalPrice -= item.price;
                                      }
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                  Text('$quantity'),
                                  IconButton(
                                    onPressed: () {
                                      quantity++;
                                      totalPrice += item.price;
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              ),
                              Text('\$ ${totalPrice.toStringAsFixed(2)}', style: priceStyleHome),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          await controller.delete(item.id);
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                    Divider(),
                  ],
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
