import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hit_api_two/controllers/football_controller.dart';
import 'package:hit_api_two/helper/themes.dart';
import 'package:hit_api_two/navbar_widget/navbar_widget.dart';

class HomePage extends StatelessWidget {
  final FootballController footballController = Get.put(FootballController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return footballController.isLoading.value
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: footballController.footballresponsemodel.length,
          itemBuilder: (BuildContext context, int index) {
            var football = footballController.footballresponsemodel[index];
            return Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Card(
                surfaceTintColor: Colors.white,
                margin: EdgeInsets.only(left: 30, right: 30),
                elevation: 4,
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        child: Image.network(
                          football.teamBadge ?? "",
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(football.teamName ?? "",
                                  style: titleStyle),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text(
                                  football.getCountryName() ?? "",
                                  style: descStyle),
                            ),
                            Text('Formed : ${football.teamFounded ?? ""}',
                                style: descStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 40),
                                  child: IconButton(
                                    onPressed: () {
                                    },
                                    icon: football.isFavorite
                                        ? Icon(Icons.favorite,
                                        color: Colors.red)
                                        : Icon(Icons.favorite_border),
                                  ),
                                ),
                              ],
                            )
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
      }),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
