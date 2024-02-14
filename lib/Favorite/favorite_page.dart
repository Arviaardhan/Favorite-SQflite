import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hit_api_two/Favorite/favorite_controller.dart';

import '../Helper/themes.dart';
import '../models/api_model.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({Key? key}) : super(key: key);

  final controller = Get.put(FavoriteController());

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
                      margin: EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Container(
                            width: 90, // Adjust the width as needed
                            child: Image.network(
                              item.image ?? "",
                              height: 110,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                            child: Text(item.title, overflow: TextOverflow.ellipsis, style: titleStyle,),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('\$ ${item.price.toStringAsFixed(2)}', style: priceStyleHome,),
                                InkWell(
                                  child: Container(
                                      alignment: Alignment.topRight,
                                      child: Icon(Icons.delete, color: Colors.red,)
                                  ),
                                  onTap: () async {
                                    await controller.delete(item.id);
                                  },
                                ),
                              ],
                            ),
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
    );
  }
}
