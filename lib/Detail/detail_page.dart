import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hit_api_two/Detail/detail_controller.dart';
import 'package:hit_api_two/Helper/themes.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ion.dart';

import 'package:hit_api_two/models/api_model.dart';

class DetailPage extends StatelessWidget {
  final ApiModel item;
  DetailPage({required this.item});

  final controller = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail Product'),
          centerTitle: true,
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
          leading: IconButton(
            icon: Iconify(
              Ion.chevron_back_circle,
              size: 28,
            ),
            onPressed: () {Navigator.pop(context);},
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                child: Image.network(
                  item.image ?? "",
                  width: 450,
                  height: 450,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)
                      ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                  item.title ?? "",
                                  style: titleTextDetail,
                                )
                            ),
                            SizedBox(width: 20,),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text('\$ ${item.price.toStringAsFixed(2)}', style: priceStyle,)
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(item.description, style: descStyle,),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
